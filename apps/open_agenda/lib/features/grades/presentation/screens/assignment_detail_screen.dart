import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:open_agenda_core/open_agenda_core.dart';

import '../providers/grades_providers.dart';

class AssignmentDetailScreen extends ConsumerStatefulWidget {
  final String assignmentId;

  const AssignmentDetailScreen({super.key, required this.assignmentId});

  @override
  ConsumerState<AssignmentDetailScreen> createState() =>
      _AssignmentDetailScreenState();
}

class _AssignmentDetailScreenState
    extends ConsumerState<AssignmentDetailScreen> {
  final Map<String, TextEditingController> _scoreControllers = {};

  @override
  void dispose() {
    for (final c in _scoreControllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final assignmentRepo = ref.watch(assignmentRepositoryProvider);
    final studentsAsync = ref.watch(allStudentsProvider);
    final gradesAsync =
        ref.watch(gradeEntriesForAssignmentProvider(widget.assignmentId));

    return FutureBuilder<Assignment?>(
      future: assignmentRepo.getById(widget.assignmentId),
      builder: (context, snapshot) {
        final assignment = snapshot.data;
        if (assignment == null && snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }
        if (assignment == null) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: Text('Assignment not found')),
          );
        }

        return Scaffold(
          appBar: AppBar(title: Text(assignment.title)),
          body: Column(
            children: [
              // Assignment info header
              Padding(
                padding: const EdgeInsets.all(16),
                child: GlassCard(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(assignment.subject,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                        color: AppColors.neonCyan)),
                            Text(
                              '${assignment.category.name} · ${DateFormat.yMMMd().format(assignment.dueDate)} · ${assignment.totalPoints.toInt()} pts',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Grade entry list
              Expanded(
                child: studentsAsync.when(
                  loading: () => const ShimmerList(),
                  error: (e, _) => ErrorState(message: e.toString()),
                  data: (students) {
                    // Build map of existing grades
                    final gradeMap = <String, GradeEntry>{};
                    gradesAsync.whenData((grades) {
                      for (final g in grades) {
                        gradeMap[g.studentId] = g;
                      }
                    });

                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: students.length,
                      itemBuilder: (context, index) {
                        final student = students[index];
                        final existing = gradeMap[student.id];
                        final controller = _scoreControllers.putIfAbsent(
                          student.id,
                          () => TextEditingController(
                            text: existing?.pointsEarned
                                    .toStringAsFixed(1) ??
                                '',
                          ),
                        );

                        final score = double.tryParse(controller.text);
                        final pct = score != null && assignment.totalPoints > 0
                            ? score / assignment.totalPoints * 100
                            : null;
                        final scoreColor = pct != null
                            ? (pct >= 80
                                ? AppColors.neonGreen
                                : pct >= 60
                                    ? AppColors.neonOrange
                                    : AppColors.neonPink)
                            : AppColors.textTertiary;

                        return GlassCard(
                          margin: const EdgeInsets.symmetric(vertical: 3),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(student.fullName,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium),
                              ),
                              SizedBox(
                                width: 80,
                                child: TextField(
                                  controller: controller,
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: true),
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    hintText: '—',
                                    isDense: true,
                                    contentPadding:
                                        const EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 8),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(8),
                                    ),
                                  ),
                                  onChanged: (_) => setState(() {}),
                                ),
                              ),
                              const SizedBox(width: 12),
                              SizedBox(
                                width: 48,
                                child: Text(
                                  pct != null
                                      ? '${pct.toInt()}%'
                                      : '—',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: scoreColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),

              // Save button
              Padding(
                padding: const EdgeInsets.all(16),
                child: NeonButton(
                  text: 'Save Grades',
                  onPressed: () => _saveGrades(ref),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _saveGrades(WidgetRef ref) async {
    final gradeRepo = ref.read(gradeEntryRepositoryProvider);
    final existingGrades = await gradeRepo.getByAssignment(widget.assignmentId);
    final existingMap = <String, GradeEntry>{};
    for (final g in existingGrades) {
      existingMap[g.studentId] = g;
    }

    for (final entry in _scoreControllers.entries) {
      final studentId = entry.key;
      final score = double.tryParse(entry.value.text);
      if (score == null) continue;

      final existing = existingMap[studentId];
      final id = existing?.id ?? const Uuid().v4();
      await gradeRepo.save(
        id,
        GradeEntry(
          id: id,
          studentId: studentId,
          assignmentId: widget.assignmentId,
          pointsEarned: score,
          gradedAt: DateTime.now(),
        ),
      );
    }

    ref.invalidate(gradeEntriesForAssignmentProvider(widget.assignmentId));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Grades saved')),
      );
    }
  }
}
