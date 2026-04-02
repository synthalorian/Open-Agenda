import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:open_agenda_core/open_agenda_core.dart';

import '../providers/planning_providers.dart';

class LessonPlanDetailScreen extends ConsumerWidget {
  final String planId;

  const LessonPlanDetailScreen({super.key, required this.planId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final planAsync = ref.watch(lessonPlanByIdProvider(planId));

    return planAsync.when(
      loading: () => const Scaffold(
          body: Center(child: ShimmerCard(height: 200))),
      error: (e, _) => Scaffold(
        appBar: AppBar(),
        body: ErrorState(
            message: e.toString(),
            onRetry: () =>
                ref.invalidate(lessonPlanByIdProvider(planId))),
      ),
      data: (plan) {
        if (plan == null) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: Text('Plan not found')),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(plan.title),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () =>
                    context.push('/planning/${plan.id}/edit'),
              ),
              IconButton(
                icon: Icon(
                  plan.isCompleted
                      ? Icons.check_circle
                      : Icons.check_circle_outline,
                  color: plan.isCompleted
                      ? AppColors.neonGreen
                      : null,
                ),
                onPressed: () async {
                  final repo = ref.read(lessonPlanRepositoryProvider);
                  await repo.save(
                    plan.id,
                    plan.copyWith(isCompleted: !plan.isCompleted),
                  );
                  ref.invalidate(lessonPlanByIdProvider(planId));
                  ref.invalidate(lessonPlansForDateProvider);
                },
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _InfoRow('Subject', plan.subject),
                    _InfoRow('Date',
                        DateFormat.yMMMd().format(plan.date)),
                    _InfoRow('Time',
                        '${plan.startTime} - ${plan.endTime}'),
                    if (plan.isCompleted)
                      const _InfoRow('Status', '✓ Completed'),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              _SectionCard(
                  title: 'Objective', content: plan.objective),
              if (plan.materials.isNotEmpty)
                _SectionCard(
                  title: 'Materials',
                  content: plan.materials
                      .map((m) => '• $m')
                      .join('\n'),
                ),
              _SectionCard(
                  title: 'Activities', content: plan.activities),
              if (plan.assessment != null &&
                  plan.assessment!.isNotEmpty)
                _SectionCard(
                    title: 'Assessment',
                    content: plan.assessment!),
              if (plan.notes != null && plan.notes!.isNotEmpty)
                _SectionCard(
                    title: 'Notes', content: plan.notes!),
            ],
          ),
        );
      },
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _InfoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(label,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColors.textTertiary)),
          ),
          Expanded(
            child: Text(value,
                style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final String content;
  const _SectionCard({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppColors.neonPurple,
                    fontWeight: FontWeight.w600,
                  )),
          const SizedBox(height: 8),
          Text(content,
              style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
