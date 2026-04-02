import '../base_repository.dart';
import '../hive_service.dart';
import '../../models/attendance.dart';

class AttendanceRepository extends BaseRepository<AttendanceRecord> {
  AttendanceRepository() : super(HiveService.attendanceBox);

  Future<List<AttendanceRecord>> getByDate(DateTime date) async {
    final all = await getAll();
    return all.where((r) =>
        r.date.year == date.year &&
        r.date.month == date.month &&
        r.date.day == date.day).toList();
  }

  Future<List<AttendanceRecord>> getByStudent(String studentId) async {
    final all = await getAll();
    return all.where((r) => r.studentId == studentId).toList();
  }

  Future<double> getAttendanceRate(
      String studentId, DateTime start, DateTime end) async {
    final records = await getByStudent(studentId);
    final inRange = records.where((r) =>
        !r.date.isBefore(start) && !r.date.isAfter(end)).toList();
    if (inRange.isEmpty) return 0.0;
    final present =
        inRange.where((r) => r.status == AttendanceStatus.present).length;
    return present / inRange.length * 100;
  }

  Future<double> getOverallAttendanceRate(
      DateTime start, DateTime end) async {
    final all = await getAll();
    final inRange = all.where((r) =>
        !r.date.isBefore(start) && !r.date.isAfter(end)).toList();
    if (inRange.isEmpty) return 0.0;
    final present =
        inRange.where((r) => r.status == AttendanceStatus.present).length;
    return present / inRange.length * 100;
  }
}
