import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:open_agenda_core/open_agenda_core.dart';

import '../providers/grades_providers.dart';

class AssignmentFormScreen extends ConsumerStatefulWidget {
  final Assignment? assignment;

  const AssignmentFormScreen({super.key, this.assignment});

  @override
  ConsumerState<AssignmentFormScreen> createState() =>
      _AssignmentFormScreenState();
}

class _AssignmentFormScreenState
    extends ConsumerState<AssignmentFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleCtrl;
  late final TextEditingController _totalPointsCtrl;
  late final TextEditingController _descriptionCtrl;
  late String _subject;
  late DateTime _dueDate;
  late AssignmentCategory _category;

  bool get _isEditing => widget.assignment != null;

  @override
  void initState() {
    super.initState();
    final a = widget.assignment;
    _titleCtrl = TextEditingController(text: a?.title ?? '');
    _totalPointsCtrl = TextEditingController(
        text: a?.totalPoints.toStringAsFixed(0) ?? '100');
    _descriptionCtrl =
        TextEditingController(text: a?.description ?? '');
    _subject = a?.subject ?? 'Math';
    _dueDate = a?.dueDate ?? DateTime.now().add(const Duration(days: 7));
    _category = a?.category ?? AssignmentCategory.homework;
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _totalPointsCtrl.dispose();
    _descriptionCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final repo = ref.read(assignmentRepositoryProvider);
    final id = widget.assignment?.id ?? const Uuid().v4();

    final assignment = Assignment(
      id: id,
      title: _titleCtrl.text.trim(),
      subject: _subject,
      dueDate: _dueDate,
      totalPoints:
          double.tryParse(_totalPointsCtrl.text) ?? 100,
      category: _category,
      description: _descriptionCtrl.text.trim().isEmpty
          ? null
          : _descriptionCtrl.text.trim(),
      createdAt: widget.assignment?.createdAt ?? DateTime.now(),
    );

    await repo.save(id, assignment);
    ref.invalidate(assignmentsBySubjectProvider);
    ref.invalidate(allAssignmentsProvider);
    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            _isEditing ? 'Edit Assignment' : 'New Assignment'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _titleCtrl,
              decoration: const InputDecoration(labelText: 'Title'),
              validator: (v) =>
                  v == null || v.trim().isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _subject,
              decoration: const InputDecoration(labelText: 'Subject'),
              items: ['Math', 'Science', 'English', 'History']
                  .map((s) =>
                      DropdownMenuItem(value: s, child: Text(s)))
                  .toList(),
              onChanged: (v) => setState(() => _subject = v!),
            ),
            const SizedBox(height: 16),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Due Date'),
              subtitle:
                  Text(DateFormat.yMMMd().format(_dueDate)),
              trailing: const Icon(Icons.calendar_today,
                  color: AppColors.neonCyan),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _dueDate,
                  firstDate: DateTime(2024),
                  lastDate: DateTime(2030),
                );
                if (picked != null) {
                  setState(() => _dueDate = picked);
                }
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _totalPointsCtrl,
              decoration:
                  const InputDecoration(labelText: 'Total Points'),
              keyboardType: TextInputType.number,
              validator: (v) {
                if (v == null || v.isEmpty) return 'Required';
                if (double.tryParse(v) == null) return 'Invalid number';
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<AssignmentCategory>(
              value: _category,
              decoration:
                  const InputDecoration(labelText: 'Category'),
              items: AssignmentCategory.values
                  .map((c) => DropdownMenuItem(
                        value: c,
                        child: Text(c.name[0].toUpperCase() +
                            c.name.substring(1)),
                      ))
                  .toList(),
              onChanged: (v) => setState(() => _category = v!),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionCtrl,
              decoration: const InputDecoration(
                  labelText: 'Description (optional)'),
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            NeonButton(
              text: _isEditing
                  ? 'Save Changes'
                  : 'Create Assignment',
              onPressed: _save,
            ),
          ],
        ),
      ),
    );
  }
}
