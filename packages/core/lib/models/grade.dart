import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'grade.freezed.dart';
part 'grade.g.dart';

@HiveType(typeId: 3)
enum AssignmentCategory {
  @HiveField(0)
  homework,
  @HiveField(1)
  quiz,
  @HiveField(2)
  test,
  @HiveField(3)
  project,
  @HiveField(4)
  participation,
}

@freezed
@HiveType(typeId: 1)
class Assignment with _$Assignment {
  const factory Assignment({
    @HiveField(0) required String id,
    @HiveField(1) required String title,
    @HiveField(2) required String subject,
    @HiveField(3) required DateTime dueDate,
    @HiveField(4) required double totalPoints,
    @HiveField(5) required AssignmentCategory category,
    @HiveField(6) String? description,
    @HiveField(7) required DateTime createdAt,
  }) = _Assignment;

  factory Assignment.fromJson(Map<String, dynamic> json) =>
      _$AssignmentFromJson(json);
}

@freezed
@HiveType(typeId: 2)
class GradeEntry with _$GradeEntry {
  const factory GradeEntry({
    @HiveField(0) required String id,
    @HiveField(1) required String studentId,
    @HiveField(2) required String assignmentId,
    @HiveField(3) required double pointsEarned,
    @HiveField(4) @Default(false) bool isExcused,
    @HiveField(5) String? notes,
    @HiveField(6) required DateTime gradedAt,
  }) = _GradeEntry;

  factory GradeEntry.fromJson(Map<String, dynamic> json) =>
      _$GradeEntryFromJson(json);
}
