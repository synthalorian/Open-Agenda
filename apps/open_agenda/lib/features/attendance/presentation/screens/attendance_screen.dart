import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:open_agenda_core/open_agenda_core.dart';
import 'package:printing/printing.dart';

import '../providers/attendance_providers.dart';

class AttendanceScreen extends ConsumerWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedAttendanceDateProvider);
    final recordsAsync = ref.watch(attendanceForDateProvider);
    final allRecordsAsync = ref.watch(allAttendanceProvider);

    // Build event map for calendar markers
    final eventDays = <DateTime, int>{};
    allRecordsAsync.whenData((records) {
      for (final r in records) {
        final key = DateTime(r.date.year, r.date.month, r.date.day);
        eventDays[key] = (eventDays[key] ?? 0) + 1;
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            tooltip: 'Export Attendance Report',
            onPressed: () async {
              final students =
                  await ref.read(allStudentsProvider.future);
              final records =
                  await ref.read(allAttendanceProvider.future);
              // Export for the currently focused month
              final focused = ref.read(selectedAttendanceDateProvider);
              final startDate =
                  DateTime(focused.year, focused.month, 1);
              final endDate =
                  DateTime(focused.year, focused.month + 1, 0);
              final doc = PdfExportService.generateAttendanceReport(
                students: students,
                records: records,
                startDate: startDate,
                endDate: endDate,
              );
              await Printing.layoutPdf(
                onLayout: (_) => doc.save(),
                name: 'Attendance_Report',
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.now().subtract(const Duration(days: 365)),
            lastDay: DateTime.now().add(const Duration(days: 365)),
            focusedDay: selectedDate,
            calendarFormat: CalendarFormat.month,
            selectedDayPredicate: (day) => isSameDay(day, selectedDate),
            onDaySelected: (selected, focused) {
              ref.read(selectedAttendanceDateProvider.notifier).state =
                  selected;
            },
            eventLoader: (day) {
              final key = DateTime(day.year, day.month, day.day);
              return eventDays.containsKey(key) ? [''] : [];
            },
            calendarStyle: CalendarStyle(
              outsideDaysVisible: false,
              todayDecoration: BoxDecoration(
                color: AppColors.neonGreen.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              selectedDecoration: const BoxDecoration(
                color: AppColors.neonGreen,
                shape: BoxShape.circle,
              ),
              markerDecoration: const BoxDecoration(
                color: AppColors.neonCyan,
                shape: BoxShape.circle,
              ),
              markerSize: 5,
              markersMaxCount: 1,
              defaultTextStyle:
                  const TextStyle(color: AppColors.textPrimary),
              weekendTextStyle: TextStyle(
                  color: AppColors.textPrimary.withOpacity(0.5)),
            ),
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle:
                  TextStyle(color: AppColors.textPrimary, fontSize: 16),
              leftChevronIcon:
                  Icon(Icons.chevron_left, color: AppColors.neonGreen),
              rightChevronIcon:
                  Icon(Icons.chevron_right, color: AppColors.neonGreen),
            ),
            daysOfWeekStyle: const DaysOfWeekStyle(
              weekdayStyle: TextStyle(color: AppColors.textSecondary),
              weekendStyle: TextStyle(color: AppColors.textTertiary),
            ),
          ),
          const SizedBox(height: 8),

          // Day summary
          Expanded(
            child: recordsAsync.when(
              loading: () => const ShimmerList(itemCount: 2),
              error: (e, _) => ErrorState(
                message: e.toString(),
                onRetry: () =>
                    ref.invalidate(attendanceForDateProvider),
              ),
              data: (records) {
                if (records.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const EmptyState(
                        icon: Icons.event_note,
                        title: 'No attendance records',
                        subtitle: 'Take attendance for this day',
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: NeonButton(
                          text: 'Take Attendance',
                          onPressed: () => context.push(
                            '/attendance/take?date=${selectedDate.toIso8601String().split('T')[0]}',
                          ),
                        ),
                      ),
                    ],
                  );
                }

                final present = records
                    .where((r) => r.status == AttendanceStatus.present)
                    .length;
                final absent = records
                    .where((r) => r.status == AttendanceStatus.absent)
                    .length;
                final tardy = records
                    .where((r) => r.status == AttendanceStatus.tardy)
                    .length;
                final excused = records
                    .where((r) => r.status == AttendanceStatus.excused)
                    .length;

                return ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    GlassCard(
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceAround,
                        children: [
                          _StatusCount('Present', present,
                              AppColors.neonGreen),
                          _StatusCount(
                              'Absent', absent, AppColors.neonPink),
                          _StatusCount(
                              'Tardy', tardy, AppColors.neonOrange),
                          _StatusCount(
                              'Excused', excused, AppColors.neonCyan),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    NeonButton(
                      text: 'Edit Attendance',
                      onPressed: () => context.push(
                        '/attendance/take?date=${selectedDate.toIso8601String().split('T')[0]}',
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusCount extends StatelessWidget {
  final String label;
  final int count;
  final Color color;
  const _StatusCount(this.label, this.count, this.color);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count.toString(),
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: color,
                fontWeight: FontWeight.w700,
              ),
        ),
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }
}
