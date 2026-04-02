import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:open_agenda_core/open_agenda_core.dart';

import '../../../../app/theme_controller.dart';
import '../providers/settings_providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(settingsTeacherProfileProvider);
    final themeMode = ref.watch(themeModeProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Profile section
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: AppColors.neonPurple.withOpacity(0.3),
                      child: const Icon(Icons.person,
                          color: AppColors.neonPurple),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: profileAsync.when(
                        loading: () => const Text('Loading...'),
                        error: (_, __) => const Text('Error'),
                        data: (profile) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              profile?.name ?? 'Teacher',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                            if (profile?.school != null)
                              Text(
                                profile!.school!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        color: AppColors.textSecondary),
                              ),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit, size: 20),
                      onPressed: () =>
                          context.push('/settings/profile/edit'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Appearance
          _SectionHeader('Appearance'),
          GlassCard(
            child: Column(
              children: [
                _ThemeTile(
                  title: 'Dark',
                  icon: Icons.dark_mode,
                  isSelected: themeMode == ThemeMode.dark,
                  onTap: () => ref
                      .read(themeModeProvider.notifier)
                      .setThemeMode(ThemeMode.dark),
                ),
                const Divider(height: 1, color: AppColors.glassBorder),
                _ThemeTile(
                  title: 'Light',
                  icon: Icons.light_mode,
                  isSelected: themeMode == ThemeMode.light,
                  onTap: () => ref
                      .read(themeModeProvider.notifier)
                      .setThemeMode(ThemeMode.light),
                ),
                const Divider(height: 1, color: AppColors.glassBorder),
                _ThemeTile(
                  title: 'System',
                  icon: Icons.settings_brightness,
                  isSelected: themeMode == ThemeMode.system,
                  onTap: () => ref
                      .read(themeModeProvider.notifier)
                      .setThemeMode(ThemeMode.system),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Data
          _SectionHeader('Data'),
          GlassCard(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.refresh,
                      color: AppColors.neonOrange),
                  title: const Text('Reset Sample Data'),
                  subtitle: const Text('Clear and re-seed demo data'),
                  onTap: () => _confirmAction(
                    context,
                    'Reset Sample Data',
                    'This will delete all data and re-seed with demo data.',
                    () async {
                      await HiveService.clearAll();
                      await HiveService.init();
                      await SeedData.seedIfEmpty();
                      ref.invalidate(allStudentsProvider);
                      ref.invalidate(allAssignmentsProvider);
                      ref.invalidate(settingsTeacherProfileProvider);
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Data reset complete')),
                        );
                      }
                    },
                  ),
                ),
                const Divider(height: 1, color: AppColors.glassBorder),
                ListTile(
                  leading: const Icon(Icons.delete_forever,
                      color: AppColors.neonPink),
                  title: const Text('Clear All Data'),
                  subtitle: const Text('Permanently delete everything'),
                  onTap: () => _confirmAction(
                    context,
                    'Clear All Data',
                    'This cannot be undone. All data will be permanently deleted.',
                    () async {
                      await HiveService.clearAll();
                      await HiveService.init();
                      ref.invalidate(allStudentsProvider);
                      ref.invalidate(allAssignmentsProvider);
                      ref.invalidate(settingsTeacherProfileProvider);
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('All data cleared')),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // About
          _SectionHeader('About'),
          GlassCard(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.code,
                      color: AppColors.neonCyan),
                  title: const Text('Source Code'),
                  subtitle: const Text('View on GitHub'),
                  trailing: const Icon(Icons.open_in_new, size: 18),
                  onTap: () => launchUrl(Uri.parse(
                      'https://github.com/synthalorian/open-agenda')),
                ),
                const Divider(height: 1, color: AppColors.glassBorder),
                const ListTile(
                  leading: Icon(Icons.info_outline,
                      color: AppColors.neonPurple),
                  title: Text('Open Agenda'),
                  subtitle: Text('Version 1.0.0'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _confirmAction(BuildContext context, String title, String message,
      VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              onConfirm();
            },
            child: Text('Confirm',
                style: TextStyle(color: AppColors.neonPink)),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, top: 8, bottom: 4),
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleSmall
            ?.copyWith(color: AppColors.textTertiary),
      ),
    );
  }
}

class _ThemeTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThemeTile({
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon,
          color: isSelected ? AppColors.neonPurple : AppColors.textSecondary),
      title: Text(title),
      trailing: isSelected
          ? const Icon(Icons.check, color: AppColors.neonPurple)
          : null,
      onTap: onTap,
    );
  }
}
