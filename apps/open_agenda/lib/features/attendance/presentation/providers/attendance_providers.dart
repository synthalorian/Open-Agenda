import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_agenda_core/open_agenda_core.dart';

final selectedAttendanceDateProvider =
    StateProvider<DateTime>((ref) => DateTime.now());

final attendanceForDateProvider =
    FutureProvider<List<AttendanceRecord>>((ref) {
  final date = ref.watch(selectedAttendanceDateProvider);
  return ref.watch(attendanceRepositoryProvider).getByDate(date);
});

final monthlyAttendanceRateProvider = FutureProvider<double>((ref) {
  final now = DateTime.now();
  final start = DateTime(now.year, now.month, 1);
  return ref
      .watch(attendanceRepositoryProvider)
      .getOverallAttendanceRate(start, now);
});
