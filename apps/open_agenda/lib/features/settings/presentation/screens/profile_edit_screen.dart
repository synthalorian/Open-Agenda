import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:open_agenda_core/open_agenda_core.dart';

import '../providers/settings_providers.dart';

class ProfileEditScreen extends ConsumerStatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  ConsumerState<ProfileEditScreen> createState() =>
      _ProfileEditScreenState();
}

class _ProfileEditScreenState extends ConsumerState<ProfileEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _schoolCtrl = TextEditingController();
  final _subjectsCtrl = TextEditingController();
  bool _loaded = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _schoolCtrl.dispose();
    _subjectsCtrl.dispose();
    super.dispose();
  }

  void _loadProfile(TeacherProfile? profile) {
    if (_loaded || profile == null) return;
    _loaded = true;
    _nameCtrl.text = profile.name;
    _emailCtrl.text = profile.email ?? '';
    _schoolCtrl.text = profile.school ?? '';
    _subjectsCtrl.text = profile.subjects.join(', ');
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final repo = ref.read(teacherRepositoryProvider);
    final existing = await repo.getProfile();

    final subjects = _subjectsCtrl.text
        .split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();

    final profile = TeacherProfile(
      id: existing?.id ?? 'default',
      name: _nameCtrl.text.trim(),
      email: _emailCtrl.text.trim().isEmpty
          ? null
          : _emailCtrl.text.trim(),
      school: _schoolCtrl.text.trim().isEmpty
          ? null
          : _schoolCtrl.text.trim(),
      subjects: subjects,
      gradesTaught: existing?.gradesTaught ?? [],
      pin: existing?.pin,
    );

    await repo.saveProfile(profile);
    ref.invalidate(settingsTeacherProfileProvider);
    ref.invalidate(teacherProfileProvider);
    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(settingsTeacherProfileProvider);

    profileAsync.whenData((p) => _loadProfile(p));

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameCtrl,
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (v) =>
                  v == null || v.trim().isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailCtrl,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _schoolCtrl,
              decoration: const InputDecoration(labelText: 'School'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _subjectsCtrl,
              decoration: const InputDecoration(
                labelText: 'Subjects',
                hintText: 'Comma-separated',
              ),
            ),
            const SizedBox(height: 24),
            NeonButton(
              text: 'Save Profile',
              onPressed: _save,
            ),
          ],
        ),
      ),
    );
  }
}
