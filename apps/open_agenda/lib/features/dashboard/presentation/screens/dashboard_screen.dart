import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:open_agenda_core/open_agenda_core.dart';

/// Dashboard screen - Main hub for teachers
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Good morning,',
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
                                  'Teacher',
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
                                color: AppColors.textPrimary.withOpacity(0.9),
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

          // Stats grid
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              delegate: SliverChildListDelegate([
                StatCard(
                  title: 'Students',
                  value: '124',
                  subtitle: '4 absent today',
                  icon: Icons.people,
                  color: AppColors.neonCyan,
                  onTap: () => context.go('/students'),
                ),
                StatCard(
                  title: 'Avg Grade',
                  value: '87%',
                  subtitle: '↑ 3% this week',
                  icon: Icons.trending_up,
                  color: AppColors.neonGreen,
                  onTap: () => context.go('/grades'),
                ),
                StatCard(
                  title: 'Attendance',
                  value: '96%',
                  subtitle: 'This month',
                  icon: Icons.event_available,
                  color: AppColors.neonPurple,
                  onTap: () => context.go('/attendance'),
                ),
                StatCard(
                  title: 'IEP Goals',
                  value: '18',
                  subtitle: '3 due this week',
                  icon: Icons.track_changes,
                  color: AppColors.neonOrange,
                  onTap: () => context.go('/iep'),
                ),
              ]),
            ),
          ),

          // Today's schedule
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
              child: Text(
                'Today\'s Schedule',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _ScheduleCard(
                  time: '8:00 AM',
                  title: 'Period 1 - Math',
                  subtitle: 'Grade 10 - Room 205',
                  color: AppColors.mathColor,
                ),
                _ScheduleCard(
                  time: '9:15 AM',
                  title: 'Period 2 - Science',
                  subtitle: 'Grade 9 - Lab 3',
                  color: AppColors.scienceColor,
                ),
                _ScheduleCard(
                  time: '10:30 AM',
                  title: 'Period 3 - English',
                  subtitle: 'Grade 11 - Room 102',
                  color: AppColors.englishColor,
                ),
                _ScheduleCard(
                  time: '12:00 PM',
                  title: 'Lunch Break',
                  subtitle: 'Cafeteria',
                  color: AppColors.textTertiary,
                  isBreak: true,
                ),
                _ScheduleCard(
                  time: '1:00 PM',
                  title: 'Period 4 - History',
                  subtitle: 'Grade 10 - Room 301',
                  color: AppColors.historyColor,
                ),
              ]),
            ),
          ),

          // Quick actions
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
              child: Text(
                'Quick Actions',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
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
                          onPressed: () => context.go('/attendance'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: NeonButton(
                          text: 'Add Grade',
                          icon: Icons.grade,
                          color: AppColors.neonGreen,
                          isOutlined: true,
                          onPressed: () => context.go('/grades'),
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
                          onPressed: () => context.go('/planning'),
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
                          onPressed: () {
                            // TODO: launchUrl('https://www.buymeacoffee.com/synthalorian');
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: NeonButton(
                          text: 'Open Source',
                          icon: Icons.code,
                          color: AppColors.neonCyan,
                          isOutlined: true,
                          onPressed: () {
                            // TODO: launchUrl('https://github.com/synthalorian/Open-Agenda');
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Bottom padding
          const SliverToBoxAdapter(
            child: SizedBox(height: 100),
          ),
        ],
      ),
    );
  }
}

/// Schedule card widget
class _ScheduleCard extends StatelessWidget {
  final String time;
  final String title;
  final String subtitle;
  final Color color;
  final bool isBreak;

  const _ScheduleCard({
    required this.time,
    required this.title,
    required this.subtitle,
    required this.color,
    this.isBreak = false,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
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
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textTertiary,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: isBreak ? AppColors.textSecondary : null,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textTertiary,
                      ),
                ),
              ],
            ),
          ),
          if (!isBreak)
            Icon(
              Icons.chevron_right,
              color: AppColors.textTertiary,
            ),
        ],
      ),
    );
  }
}
