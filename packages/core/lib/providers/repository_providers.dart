import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repositories/student_repository.dart';
import '../data/repositories/grade_repository.dart';
import '../data/repositories/attendance_repository.dart';
import '../data/repositories/lesson_plan_repository.dart';
import '../data/repositories/iep_repository.dart';
import '../data/repositories/teacher_repository.dart';
import '../models/student.dart';
import '../models/grade.dart';
import '../models/attendance.dart';
import '../models/lesson_plan.dart';
import '../models/iep_goal.dart';
import '../models/teacher_profile.dart';

// Repository providers
final studentRepositoryProvider =
    Provider<StudentRepository>((ref) => StudentRepository());

final assignmentRepositoryProvider =
    Provider<AssignmentRepository>((ref) => AssignmentRepository());

final gradeEntryRepositoryProvider =
    Provider<GradeEntryRepository>((ref) => GradeEntryRepository());

final attendanceRepositoryProvider =
    Provider<AttendanceRepository>((ref) => AttendanceRepository());

final lessonPlanRepositoryProvider =
    Provider<LessonPlanRepository>((ref) => LessonPlanRepository());

final iepGoalRepositoryProvider =
    Provider<IEPGoalRepository>((ref) => IEPGoalRepository());

final iepProgressNoteRepositoryProvider =
    Provider<IEPProgressNoteRepository>(
        (ref) => IEPProgressNoteRepository());

final teacherRepositoryProvider =
    Provider<TeacherRepository>((ref) => TeacherRepository());

// Data providers
final allStudentsProvider = FutureProvider<List<Student>>((ref) {
  return ref.watch(studentRepositoryProvider).getActiveStudents();
});

final allAssignmentsProvider = FutureProvider<List<Assignment>>((ref) {
  return ref.watch(assignmentRepositoryProvider).getAll();
});

final allAttendanceProvider =
    FutureProvider<List<AttendanceRecord>>((ref) {
  return ref.watch(attendanceRepositoryProvider).getAll();
});

final todayLessonPlansProvider =
    FutureProvider<List<LessonPlan>>((ref) {
  return ref
      .watch(lessonPlanRepositoryProvider)
      .getByDate(DateTime.now());
});

final activeIEPGoalsProvider = FutureProvider<List<IEPGoal>>((ref) {
  return ref.watch(iepGoalRepositoryProvider).getActiveGoals();
});

final teacherProfileProvider =
    FutureProvider<TeacherProfile?>((ref) {
  return ref.watch(teacherRepositoryProvider).getProfile();
});
