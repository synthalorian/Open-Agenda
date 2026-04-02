import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:open_agenda_core/open_agenda_core.dart';

import '../providers/dashboard_providers.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(dashboardStatsProvider);

    return Scaffold(
      body: statsAsync.when(
        loading: () => const Center(
            child: CircularProgressIndicator(color: AppColors.neonPurple)),
        error: (e, _) => Center(
          child: ErrorState(
            message: e.toString(),
            onRetry: () => ref.invalidate(dashboardStatsProvider),
          ),
        ),
        data: (stats) => CustomScrollView(
          slivers: [
            // App bar with gradient
            SliverAppBar(
              expandedHeight: 200,
              floating: true,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: AppColors.neonGradient,
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    getGreeting(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          color: AppColors.textPrimary
                                              .withOpacity(0.8),
                                        ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    stats.teacherName,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.textPrimary,
                                        ),
                                  ),
                                ],
                              ),
                              NeonIconButton(
                                icon: Icons.settings_outlined,
                                onPressed: () => context.go('/settings'),
                                color: AppColors.textPrimary,
                                size: 44,
                                tooltip: 'Settings',
                              ),
                            ],
                          ),
                          const Spacer(),
                          Text(
                            'Today\'s Overview',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  color: AppColors.textPrimary
                                      .withOpacity(0.9),
                                ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Stats grid — real data
            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverGrid(
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                delegate: SliverChildListDelegate([
                  StatCard(
                    title: 'Students',
                    value: '${stats.studentCount}',
                    subtitle: stats.absentToday > 0
                        ? '${stats.absentToday} absent today'
                        : 'All present',
                    icon: Icons.people,
                    color: AppColors.neonCyan,
                    onTap: () => context.go('/students'),
                  ),
                  StatCard(
                    title: 'Avg Grade',
                    value: stats.avgGrade != null
                        ? '${stats.avgGrade!.toInt()}%'
                        : '—',
                    subtitle: 'All assignments',
                    icon: Icons.trending_up,
                    color: AppColors.neonGreen,
                    onTap: () => context.go('/grades'),
                  ),
                  StatCard(
                    title: 'Attendance',
                    value: '${stats.attendanceRate.toInt()}%',
                    subtitle: 'This month',
                    icon: Icons.event_available,
                    color: AppColors.neonPurple,
                    onTap: () => context.go('/attendance'),
                  ),
                  StatCard(
                    title: 'IEP Goals',
                    value: '${stats.activeGoalCount}',
                    subtitle: stats.goalsDueSoon > 0
                        ? '${stats.goalsDueSoon} due this week'
                        : 'None due soon',
                    icon: Icons.track_changes,
                    color: AppColors.neonOrange,
                    onTap: () => context.go('/iep'),
                  ),
                ]),
              ),
            ),

            // Today's schedule — real data
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                child: Text(
                  'Today\'s Schedule',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: stats.todayPlans.isEmpty
                  ? SliverToBoxAdapter(
                      child: GlassCard(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              'No lessons scheduled for today',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      color: AppColors.textTertiary),
                            ),
                          ),
                        ),
                      ),
                    )
                  : SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final plan = stats.todayPlans[index];
                          return _ScheduleCard(
                            time: plan.startTime,
                            title: plan.title,
                            subtitle: plan.subject,
                            color: _subjectColor(plan.subject),
                            onTap: () =>
                                context.push('/planning/${plan.id}'),
                          );
                        },
                        childCount: stats.todayPlans.length,
                      ),
                    ),
            ),

            // Quick actions
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
                child: Text(
                  'Quick Actions',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverToBoxAdapter(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: NeonButton(
                            text: 'Take Attendance',
                            icon: Icons.fact_check,
                            color: AppColors.neonCyan,
                            onPressed: () =>
                                context.push('/attendance/take'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: NeonButton(
                            text: 'Add Grade',
                            icon: Icons.grade,
                            color: AppColors.neonGreen,
                            isOutlined: true,
                            onPressed: () =>
                                context.push('/grades/assignment/add'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: NeonButton(
                            text: 'Lesson Plan',
                            icon: Icons.event_note,
                            color: AppColors.neonPurple,
                            isOutlined: true,
                            onPressed: () =>
                                context.push('/planning/add'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: NeonButton(
                            text: 'IEP Review',
                            icon: Icons.school,
                            color: AppColors.neonOrange,
                            onPressed: () => context.go('/iep'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: NeonButton(
                            text: 'Support',
                            icon: Icons.coffee,
                            color: AppColors.neonYellow,
                            onPressed: () => launchUrl(Uri.parse(
                                'https://www.buymeacoffee.com/synthalorian')),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: NeonButton(
                            text: 'Open Source',
                            icon: Icons.code,
                            color: AppColors.neonCyan,
                            isOutlined: true,
                            onPressed: () => launchUrl(Uri.parse(
                                'https://github.com/synthalorian/Open-Agenda')),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }

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
}

class _ScheduleCard extends StatelessWidget {
  final String time;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback? onTap;

  const _ScheduleCard({
    required this.time,
    required this.title,
    required this.subtitle,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      onTap: onTap,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 50,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  time,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(
                        color: AppColors.textTertiary,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: AppColors.textTertiary),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right,
              color: AppColors.textTertiary),
        ],
      ),
    );
  }
}
