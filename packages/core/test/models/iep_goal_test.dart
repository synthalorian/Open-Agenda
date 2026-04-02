import 'package:flutter_test/flutter_test.dart';
import 'package:open_agenda_core/models/iep_goal.dart';

void main() {
  group('IEPGoal', () {
    final goal = IEPGoal(
      id: 'g1',
      studentId: 's1',
      goalText: 'Improve reading',
      category: 'Reading',
      targetDate: DateTime(2026, 7, 1),
      createdAt: DateTime(2026, 4, 1),
    );

    test('defaults', () {
      expect(goal.progressPercent, 0.0);
      expect(goal.accommodations, isEmpty);
      expect(goal.status, GoalStatus.active);
      expect(goal.notes, isNull);
    });

    test('JSON round-trip', () {
      final json = goal.toJson();
      final restored = IEPGoal.fromJson(json);
      expect(restored.goalText, 'Improve reading');
      expect(restored.status, GoalStatus.active);
    });

    test('copyWith updates progress', () {
      final updated = goal.copyWith(progressPercent: 75.0);
      expect(updated.progressPercent, 75.0);
      expect(updated.goalText, 'Improve reading');
    });
  });

  group('IEPProgressNote', () {
    final note = IEPProgressNote(
      id: 'n1',
      goalId: 'g1',
      note: 'Good progress',
      progressPercent: 50.0,
      recordedAt: DateTime(2026, 4, 15),
    );

    test('JSON round-trip', () {
      final json = note.toJson();
      final restored = IEPProgressNote.fromJson(json);
      expect(restored.note, 'Good progress');
      expect(restored.progressPercent, 50.0);
    });
  });
}
