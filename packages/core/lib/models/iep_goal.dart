import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'iep_goal.freezed.dart';
part 'iep_goal.g.dart';

@HiveType(typeId: 8)
enum GoalStatus {
  @HiveField(0)
  active,
  @HiveField(1)
  met,
  @HiveField(2)
  notMet,
  @HiveField(3)
  revised,
}

@freezed
@HiveType(typeId: 7)
class IEPGoal with _$IEPGoal {
  const factory IEPGoal({
    @HiveField(0) required String id,
    @HiveField(1) required String studentId,
    @HiveField(2) required String goalText,
    @HiveField(3) required String category,
    @HiveField(4) required DateTime targetDate,
    @HiveField(5) @Default(0.0) double progressPercent,
    @HiveField(6) @Default([]) List<String> accommodations,
    @HiveField(7) String? notes,
    @HiveField(8) @Default(GoalStatus.active) GoalStatus status,
    @HiveField(9) required DateTime createdAt,
  }) = _IEPGoal;

  factory IEPGoal.fromJson(Map<String, dynamic> json) =>
      _$IEPGoalFromJson(json);
}

@freezed
@HiveType(typeId: 9)
class IEPProgressNote with _$IEPProgressNote {
  const factory IEPProgressNote({
    @HiveField(0) required String id,
    @HiveField(1) required String goalId,
    @HiveField(2) required String note,
    @HiveField(3) required double progressPercent,
    @HiveField(4) required DateTime recordedAt,
  }) = _IEPProgressNote;

  factory IEPProgressNote.fromJson(Map<String, dynamic> json) =>
      _$IEPProgressNoteFromJson(json);
}
