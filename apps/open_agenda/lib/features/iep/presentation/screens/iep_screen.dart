import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:open_agenda_core/open_agenda_core.dart';

import '../providers/iep_providers.dart';

class IEPDashboardScreen extends ConsumerWidget {
  const IEPDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(iepGoalFilterProvider);
    final goalsAsync = ref.watch(filteredIEPGoalsProvider);
    final allStudents = ref.watch(allStudentsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('IEP Goals'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/iep/add'),
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: GoalFilter.values.map((f) {
                final label = switch (f) {
                  GoalFilter.all => 'All',
                  GoalFilter.active => 'Active',
                  GoalFilter.dueSoon => 'Due Soon',
                  GoalFilter.met => 'Met',
                };
                final isSelected = filter == f;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(label),
                    selected: isSelected,
                    onSelected: (_) =>
                        ref.read(iepGoalFilterProvider.notifier).state = f,
                    selectedColor: AppColors.iepColor.withOpacity(0.3),
                    checkmarkColor: AppColors.iepColor,
                    side: BorderSide(
                      color: isSelected
                          ? AppColors.iepColor
                          : AppColors.glassBorder,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: goalsAsync.when(
              loading: () => const ShimmerList(itemCount: 5),
              error: (e, _) => ErrorState(
                message: e.toString(),
                onRetry: () => ref.invalidate(filteredIEPGoalsProvider),
              ),
              data: (goals) {
                if (goals.isEmpty) {
                  return const EmptyState(
                    icon: Icons.school,
                    title: 'No IEP goals',
                    subtitle: 'No goals match this filter',
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: goals.length,
                  itemBuilder: (context, index) {
                    final goal = goals[index];

                    // Get student name

                    String studentName = 'Student';
                    allStudents.whenData((students) {
                      final s = students
                          .where((s) => s.id == goal.studentId)
                          .firstOrNull;
                      if (s != null) studentName = s.fullName;
                    });

                    return GlassCard(
                      onTap: () => context.push('/iep/${goal.id}'),
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppColors.iepColor.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  goal.category,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(color: AppColors.iepColor),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                studentName,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: AppColors.textSecondary),
                              ),
                              const Spacer(),
                              Text(
                                'Due ${DateFormat.MMMd().format(goal.targetDate)}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: AppColors.textTertiary),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            goal.goalText,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: LinearProgressIndicator(
                                    value: goal.progressPercent / 100,
                                    backgroundColor:
                                        AppColors.darkElevated,
                                    valueColor:
                                        AlwaysStoppedAnimation<Color>(
                                      goal.progressPercent >= 80
                                          ? AppColors.neonGreen
                                          : goal.progressPercent >= 50
                                              ? AppColors.neonCyan
                                              : AppColors.neonOrange,
                                    ),
                                    minHeight: 6,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${goal.progressPercent.toInt()}%',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: AppColors.textSecondary,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ],
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
