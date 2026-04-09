import 'package:flutter_test/flutter_test.dart';
import 'package:open_agenda_core/open_agenda_core.dart';

import 'package:open_agenda/features/settings/presentation/providers/settings_providers.dart';

void main() {
  group('Settings providers', () {
    test('settingsTeacherProfileProvider type exists', () {
      // Verify the provider can be created (type check)
      expect(settingsTeacherProfileProvider, isNotNull);
    });
  });

  group('TeacherProfile in settings context', () {
    test('profile with all fields', () {
      const profile = TeacherProfile(
        id: 'default',
        name: 'Ms. Smith',
        email: 'smith@school.edu',
        school: 'Lakeland High',
        subjects: ['Math', 'Science'],
        gradesTaught: [9, 10, 11],
      );

      expect(profile.name, 'Ms. Smith');
      expect(profile.school, 'Lakeland High');
      expect(profile.subjects.length, 2);
    });

    test('profile with minimal fields', () {
      const profile = TeacherProfile(
        id: 'default',
        name: 'Teacher',
      );

      expect(profile.email, isNull);
      expect(profile.school, isNull);
      expect(profile.subjects, isEmpty);
    });
  });
}
