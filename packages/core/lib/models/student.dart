import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'student.freezed.dart';
part 'student.g.dart';

@freezed
@HiveType(typeId: 0)
class Student with _$Student {
  const Student._();

  const factory Student({
    @HiveField(0) required String id,
    @HiveField(1) required String firstName,
    @HiveField(2) required String lastName,
    @HiveField(3) required int grade,
    @HiveField(4) @Default('A') String section,
    @HiveField(5) String? email,
    @HiveField(6) String? parentEmail,
    @HiveField(7) String? parentPhone,
    @HiveField(8) String? notes,
    @HiveField(9) @Default(false) bool hasIEP,
    @HiveField(10) @Default(true) bool isActive,
    @HiveField(11) required DateTime createdAt,
    @HiveField(12) String? photoUrl,
  }) = _Student;

  String get fullName => '$firstName $lastName';

  factory Student.fromJson(Map<String, dynamic> json) =>
      _$StudentFromJson(json);
}
