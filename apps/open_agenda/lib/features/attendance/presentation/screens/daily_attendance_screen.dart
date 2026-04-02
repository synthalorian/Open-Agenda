import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:open_agenda_core/open_agenda_core.dart';

import '../providers/attendance_providers.dart';

class DailyAttendanceScreen extends ConsumerStatefulWidget {
  final DateTime date;

  const DailyAttendanceScreen({super.key, required this.date});

  @override
  ConsumerState<DailyAttendanceScreen> createState() =>
      _DailyAttendanceScreenState();
}

class _DailyAttendanceScreenState
    extends ConsumerState<DailyAttendanceScreen> {
  final Map<String, AttendanceStatus> _statusMap = {};
  bool _loaded = false;

  @override
  Widget build(BuildContext context) {
    final studentsAsync = ref.watch(allStudentsProvider);
    final existingAsync = ref.watch(attendanceForDateProvider);

    // Pre-populate from existing records
    existingAsync.whenData((records) {
      if (!_loaded) {
        _loaded = true;
        for (final r in records) {
          _statusMap[r.studentId] = r.status;
        }
        if (mounted) setState(() {});
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Attendance - ${DateFormat.yMMMd().format(widget.date)}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: studentsAsync.when(
              loading: () => const ShimmerList(),
              error: (e, _) => ErrorState(message: e.toString()),
              data: (students) {
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: students.length,
                  itemBuilder: (context, index) {
                    final student = students[index];
                    final status = _statusMap[student.id] ??
                        AttendanceStatus.present;

                    return GlassCard(
                      margin: const EdgeInsets.symmetric(vertical: 3),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              student.fullName,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      fontWeight: FontWeight.w500),
                            ),
                          ),
                          ...AttendanceStatus.values.map((s) {
                            final isSelected = status == s;
                            final color = _statusColor(s);
                            final label = s.name[0].toUpperCase();
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2),
                              child: GestureDetector(
                                onTap: () => setState(() =>
                                    _statusMap[student.id] = s),
                                child: Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? color.withOpacity(0.3)
                                        : Colors.transparent,
                                    borderRadius:
                                        BorderRadius.circular(8),
                                    border: Border.all(
                                      color: isSelected
                                          ? color
                                          : AppColors.glassBorder,
                                      width: isSelected ? 2 : 1,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      label,
                                      style: TextStyle(
                                        color: isSelected
                                            ? color
                                            : AppColors.textTertiary,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: NeonButton(
              text: 'Save Attendance',
              onPressed: _save,
            ),
          ),
        ],
      ),
    );
  }

  Color _statusColor(AttendanceStatus s) {
    switch (s) {
      case AttendanceStatus.present:
        return AppColors.neonGreen;
      case AttendanceStatus.absent:
        return AppColors.neonPink;
      case AttendanceStatus.tardy:
        return AppColors.neonOrange;
      case AttendanceStatus.excused:
        return AppColors.neonCyan;
    }
  }

  Future<void> _save() async {
    final repo = ref.read(attendanceRepositoryProvider);

    // Delete existing records for this date, then save new ones
    final existing = await repo.getByDate(widget.date);
    for (final r in existing) {
      await repo.delete(r.id);
    }

    final date =
        DateTime(widget.date.year, widget.date.month, widget.date.day);

    for (final entry in _statusMap.entries) {
      final id = const Uuid().v4();
      await repo.save(
        id,
        AttendanceRecord(
          id: id,
          studentId: entry.key,
          date: date,
          status: entry.value,
        ),
      );
    }

    // Also save default "present" for students not in the map
    final students = await ref.read(studentRepositoryProvider).getActiveStudents();
    for (final s in students) {
      if (!_statusMap.containsKey(s.id)) {
        final id = const Uuid().v4();
        await repo.save(
          id,
          AttendanceRecord(
            id: id,
            studentId: s.id,
            date: date,
            status: AttendanceStatus.present,
          ),
        );
      }
    }

    ref.invalidate(attendanceForDateProvider);
    ref.invalidate(allAttendanceProvider);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Attendance saved')),
      );
      context.pop();
    }
  }
}
