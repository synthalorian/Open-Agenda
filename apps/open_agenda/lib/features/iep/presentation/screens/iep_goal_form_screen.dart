import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:open_agenda_core/open_agenda_core.dart';

import '../providers/iep_providers.dart';

class IEPGoalFormScreen extends ConsumerStatefulWidget {
  final IEPGoal? goal;

  const IEPGoalFormScreen({super.key, this.goal});

  @override
  ConsumerState<IEPGoalFormScreen> createState() => _IEPGoalFormScreenState();
}

class _IEPGoalFormScreenState extends ConsumerState<IEPGoalFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _goalTextCtrl;
  late final TextEditingController _accommodationsCtrl;
  late final TextEditingController _notesCtrl;
  late String _category;
  late DateTime _targetDate;
  String? _selectedStudentId;

  bool get _isEditing => widget.goal != null;

  @override
  void initState() {
    super.initState();
    final g = widget.goal;
    _goalTextCtrl = TextEditingController(text: g?.goalText ?? '');
    _accommodationsCtrl = TextEditingController(
        text: g?.accommodations.join(', ') ?? '');
    _notesCtrl = TextEditingController(text: g?.notes ?? '');
    _category = g?.category ?? 'Reading';
    _targetDate =
        g?.targetDate ?? DateTime.now().add(const Duration(days: 90));
    _selectedStudentId = g?.studentId;
  }

  @override
  void dispose() {
    _goalTextCtrl.dispose();
    _accommodationsCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedStudentId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a student')),
      );
      return;
    }

    final repo = ref.read(iepGoalRepositoryProvider);
    final id = widget.goal?.id ?? const Uuid().v4();
    final accommodations = _accommodationsCtrl.text
        .split(',')
        .map((a) => a.trim())
        .where((a) => a.isNotEmpty)
        .toList();

    final goal = IEPGoal(
      id: id,
      studentId: _selectedStudentId!,
      goalText: _goalTextCtrl.text.trim(),
      category: _category,
      targetDate: _targetDate,
      progressPercent: widget.goal?.progressPercent ?? 0.0,
      accommodations: accommodations,
      notes: _notesCtrl.text.trim().isEmpty
          ? null
          : _notesCtrl.text.trim(),
      status: widget.goal?.status ?? GoalStatus.active,
      createdAt: widget.goal?.createdAt ?? DateTime.now(),
    );

    await repo.save(id, goal);
    ref.invalidate(filteredIEPGoalsProvider);
    ref.invalidate(activeIEPGoalsProvider);
    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final studentsAsync = ref.watch(allStudentsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit IEP Goal' : 'New IEP Goal'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Student selector
            studentsAsync.when(
              loading: () => const LinearProgressIndicator(),
              error: (_, __) => const Text('Error loading students'),
              data: (students) {
                final iepStudents =
                    students.where((s) => s.hasIEP).toList();
                final allStudents = students;
                final displayStudents =
                    iepStudents.isEmpty ? allStudents : iepStudents;
                return DropdownButtonFormField<String>(
                  value: _selectedStudentId,
                  decoration:
                      const InputDecoration(labelText: 'Student'),
                  items: displayStudents
                      .map((s) => DropdownMenuItem(
                          value: s.id, child: Text(s.fullName)))
                      .toList(),
                  onChanged: _isEditing
                      ? null
                      : (v) => setState(() => _selectedStudentId = v),
                  validator: (v) => v == null ? 'Required' : null,
                );
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _category,
              decoration: const InputDecoration(labelText: 'Category'),
              items: [
                'Reading',
                'Writing',
                'Math',
                'Behavior',
                'Social Skills',
                'Speech',
                'Motor Skills'
              ]
                  .map((c) =>
                      DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (v) => setState(() => _category = v!),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _goalTextCtrl,
              decoration: const InputDecoration(labelText: 'Goal'),
              maxLines: 3,
              validator: (v) =>
                  v == null || v.trim().isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Target Date'),
              subtitle:
                  Text(DateFormat.yMMMd().format(_targetDate)),
              trailing: const Icon(Icons.calendar_today,
                  color: AppColors.iepColor),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _targetDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2030),
                );
                if (picked != null) {
                  setState(() => _targetDate = picked);
                }
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _accommodationsCtrl,
              decoration: const InputDecoration(
                labelText: 'Accommodations',
                hintText: 'Comma-separated',
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _notesCtrl,
              decoration: const InputDecoration(
                  labelText: 'Notes (optional)'),
              maxLines: 2,
            ),
            const SizedBox(height: 24),
            NeonButton(
              text: _isEditing ? 'Save Changes' : 'Create Goal',
              onPressed: _save,
            ),
          ],
        ),
      ),
    );
  }
}
