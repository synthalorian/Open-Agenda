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

/// Computes a list of percentage scores for every grade entry.
/// Each entry becomes (pointsEarned / assignment.totalPoints) * 100.
final gradeDistributionProvider = FutureProvider<List<double>>((ref) async {
  final gradeRepo = ref.watch(gradeEntryRepositoryProvider);
  final assignmentRepo = ref.watch(assignmentRepositoryProvider);
  final allGrades = await gradeRepo.getAll();

  final List<double> percentages = [];
  for (final g in allGrades) {
    final a = await assignmentRepo.getById(g.assignmentId);
    if (a != null && a.totalPoints > 0) {
      percentages.add((g.pointsEarned / a.totalPoints) * 100);
    }
  }
  return percentages;
});

/// Computes the overall attendance rate for each of the last 4 weeks.
/// Returns a list of 4 doubles (0-100), oldest week first.
final attendanceTrendProvider = FutureProvider<List<double>>((ref) async {
  final attendanceRepo = ref.watch(attendanceRepositoryProvider);
  final now = DateTime.now();
  final List<double> rates = [];

  for (int w = 3; w >= 0; w--) {
    final weekEnd = now.subtract(Duration(days: w * 7));
    final weekStart = weekEnd.subtract(const Duration(days: 6));
    final rate = await attendanceRepo.getOverallAttendanceRate(weekStart, weekEnd);
    rates.add(rate);
  }
  return rates;
});

/// Computes average grade percentage per subject.
/// Returns a map of subject name -> average percentage (0-100).
final subjectPerformanceProvider =
    FutureProvider<Map<String, double>>((ref) async {
  final gradeRepo = ref.watch(gradeEntryRepositoryProvider);
  final assignmentRepo = ref.watch(assignmentRepositoryProvider);
  final allGrades = await gradeRepo.getAll();

  // Group percentages by subject
  final Map<String, List<double>> subjectPcts = {};
  for (final g in allGrades) {
    final a = await assignmentRepo.getById(g.assignmentId);
    if (a != null && a.totalPoints > 0) {
      final pct = (g.pointsEarned / a.totalPoints) * 100;
      subjectPcts.putIfAbsent(a.subject.toLowerCase(), () => []).add(pct);
    }
  }

  // Average each subject
  final Map<String, double> averages = {};
  for (final entry in subjectPcts.entries) {
    final sum = entry.value.fold(0.0, (s, v) => s + v);
    averages[entry.key] = sum / entry.value.length;
  }
  return averages;
});

String getGreeting() {
  final hour = DateTime.now().hour;
  if (hour < 12) return 'Good morning,';
  if (hour < 17) return 'Good afternoon,';
  return 'Good evening,';
}
