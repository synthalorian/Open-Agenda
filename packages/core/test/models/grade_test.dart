import 'package:flutter_test/flutter_test.dart';
import 'package:open_agenda_core/models/grade.dart';

void main() {
  group('Assignment', () {
    final assignment = Assignment(
      id: 'a1',
      title: 'Chapter Test',
      subject: 'Math',
      dueDate: DateTime(2026, 4, 15),
      totalPoints: 100.0,
      category: AssignmentCategory.test,
      createdAt: DateTime(2026, 4, 1),
    );

    test('JSON round-trip', () {
      final json = assignment.toJson();
      final restored = Assignment.fromJson(json);
      expect(restored.title, 'Chapter Test');
      expect(restored.category, AssignmentCategory.test);
      expect(restored.totalPoints, 100.0);
    });

    test('copyWith preserves unmodified fields', () {
      final modified = assignment.copyWith(title: 'Updated');
      expect(modified.title, 'Updated');
      expect(modified.subject, 'Math');
      expect(modified.totalPoints, 100.0);
    });
  });

  group('GradeEntry', () {
    final entry = GradeEntry(
      id: 'g1',
      studentId: 's1',
      assignmentId: 'a1',
      pointsEarned: 85.0,
      gradedAt: DateTime(2026, 4, 16),
    );

    test('default isExcused is false', () {
      expect(entry.isExcused, false);
    });

    test('JSON round-trip', () {
      final json = entry.toJson();
      final restored = GradeEntry.fromJson(json);
      expect(restored.pointsEarned, 85.0);
      expect(restored.studentId, 's1');
    });
  });

  group('AssignmentCategory', () {
    test('all values exist', () {
      expect(AssignmentCategory.values.length, 5);
      expect(AssignmentCategory.values,
          contains(AssignmentCategory.homework));
      expect(AssignmentCategory.values,
          contains(AssignmentCategory.quiz));
      expect(AssignmentCategory.values,
          contains(AssignmentCategory.test));
      expect(AssignmentCategory.values,
          contains(AssignmentCategory.project));
      expect(AssignmentCategory.values,
          contains(AssignmentCategory.participation));
    });
  });
}
