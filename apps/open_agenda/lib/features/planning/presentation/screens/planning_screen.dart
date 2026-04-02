import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:open_agenda_core/open_agenda_core.dart';

import '../providers/planning_providers.dart';

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

class PlanningScreen extends ConsumerWidget {
  const PlanningScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedPlanDateProvider);
    final plansAsync = ref.watch(lessonPlansForDateProvider);
    final weekPlansAsync = ref.watch(weekLessonPlansProvider);

    final eventDays = <DateTime, int>{};
    weekPlansAsync.whenData((plans) {
      for (final p in plans) {
        final key = DateTime(p.date.year, p.date.month, p.date.day);
        eventDays[key] = (eventDays[key] ?? 0) + 1;
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lesson Plans'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/planning/add'),
          ),
        ],
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.now().subtract(const Duration(days: 365)),
            lastDay: DateTime.now().add(const Duration(days: 365)),
            focusedDay: selectedDate,
            calendarFormat: CalendarFormat.week,
            selectedDayPredicate: (day) => isSameDay(day, selectedDate),
            onDaySelected: (selected, focused) {
              ref.read(selectedPlanDateProvider.notifier).state = selected;
            },
            eventLoader: (day) {
              final key = DateTime(day.year, day.month, day.day);
              final count = eventDays[key] ?? 0;
              return List.generate(count, (_) => '');
            },
            calendarStyle: CalendarStyle(
              outsideDaysVisible: false,
              todayDecoration: BoxDecoration(
                color: AppColors.neonPurple.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              selectedDecoration: const BoxDecoration(
                color: AppColors.neonPurple,
                shape: BoxShape.circle,
              ),
              markerDecoration: const BoxDecoration(
                color: AppColors.neonCyan,
                shape: BoxShape.circle,
              ),
              markerSize: 6,
              markersMaxCount: 3,
              defaultTextStyle: const TextStyle(color: AppColors.textPrimary),
              weekendTextStyle:
                  TextStyle(color: AppColors.textPrimary.withOpacity(0.5)),
            ),
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle:
                  TextStyle(color: AppColors.textPrimary, fontSize: 16),
              leftChevronIcon:
                  Icon(Icons.chevron_left, color: AppColors.neonPurple),
              rightChevronIcon:
                  Icon(Icons.chevron_right, color: AppColors.neonPurple),
            ),
            daysOfWeekStyle: const DaysOfWeekStyle(
              weekdayStyle: TextStyle(color: AppColors.textSecondary),
              weekendStyle: TextStyle(color: AppColors.textTertiary),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: plansAsync.when(
              loading: () => const ShimmerList(itemCount: 4),
              error: (e, _) => ErrorState(
                message: e.toString(),
                onRetry: () => ref.invalidate(lessonPlansForDateProvider),
              ),
              data: (plans) {
                if (plans.isEmpty) {
                  return EmptyState(
                    icon: Icons.event_note,
                    title: 'No lesson plans',
                    subtitle: 'No plans for this day yet',
                    actionLabel: 'Add Plan',
                    onAction: () => context.push('/planning/add'),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: plans.length,
                  itemBuilder: (context, index) {
                    final plan = plans[index];
                    final color = _subjectColor(plan.subject);
                    return GlassCard(
                      onTap: () => context.push('/planning/${plan.id}'),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  plan.title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${plan.startTime} - ${plan.endTime} · ${plan.subject}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                          color: AppColors.textSecondary),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  plan.objective,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                          color: AppColors.textTertiary),
                                ),
                              ],
                            ),
                          ),
                          if (plan.isCompleted)
                            const Icon(Icons.check_circle,
                                color: AppColors.neonGreen, size: 20),
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
