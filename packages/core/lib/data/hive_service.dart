import 'package:hive_flutter/hive_flutter.dart';

import '../models/student.dart';
import '../models/grade.dart';
import '../models/attendance.dart';
import '../models/lesson_plan.dart';
import '../models/iep_goal.dart';
import '../models/teacher_profile.dart';

/// Hive initialization and type adapter registration.
///
/// TypeId allocation:
///   0  = Student
///   1  = Assignment
///   2  = GradeEntry
///   3  = AssignmentCategory (enum)
///   4  = AttendanceRecord
///   5  = AttendanceStatus (enum)
///   6  = LessonPlan
///   7  = IEPGoal
///   8  = GoalStatus (enum)
///   9  = IEPProgressNote
///   10 = TeacherProfile
class HiveService {
  static const String studentsBox = 'students';
  static const String assignmentsBox = 'assignments';
  static const String gradeEntriesBox = 'grade_entries';
  static const String attendanceBox = 'attendance';
  static const String lessonPlansBox = 'lesson_plans';
  static const String iepGoalsBox = 'iep_goals';
  static const String iepProgressNotesBox = 'iep_progress_notes';
  static const String teacherProfileBox = 'teacher_profile';

  static Future<void> init() async {
    await Hive.initFlutter();

    // Models
    Hive.registerAdapter(StudentAdapter());
    Hive.registerAdapter(AssignmentAdapter());
    Hive.registerAdapter(GradeEntryAdapter());
    Hive.registerAdapter(AssignmentCategoryAdapter());
    Hive.registerAdapter(AttendanceRecordAdapter());
    Hive.registerAdapter(AttendanceStatusAdapter());
    Hive.registerAdapter(LessonPlanAdapter());
    Hive.registerAdapter(IEPGoalAdapter());
    Hive.registerAdapter(GoalStatusAdapter());
    Hive.registerAdapter(IEPProgressNoteAdapter());
    Hive.registerAdapter(TeacherProfileAdapter());

    // Open all boxes
    await Future.wait([
      Hive.openBox<Student>(studentsBox),
      Hive.openBox<Assignment>(assignmentsBox),
      Hive.openBox<GradeEntry>(gradeEntriesBox),
      Hive.openBox<AttendanceRecord>(attendanceBox),
      Hive.openBox<LessonPlan>(lessonPlansBox),
      Hive.openBox<IEPGoal>(iepGoalsBox),
      Hive.openBox<IEPProgressNote>(iepProgressNotesBox),
      Hive.openBox<TeacherProfile>(teacherProfileBox),
    ]);
  }

  static Future<void> clearAll() async {
    await Hive.deleteFromDisk();
  }
}
