import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'lesson_plan.freezed.dart';
part 'lesson_plan.g.dart';

@freezed
@HiveType(typeId: 6)
class LessonPlan with _$LessonPlan {
  const factory LessonPlan({
    @HiveField(0) required String id,
    @HiveField(1) required String title,
    @HiveField(2) required String subject,
    @HiveField(3) required DateTime date,
    @HiveField(4) required String startTime,
    @HiveField(5) required String endTime,
    @HiveField(6) required String objective,
    @HiveField(7) @Default([]) List<String> materials,
    @HiveField(8) required String activities,
    @HiveField(9) String? assessment,
    @HiveField(10) String? notes,
    @HiveField(11) @Default(false) bool isCompleted,
    @HiveField(12) required DateTime createdAt,
  }) = _LessonPlan;

  factory LessonPlan.fromJson(Map<String, dynamic> json) =>
      _$LessonPlanFromJson(json);
}
