import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

class StudentDetailScreen extends ConsumerWidget {
  final String studentId;

  const StudentDetailScreen({super.key, required this.studentId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studentAsync = ref.watch(studentByIdProvider(studentId));

    return studentAsync.when(
      loading: () => Scaffold(
        appBar: AppBar(),
        body: const ShimmerList(itemCount: 3, itemHeight: 100),
      ),
      error: (error, _) => Scaffold(
        appBar: AppBar(),
        body: ErrorState(
          message: 'Could not load student.\n$error',
          onRetry: () => ref.invalidate(studentByIdProvider(studentId)),
        ),
      ),
      data: (student) {
        if (student == null) {
          return Scaffold(
            appBar: AppBar(),
            body: const EmptyState(
              icon: Icons.person_off_outlined,
              title: 'Student not found',
            ),
          );
        }
        final color = _gradeColor(student.grade);
        final initials =
            '${student.firstName[0]}${student.lastName[0]}';

        return Scaffold(
          appBar: AppBar(
            title: Text(student.fullName),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit_outlined),
                onPressed: () =>
                    context.push('/students/${student.id}/edit'),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: () =>
                    _confirmDelete(context, ref, student),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Header
                GlassCard(
                  enableGlow: true,
                  glowColor: color,
                  glowIntensity: 0.3,
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
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
                              color: color.withOpacity(0.7), width: 3),
                        ),
                        child: Center(
                          child: Text(
                            initials,
                            style: TextStyle(
                              color: color,
                              fontWeight: FontWeight.w700,
                              fontSize: 28,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        student.fullName,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Grade ${student.grade} · Section ${student.section}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: AppColors.textSecondary),
                      ),
                      if (student.hasIEP) ...[
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.iepColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color:
                                    AppColors.iepColor.withOpacity(0.4)),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.school,
                                  size: 16, color: AppColors.iepColor),
                              SizedBox(width: 6),
                              Text(
                                'IEP Active',
                                style: TextStyle(
                                  color: AppColors.iepColor,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // Contact
                GlassCard(
                  title: 'Contact Information',
                  leading: const Icon(Icons.contact_mail_outlined,
                      color: AppColors.neonCyan, size: 22),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _InfoRow(Icons.email_outlined, 'Email',
                          student.email ?? 'Not provided'),
                      const Divider(height: 24),
                      _InfoRow(
                          Icons.supervisor_account_outlined,
                          'Parent Email',
                          student.parentEmail ?? 'Not provided'),
                      const Divider(height: 24),
                      _InfoRow(Icons.phone_outlined, 'Parent Phone',
                          student.parentPhone ?? 'Not provided'),
                    ],
                  ),
                ),

                if (student.notes != null &&
                    student.notes!.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  GlassCard(
                    title: 'Notes',
                    leading: const Icon(Icons.notes_outlined,
                        color: AppColors.neonCyan, size: 22),
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      student.notes!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(
                            color: AppColors.textSecondary,
                            height: 1.5,
                          ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
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
      if (context.mounted) context.go('/students');
    }
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _InfoRow(this.icon, this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.neonCyan.withOpacity(0.7)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: AppColors.textTertiary)),
              const SizedBox(height: 2),
              Text(value,
                  style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ],
    );
  }
}
