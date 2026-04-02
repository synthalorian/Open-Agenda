import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:open_agenda_core/open_agenda_core.dart';

import '../providers/students_providers.dart';

Color _gradeColor(int grade) {
  switch (grade) {
    case 9:
      return AppColors.neonBlue;
    case 10:
      return AppColors.neonCyan;
    case 11:
      return AppColors.neonPurple;
    case 12:
      return AppColors.neonPink;
    default:
      return AppColors.neonCyan;
  }
}

class StudentsScreen extends ConsumerWidget {
  const StudentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studentsAsync = ref.watch(filteredStudentsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Students'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add_outlined),
            onPressed: () => context.push('/students/add'),
          ),
        ],
      ),
      body: Column(
        children: [
          NeonSearchBar(
            hintText: 'Search students...',
            onChanged: (query) {
              ref.read(studentSearchQueryProvider.notifier).state = query;
            },
          ),
          Expanded(
            child: studentsAsync.when(
              loading: () => const ShimmerList(),
              error: (error, _) => ErrorState(
                message: 'Failed to load students.\n$error',
                onRetry: () => ref.invalidate(filteredStudentsProvider),
              ),
              data: (students) {
                if (students.isEmpty) {
                  return EmptyState(
                    icon: Icons.people_outline,
                    title: 'No students found',
                    subtitle: ref.watch(studentSearchQueryProvider).isNotEmpty
                        ? 'Try a different search term.'
                        : 'Tap + to add your first student.',
                    actionLabel:
                        ref.watch(studentSearchQueryProvider).isEmpty
                            ? 'Add Student'
                            : null,
                    onAction: ref.watch(studentSearchQueryProvider).isEmpty
                        ? () => context.push('/students/add')
                        : null,
                  );
                }
                return SlidableAutoCloseBehavior(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 4),
                    itemCount: students.length,
                    itemBuilder: (context, index) {
                      final student = students[index];
                      final color = _gradeColor(student.grade);
                      final initials =
                          '${student.firstName[0]}${student.lastName[0]}';

                      return StaggeredListItem(
                        index: index,
                        child: Slidable(
                        key: ValueKey(student.id),
                        endActionPane: ActionPane(
                          motion: const DrawerMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (_) => context
                                  .push('/students/${student.id}/edit'),
                              backgroundColor:
                                  AppColors.neonCyan.withOpacity(0.15),
                              foregroundColor: AppColors.neonCyan,
                              icon: Icons.edit_outlined,
                              label: 'Edit',
                              borderRadius: const BorderRadius.horizontal(
                                  left: Radius.circular(16)),
                            ),
                            SlidableAction(
                              onPressed: (_) =>
                                  _confirmDelete(context, ref, student),
                              backgroundColor:
                                  AppColors.error.withOpacity(0.15),
                              foregroundColor: AppColors.error,
                              icon: Icons.delete_outline,
                              label: 'Delete',
                              borderRadius: const BorderRadius.horizontal(
                                  right: Radius.circular(16)),
                            ),
                          ],
                        ),
                        child: GlassCard(
                          onTap: () =>
                              context.push('/students/${student.id}'),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [
                                      color.withOpacity(0.4),
                                      color.withOpacity(0.15)
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  border: Border.all(
                                      color: color.withOpacity(0.6),
                                      width: 2),
                                ),
                                child: Center(
                                  child: Text(
                                    initials,
                                    style: TextStyle(
                                      color: color,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      student.fullName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      'Grade ${student.grade} · Section ${student.section}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                              color:
                                                  AppColors.textTertiary),
                                    ),
                                  ],
                                ),
                              ),
                              if (student.hasIEP)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color:
                                        AppColors.iepColor.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: AppColors.iepColor
                                            .withOpacity(0.4)),
                                  ),
                                  child: const Text(
                                    'IEP',
                                    style: TextStyle(
                                      color: AppColors.iepColor,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              const SizedBox(width: 4),
                              const Icon(Icons.chevron_right,
                                  color: AppColors.textTertiary, size: 20),
                            ],
                          ),
                        ),
                      ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmDelete(
      BuildContext context, WidgetRef ref, Student student) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Student'),
        content: Text(
            'Delete ${student.fullName}? This cannot be undone.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(
                foregroundColor: AppColors.error),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed == true && context.mounted) {
      await ref.read(studentRepositoryProvider).delete(student.id);
      ref.invalidate(allStudentsProvider);
      ref.invalidate(filteredStudentsProvider);
    }
  }
}
