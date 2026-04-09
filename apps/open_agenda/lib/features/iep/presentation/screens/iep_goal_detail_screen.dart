import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:open_agenda_core/open_agenda_core.dart';
import 'package:printing/printing.dart';

import '../providers/iep_providers.dart';

class IEPGoalDetailScreen extends ConsumerWidget {
  final String goalId;

  const IEPGoalDetailScreen({super.key, required this.goalId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goalAsync = ref.watch(iepGoalByIdProvider(goalId));
    final notesAsync = ref.watch(progressNotesForGoalProvider(goalId));
    final studentsAsync = ref.watch(allStudentsProvider);

    return goalAsync.when(
      loading: () =>
          const Scaffold(body: Center(child: ShimmerCard(height: 200))),
      error: (e, _) => Scaffold(
        appBar: AppBar(),
        body: ErrorState(
          message: e.toString(),
          onRetry: () => ref.invalidate(iepGoalByIdProvider(goalId)),
        ),
      ),
      data: (goal) {
        if (goal == null) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: Text('Goal not found')),
          );
        }

        String studentName = 'Student';
        studentsAsync.whenData((students) {
          final s =
              students.where((s) => s.id == goal.studentId).firstOrNull;
          if (s != null) studentName = s.fullName;
        });

        return Scaffold(
          appBar: AppBar(
            title: Text(goal.category),
            actions: [
              IconButton(
                icon: const Icon(Icons.picture_as_pdf),
                tooltip: 'Export IEP Report',
                onPressed: () async {
                  Student? student;
                  studentsAsync.whenData((students) {
                    student = students
                        .where((s) => s.id == goal.studentId)
                        .firstOrNull;
                  });
                  if (student == null) return;

                  final goals = await ref
                      .read(iepGoalRepositoryProvider)
                      .getAll()
                      .then((all) => all
                          .where((g) => g.studentId == goal.studentId)
                          .toList());

                  final allNotes = <IEPProgressNote>[];
                  for (final g in goals) {
                    final notes = await ref
                        .read(iepProgressNoteRepositoryProvider)
                        .getByGoal(g.id);
                    allNotes.addAll(notes);
                  }

                  final doc = PdfExportService.generateIEPProgressReport(
                    student: student!,
                    goals: goals,
                    notes: allNotes,
                  );
                  await Printing.layoutPdf(
                    onLayout: (_) => doc.save(),
                    name: 'IEP_Report_${student!.fullName}',
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => context.push('/iep/${goal.id}/edit'),
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Goal info
              GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(studentName,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: AppColors.iepColor)),
                    const SizedBox(height: 8),
                    Text(goal.goalText,
                        style: Theme.of(context).textTheme.bodyLarge),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        _Chip(goal.category, AppColors.iepColor),
                        const SizedBox(width: 8),
                        _Chip(goal.status.name.toUpperCase(),
                            _statusColor(goal.status)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Target: ${DateFormat.yMMMd().format(goal.targetDate)}',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),

              // Progress
              GlassCard(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Progress',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(
                                color: AppColors.neonGreen,
                                fontWeight: FontWeight.w600)),
                    const SizedBox(height: 12),
                    Center(
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            CircularProgressIndicator(
                              value: goal.progressPercent / 100,
                              strokeWidth: 8,
                              backgroundColor: AppColors.darkElevated,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                goal.progressPercent >= 80
                                    ? AppColors.neonGreen
                                    : goal.progressPercent >= 50
                                        ? AppColors.neonCyan
                                        : AppColors.neonOrange,
                              ),
                            ),
                            Center(
                              child: Text(
                                '${goal.progressPercent.toInt()}%',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Accommodations
              if (goal.accommodations.isNotEmpty)
                GlassCard(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Accommodations',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(
                                  color: AppColors.accommodationColor,
                                  fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      ...goal.accommodations.map((a) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Row(
                              children: [
                                const Icon(Icons.check_circle_outline,
                                    size: 16,
                                    color: AppColors.accommodationColor),
                                const SizedBox(width: 8),
                                Expanded(
                                    child: Text(a,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium)),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),

              // Progress notes
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 8),
                child: Row(
                  children: [
                    Text('Progress Notes',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(fontWeight: FontWeight.w600)),
                    const Spacer(),
                    TextButton.icon(
                      icon: const Icon(Icons.add, size: 18),
                      label: const Text('Add Note'),
                      onPressed: () =>
                          _showAddNoteSheet(context, ref, goal),
                    ),
                  ],
                ),
              ),
              notesAsync.when(
                loading: () => const ShimmerList(itemCount: 3, itemHeight: 60),
                error: (e, _) => Text('Error: $e'),
                data: (notes) {
                  if (notes.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('No progress notes yet',
                          style: TextStyle(color: AppColors.textTertiary)),
                    );
                  }
                  return Column(
                    children: notes.map((n) => GlassCard(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                DateFormat.yMMMd().format(n.recordedAt),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        color: AppColors.textTertiary),
                              ),
                              const Spacer(),
                              Text(
                                '${n.progressPercent.toInt()}%',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        color: AppColors.neonCyan,
                                        fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(n.note,
                              style:
                                  Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                    )).toList(),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAddNoteSheet(
      BuildContext context, WidgetRef ref, IEPGoal goal) {
    final noteCtrl = TextEditingController();
    double progress = goal.progressPercent;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.darkSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSheetState) => Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Add Progress Note',
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 16),
              TextField(
                controller: noteCtrl,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Note about progress...',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Text('Progress: ${progress.toInt()}%'),
              Slider(
                value: progress,
                min: 0,
                max: 100,
                divisions: 20,
                activeColor: AppColors.neonCyan,
                onChanged: (v) => setSheetState(() => progress = v),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (noteCtrl.text.trim().isEmpty) return;
                    final noteRepo =
                        ref.read(iepProgressNoteRepositoryProvider);
                    final goalRepo =
                        ref.read(iepGoalRepositoryProvider);
                    final noteId = const Uuid().v4();
                    await noteRepo.save(
                      noteId,
                      IEPProgressNote(
                        id: noteId,
                        goalId: goal.id,
                        note: noteCtrl.text.trim(),
                        progressPercent: progress,
                        recordedAt: DateTime.now(),
                      ),
                    );
                    await goalRepo.save(
                      goal.id,
                      goal.copyWith(progressPercent: progress),
                    );
                    ref.invalidate(
                        progressNotesForGoalProvider(goal.id));
                    ref.invalidate(iepGoalByIdProvider(goal.id));
                    ref.invalidate(filteredIEPGoalsProvider);
                    if (ctx.mounted) Navigator.pop(ctx);
                  },
                  child: const Text('Save Note'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _statusColor(GoalStatus status) {
    switch (status) {
      case GoalStatus.active:
        return AppColors.neonCyan;
      case GoalStatus.met:
        return AppColors.neonGreen;
      case GoalStatus.notMet:
        return AppColors.neonPink;
      case GoalStatus.revised:
        return AppColors.neonOrange;
    }
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final Color color;
  const _Chip(this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Text(label,
          style: Theme.of(context)
              .textTheme
              .labelSmall
              ?.copyWith(color: color)),
    );
  }
}
