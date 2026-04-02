import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:open_agenda_core/open_agenda_core.dart';

import '../providers/grades_providers.dart';

Color _subjectColor(String subject) {
  switch (subject.toLowerCase()) {
    case 'math':
      return AppColors.mathColor;
    case 'science':
      return AppColors.scienceColor;
    case 'english':
      return AppColors.englishColor;
    case 'history':
      return AppColors.historyColor;
    default:
      return AppColors.neonPurple;
  }
}

class GradesScreen extends ConsumerWidget {
  const GradesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSubject = ref.watch(selectedSubjectProvider);
    final assignmentsAsync = ref.watch(assignmentsBySubjectProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Grades')),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [null, 'Math', 'Science', 'English', 'History']
                  .map((s) {
                final label = s ?? 'All';
                final isSelected = selectedSubject == s;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(label),
                    selected: isSelected,
                    onSelected: (_) =>
                        ref.read(selectedSubjectProvider.notifier).state = s,
                    selectedColor: (s != null
                            ? _subjectColor(s)
                            : AppColors.neonCyan)
                        .withOpacity(0.3),
                    side: BorderSide(
                      color: isSelected
                          ? (s != null
                              ? _subjectColor(s)
                              : AppColors.neonCyan)
                          : AppColors.glassBorder,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: assignmentsAsync.when(
              loading: () => const ShimmerList(),
              error: (e, _) => ErrorState(
                message: e.toString(),
                onRetry: () =>
                    ref.invalidate(assignmentsBySubjectProvider),
              ),
              data: (assignments) {
                if (assignments.isEmpty) {
                  return EmptyState(
                    icon: Icons.grade_outlined,
                    title: 'No assignments',
                    subtitle: 'Create an assignment to start grading',
                    actionLabel: 'Add Assignment',
                    onAction: () =>
                        context.push('/grades/assignment/add'),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: assignments.length,
                  itemBuilder: (context, index) {
                    final a = assignments[index];
                    final color = _subjectColor(a.subject);
                    return GlassCard(
                      onTap: () =>
                          context.push('/grades/assignment/${a.id}'),
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          Container(
                            width: 4,
                            height: 48,
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  a.title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                          fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${a.subject} · ${a.category.name} · ${DateFormat.MMMd().format(a.dueDate)}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                          color:
                                              AppColors.textSecondary),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '${a.totalPoints.toInt()} pts',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: color),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
