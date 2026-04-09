import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:open_agenda_core/open_agenda_core.dart';

import '../providers/planning_providers.dart';

class LessonPlanFormScreen extends ConsumerStatefulWidget {
  final LessonPlan? plan;

  const LessonPlanFormScreen({super.key, this.plan});

  @override
  ConsumerState<LessonPlanFormScreen> createState() =>
      _LessonPlanFormScreenState();
}

class _LessonPlanFormScreenState
    extends ConsumerState<LessonPlanFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleCtrl;
  late final TextEditingController _objectiveCtrl;
  late final TextEditingController _materialsCtrl;
  late final TextEditingController _activitiesCtrl;
  late final TextEditingController _assessmentCtrl;
  late final TextEditingController _notesCtrl;
  late String _subject;
  late DateTime _date;
  late TimeOfDay _startTime;
  late TimeOfDay _endTime;

  bool get _isEditing => widget.plan != null;

  @override
  void initState() {
    super.initState();
    final p = widget.plan;
    _titleCtrl = TextEditingController(text: p?.title ?? '');
    _objectiveCtrl = TextEditingController(text: p?.objective ?? '');
    _materialsCtrl =
        TextEditingController(text: p?.materials.join(', ') ?? '');
    _activitiesCtrl =
        TextEditingController(text: p?.activities ?? '');
    _assessmentCtrl =
        TextEditingController(text: p?.assessment ?? '');
    _notesCtrl = TextEditingController(text: p?.notes ?? '');
    _subject = p?.subject ?? 'Math';
    _date = p?.date ?? DateTime.now();
    _startTime = _parseTime(p?.startTime ?? '8:00');
    _endTime = _parseTime(p?.endTime ?? '8:50');
  }

  TimeOfDay _parseTime(String time) {
    final parts = time.split(':');
    return TimeOfDay(
        hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  String _formatTime(TimeOfDay t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

  @override
  void dispose() {
    _titleCtrl.dispose();
    _objectiveCtrl.dispose();
    _materialsCtrl.dispose();
    _activitiesCtrl.dispose();
    _assessmentCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final repo = ref.read(lessonPlanRepositoryProvider);
    final id = widget.plan?.id ?? const Uuid().v4();
    final materials = _materialsCtrl.text
        .split(',')
        .map((m) => m.trim())
        .where((m) => m.isNotEmpty)
        .toList();

    final plan = LessonPlan(
      id: id,
      title: _titleCtrl.text.trim(),
      subject: _subject,
      date: DateTime(_date.year, _date.month, _date.day),
      startTime: _formatTime(_startTime),
      endTime: _formatTime(_endTime),
      objective: _objectiveCtrl.text.trim(),
      materials: materials,
      activities: _activitiesCtrl.text.trim(),
      assessment: _assessmentCtrl.text.trim().isEmpty
          ? null
          : _assessmentCtrl.text.trim(),
      notes:
          _notesCtrl.text.trim().isEmpty ? null : _notesCtrl.text.trim(),
      isCompleted: widget.plan?.isCompleted ?? false,
      createdAt: widget.plan?.createdAt ?? DateTime.now(),
    );

    await repo.save(id, plan);
    ref.invalidate(lessonPlansForDateProvider);
    ref.invalidate(weekLessonPlansProvider);
    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Plan' : 'New Lesson Plan'),
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
                  .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                  .toList(),
              onChanged: (v) => setState(() => _subject = v!),
            ),
            const SizedBox(height: 16),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Date'),
              subtitle: Text(DateFormat.yMMMd().format(_date)),
              trailing: const Icon(Icons.calendar_today,
                  color: AppColors.neonPurple),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _date,
                  firstDate: DateTime(2024),
                  lastDate: DateTime(2030),
                );
                if (picked != null) setState(() => _date = picked);
              },
            ),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Start'),
                    subtitle: Text(_formatTime(_startTime)),
                    onTap: () async {
                      final picked = await showTimePicker(
                          context: context, initialTime: _startTime);
                      if (picked != null) {
                        setState(() => _startTime = picked);
                      }
                    },
                  ),
                ),
                Expanded(
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('End'),
                    subtitle: Text(_formatTime(_endTime)),
                    onTap: () async {
                      final picked = await showTimePicker(
                          context: context, initialTime: _endTime);
                      if (picked != null) {
                        setState(() => _endTime = picked);
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _objectiveCtrl,
              decoration: const InputDecoration(labelText: 'Objective'),
              maxLines: 3,
              validator: (v) =>
                  v == null || v.trim().isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _materialsCtrl,
              decoration: const InputDecoration(
                labelText: 'Materials',
                hintText: 'Comma-separated',
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _activitiesCtrl,
              decoration: const InputDecoration(labelText: 'Activities'),
              maxLines: 3,
              validator: (v) =>
                  v == null || v.trim().isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _assessmentCtrl,
              decoration:
                  const InputDecoration(labelText: 'Assessment (optional)'),
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _notesCtrl,
              decoration:
                  const InputDecoration(labelText: 'Notes (optional)'),
              maxLines: 2,
            ),
            const SizedBox(height: 24),
            NeonButton(
              text: _isEditing ? 'Save Changes' : 'Create Plan',
              onPressed: _save,
            ),
          ],
        ),
      ),
    );
  }
}
