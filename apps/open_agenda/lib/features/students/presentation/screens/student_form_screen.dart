import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'package:open_agenda_core/open_agenda_core.dart';

import '../providers/students_providers.dart';

class StudentFormScreen extends ConsumerStatefulWidget {
  final String? studentId;

  const StudentFormScreen({super.key, this.studentId});

  @override
  ConsumerState<StudentFormScreen> createState() => _StudentFormScreenState();
}

class _StudentFormScreenState extends ConsumerState<StudentFormScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _firstNameCtrl;
  late final TextEditingController _lastNameCtrl;
  late final TextEditingController _emailCtrl;
  late final TextEditingController _parentEmailCtrl;
  late final TextEditingController _parentPhoneCtrl;
  late final TextEditingController _notesCtrl;

  int _grade = 9;
  String _section = 'A';
  bool _hasIEP = false;
  bool _loaded = false;
  Student? _existingStudent;

  bool get _isEditing => widget.studentId != null;

  @override
  void initState() {
    super.initState();
    _firstNameCtrl = TextEditingController();
    _lastNameCtrl = TextEditingController();
    _emailCtrl = TextEditingController();
    _parentEmailCtrl = TextEditingController();
    _parentPhoneCtrl = TextEditingController();
    _notesCtrl = TextEditingController();
  }

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _emailCtrl.dispose();
    _parentEmailCtrl.dispose();
    _parentPhoneCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  void _loadStudent(Student student) {
    if (_loaded) return;
    _loaded = true;
    _existingStudent = student;
    _firstNameCtrl.text = student.firstName;
    _lastNameCtrl.text = student.lastName;
    _emailCtrl.text = student.email ?? '';
    _parentEmailCtrl.text = student.parentEmail ?? '';
    _parentPhoneCtrl.text = student.parentPhone ?? '';
    _notesCtrl.text = student.notes ?? '';
    _grade = student.grade;
    _section = student.section;
    _hasIEP = student.hasIEP;
    setState(() {});
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final repo = ref.read(studentRepositoryProvider);
    final id = _existingStudent?.id ?? const Uuid().v4();

    final student = Student(
      id: id,
      firstName: _firstNameCtrl.text.trim(),
      lastName: _lastNameCtrl.text.trim(),
      grade: _grade,
      section: _section,
      email: _emailCtrl.text.trim().isEmpty ? null : _emailCtrl.text.trim(),
      parentEmail: _parentEmailCtrl.text.trim().isEmpty
          ? null
          : _parentEmailCtrl.text.trim(),
      parentPhone: _parentPhoneCtrl.text.trim().isEmpty
          ? null
          : _parentPhoneCtrl.text.trim(),
      hasIEP: _hasIEP,
      notes: _notesCtrl.text.trim().isEmpty ? null : _notesCtrl.text.trim(),
      createdAt: _existingStudent?.createdAt ?? DateTime.now(),
    );

    await repo.save(id, student);
    ref.invalidate(allStudentsProvider);
    ref.invalidate(filteredStudentsProvider);
    if (_existingStudent != null) {
      ref.invalidate(studentByIdProvider(id));
    }
    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    // Load existing student data in edit mode
    if (_isEditing && !_loaded) {
      final studentAsync = ref.watch(studentByIdProvider(widget.studentId!));
      studentAsync.whenData((s) {
        if (s != null) _loadStudent(s);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Student' : 'Add Student'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GlassCard(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Personal Information',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                color: AppColors.neonCyan,
                                fontWeight: FontWeight.w700)),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _firstNameCtrl,
                      decoration: const InputDecoration(
                          labelText: 'First Name',
                          prefixIcon: Icon(Icons.person_outline)),
                      textCapitalization: TextCapitalization.words,
                      validator: (v) => v == null || v.trim().isEmpty
                          ? 'Required'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _lastNameCtrl,
                      decoration: const InputDecoration(
                          labelText: 'Last Name',
                          prefixIcon: Icon(Icons.person_outline)),
                      textCapitalization: TextCapitalization.words,
                      validator: (v) => v == null || v.trim().isEmpty
                          ? 'Required'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _emailCtrl,
                      decoration: const InputDecoration(
                          labelText: 'Email (optional)',
                          prefixIcon: Icon(Icons.email_outlined)),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              GlassCard(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Academic Details',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                color: AppColors.neonCyan,
                                fontWeight: FontWeight.w700)),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<int>(
                            value: _grade,
                            decoration: const InputDecoration(
                                labelText: 'Grade',
                                prefixIcon: Icon(Icons.school_outlined)),
                            items: [9, 10, 11, 12]
                                .map((g) => DropdownMenuItem(
                                    value: g, child: Text('Grade $g')))
                                .toList(),
                            onChanged: (v) {
                              if (v != null) setState(() => _grade = v);
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _section,
                            decoration: const InputDecoration(
                                labelText: 'Section',
                                prefixIcon: Icon(Icons.group_outlined)),
                            items: ['A', 'B', 'C', 'D']
                                .map((s) => DropdownMenuItem(
                                    value: s, child: Text('Section $s')))
                                .toList(),
                            onChanged: (v) {
                              if (v != null) setState(() => _section = v);
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SwitchListTile(
                      value: _hasIEP,
                      onChanged: (v) => setState(() => _hasIEP = v),
                      title: const Text('Has IEP'),
                      subtitle: const Text('Individualized Education Program'),
                      secondary: Icon(Icons.accessibility_new,
                          color: _hasIEP
                              ? AppColors.iepColor
                              : AppColors.textTertiary),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              GlassCard(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Parent / Guardian',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                color: AppColors.neonCyan,
                                fontWeight: FontWeight.w700)),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _parentEmailCtrl,
                      decoration: const InputDecoration(
                          labelText: 'Parent Email (optional)',
                          prefixIcon: Icon(Icons.mail_outline)),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _parentPhoneCtrl,
                      decoration: const InputDecoration(
                          labelText: 'Parent Phone (optional)',
                          prefixIcon: Icon(Icons.phone_outlined)),
                      keyboardType: TextInputType.phone,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              GlassCard(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Notes',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                color: AppColors.neonCyan,
                                fontWeight: FontWeight.w700)),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _notesCtrl,
                      decoration: const InputDecoration(
                          labelText: 'Notes (optional)',
                          prefixIcon: Icon(Icons.notes_outlined),
                          alignLabelWithHint: true),
                      maxLines: 4,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              NeonButton(
                text: _isEditing ? 'Update Student' : 'Add Student',
                onPressed: _save,
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
