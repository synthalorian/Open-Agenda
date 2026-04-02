import 'package:flutter_test/flutter_test.dart';
import 'package:open_agenda_core/models/teacher_profile.dart';

void main() {
  group('TeacherProfile', () {
    final profile = TeacherProfile(
      id: 'default',
      name: 'Ms. Smith',
    );

    test('defaults', () {
      expect(profile.email, isNull);
      expect(profile.school, isNull);
      expect(profile.subjects, isEmpty);
      expect(profile.gradesTaught, isEmpty);
      expect(profile.pin, isNull);
    });

    test('JSON round-trip', () {
      final json = profile.toJson();
      final restored = TeacherProfile.fromJson(json);
      expect(restored.name, 'Ms. Smith');
      expect(restored.id, 'default');
    });

    test('copyWith adds subjects', () {
      final updated = profile.copyWith(
          subjects: ['Math', 'Science']);
      expect(updated.subjects, ['Math', 'Science']);
      expect(updated.name, 'Ms. Smith');
    });
  });
}
