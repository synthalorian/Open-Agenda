import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'teacher_profile.freezed.dart';
part 'teacher_profile.g.dart';

@freezed
@HiveType(typeId: 10)
class TeacherProfile with _$TeacherProfile {
  const factory TeacherProfile({
    @HiveField(0) required String id,
    @HiveField(1) required String name,
    @HiveField(2) String? email,
    @HiveField(3) String? school,
    @HiveField(4) @Default([]) List<String> subjects,
    @HiveField(5) @Default([]) List<int> gradesTaught,
    @HiveField(6) String? pin,
  }) = _TeacherProfile;

  factory TeacherProfile.fromJson(Map<String, dynamic> json) =>
      _$TeacherProfileFromJson(json);
}
