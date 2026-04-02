import 'package:flutter_test/flutter_test.dart';
import 'package:open_agenda_core/models/student.dart';

void main() {
  group('Student', () {
    final student = Student(
      id: 'test-id',
      firstName: 'John',
      lastName: 'Doe',
      grade: 10,
      section: 'A',
      hasIEP: false,
      isActive: true,
      createdAt: DateTime(2026, 1, 1),
    );

    test('fullName returns first + last name', () {
      expect(student.fullName, 'John Doe');
    });

    test('copyWith creates modified copy', () {
      final modified = student.copyWith(firstName: 'Jane', hasIEP: true);
      expect(modified.firstName, 'Jane');
      expect(modified.lastName, 'Doe');
      expect(modified.hasIEP, true);
      expect(modified.id, 'test-id');
    });

    test('default values are applied', () {
      expect(student.section, 'A');
      expect(student.hasIEP, false);
      expect(student.isActive, true);
      expect(student.email, isNull);
      expect(student.parentEmail, isNull);
      expect(student.parentPhone, isNull);
      expect(student.notes, isNull);
      expect(student.photoUrl, isNull);
    });

    test('JSON round-trip preserves data', () {
      final json = student.toJson();
      final restored = Student.fromJson(json);
      expect(restored.id, student.id);
      expect(restored.firstName, student.firstName);
      expect(restored.lastName, student.lastName);
      expect(restored.grade, student.grade);
      expect(restored.hasIEP, student.hasIEP);
    });

    test('equality works for identical data', () {
      final copy = student.copyWith();
      expect(copy, equals(student));
    });
  });
}
