import 'package:flutter_test/flutter_test.dart';
import 'package:open_agenda_core/models/lesson_plan.dart';

void main() {
  group('LessonPlan', () {
    final plan = LessonPlan(
      id: 'p1',
      title: 'Algebra Intro',
      subject: 'Math',
      date: DateTime(2026, 4, 2),
      startTime: '08:00',
      endTime: '08:50',
      objective: 'Learn basic algebra',
      activities: 'Lecture and practice',
      createdAt: DateTime(2026, 3, 30),
    );

    test('defaults', () {
      expect(plan.materials, isEmpty);
      expect(plan.isCompleted, false);
      expect(plan.assessment, isNull);
      expect(plan.notes, isNull);
    });

    test('JSON round-trip', () {
      final json = plan.toJson();
      final restored = LessonPlan.fromJson(json);
      expect(restored.title, 'Algebra Intro');
      expect(restored.startTime, '08:00');
    });

    test('copyWith toggles completed', () {
      final completed = plan.copyWith(isCompleted: true);
      expect(completed.isCompleted, true);
      expect(completed.title, 'Algebra Intro');
    });
  });
}
