import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_agenda_core/open_agenda_core.dart';

final dashboardStatsProvider = FutureProvider<DashboardStats>((ref) async {
  final students = await ref.watch(allStudentsProvider.future);
  final goals = await ref.watch(activeIEPGoalsProvider.future);
  final plans = await ref.watch(todayLessonPlansProvider.future);
  final profile = await ref.watch(teacherProfileProvider.future);

  // Attendance rate for this month
  final now = DateTime.now();
  final monthStart = DateTime(now.year, now.month, 1);
  final attendanceRepo = ref.watch(attendanceRepositoryProvider);
  final attendanceRate =
      await attendanceRepo.getOverallAttendanceRate(monthStart, now);

  // Today's absent count
  final todayRecords = await attendanceRepo.getByDate(now);
  final absentToday = todayRecords
      .where((r) => r.status == AttendanceStatus.absent)
      .length;

  // Average grade across all entries
  final gradeRepo = ref.watch(gradeEntryRepositoryProvider);
  final allGrades = await gradeRepo.getAll();
  double? avgGrade;
  if (allGrades.isNotEmpty) {
    final assignmentRepo = ref.watch(assignmentRepositoryProvider);
    double totalPct = 0;
    int count = 0;
    for (final g in allGrades) {
      final a = await assignmentRepo.getById(g.assignmentId);
      if (a != null && a.totalPoints > 0) {
        totalPct += (g.pointsEarned / a.totalPoints) * 100;
        count++;
      }
    }
    if (count > 0) avgGrade = totalPct / count;
  }

  // Goals due this week
  final goalRepo = ref.watch(iepGoalRepositoryProvider);
  final goalsDueSoon = await goalRepo.getGoalsDueSoon(7);

  return DashboardStats(
    studentCount: students.length,
    absentToday: absentToday,
    avgGrade: avgGrade,
    attendanceRate: attendanceRate,
    activeGoalCount: goals.length,
    goalsDueSoon: goalsDueSoon.length,
    todayPlans: plans,
    teacherName: profile?.name ?? 'Teacher',
  );
});

class DashboardStats {
  final int studentCount;
  final int absentToday;
  final double? avgGrade;
  final double attendanceRate;
  final int activeGoalCount;
  final int goalsDueSoon;
  final List<LessonPlan> todayPlans;
  final String teacherName;

  DashboardStats({
    required this.studentCount,
    required this.absentToday,
    this.avgGrade,
    required this.attendanceRate,
    required this.activeGoalCount,
    required this.goalsDueSoon,
    required this.todayPlans,
    required this.teacherName,
  });
}

String getGreeting() {
  final hour = DateTime.now().hour;
  if (hour < 12) return 'Good morning,';
  if (hour < 17) return 'Good afternoon,';
  return 'Good evening,';
}
