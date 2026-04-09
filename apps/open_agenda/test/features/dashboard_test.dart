import 'package:flutter_test/flutter_test.dart';

import 'package:open_agenda/features/dashboard/presentation/providers/dashboard_providers.dart';

void main() {
  group('DashboardStats', () {
    test('holds correct values', () {
      final stats = DashboardStats(
        studentCount: 18,
        absentToday: 2,
        avgGrade: 85.0,
        attendanceRate: 96.0,
        activeGoalCount: 8,
        goalsDueSoon: 3,
        todayPlans: [],
        teacherName: 'Ms. Smith',
      );

      expect(stats.studentCount, 18);
      expect(stats.absentToday, 2);
      expect(stats.avgGrade, 85.0);
      expect(stats.attendanceRate, 96.0);
      expect(stats.activeGoalCount, 8);
      expect(stats.goalsDueSoon, 3);
      expect(stats.todayPlans, isEmpty);
      expect(stats.teacherName, 'Ms. Smith');
    });

    test('handles null avgGrade', () {
      final stats = DashboardStats(
        studentCount: 0,
        absentToday: 0,
        attendanceRate: 0,
        activeGoalCount: 0,
        goalsDueSoon: 0,
        todayPlans: [],
        teacherName: 'Test',
      );

      expect(stats.avgGrade, isNull);
    });
  });

  group('getGreeting', () {
    test('returns a greeting string', () {
      final greeting = getGreeting();
      expect(greeting, anyOf(
        'Good morning,',
        'Good afternoon,',
        'Good evening,',
      ));
    });
  });
}
