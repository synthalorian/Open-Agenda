import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'attendance.freezed.dart';
part 'attendance.g.dart';

@HiveType(typeId: 5)
enum AttendanceStatus {
  @HiveField(0)
  present,
  @HiveField(1)
  absent,
  @HiveField(2)
  tardy,
  @HiveField(3)
  excused,
}

@freezed
@HiveType(typeId: 4)
class AttendanceRecord with _$AttendanceRecord {
  const factory AttendanceRecord({
    @HiveField(0) required String id,
    @HiveField(1) required String studentId,
    @HiveField(2) required DateTime date,
    @HiveField(3) required AttendanceStatus status,
    @HiveField(4) String? notes,
    @HiveField(5) int? periodNumber,
  }) = _AttendanceRecord;

  factory AttendanceRecord.fromJson(Map<String, dynamic> json) =>
      _$AttendanceRecordFromJson(json);
}
