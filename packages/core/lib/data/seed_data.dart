import 'package:uuid/uuid.dart';

import 'repositories/student_repository.dart';
import 'repositories/grade_repository.dart';
import 'repositories/attendance_repository.dart';
import 'repositories/lesson_plan_repository.dart';
import 'repositories/iep_repository.dart';
import 'repositories/teacher_repository.dart';
import '../models/student.dart';
import '../models/grade.dart';
import '../models/attendance.dart';
import '../models/lesson_plan.dart';
import '../models/iep_goal.dart';
import '../models/teacher_profile.dart';

const _uuid = Uuid();

class SeedData {
  static Future<void> seedIfEmpty() async {
    final studentRepo = StudentRepository();
    final existing = await studentRepo.getAll();
    if (existing.isNotEmpty) return;

    await _seedTeacher();
    final studentIds = await _seedStudents(studentRepo);
    await _seedAssignmentsAndGrades(studentIds);
    await _seedAttendance(studentIds);
    await _seedLessonPlans();
    await _seedIEPGoals(studentIds);
  }

  static Future<void> _seedTeacher() async {
    final repo = TeacherRepository();
    await repo.saveProfile(TeacherProfile(
      id: 'default',
      name: 'Teacher',
      email: 'teacher@school.edu',
      school: 'Lakeland High School',
      subjects: ['Math', 'Science', 'English', 'History'],
      gradesTaught: [9, 10, 11, 12],
    ));
  }

  static Future<List<String>> _seedStudents(
      StudentRepository repo) async {
    final now = DateTime.now();
    final students = [
      ('Emma', 'Johnson', 10, 'A', false),
      ('Liam', 'Williams', 10, 'A', false),
      ('Olivia', 'Brown', 10, 'A', true),
      ('Noah', 'Jones', 10, 'B', false),
      ('Ava', 'Garcia', 10, 'B', false),
      ('Ethan', 'Miller', 11, 'A', false),
      ('Sophia', 'Davis', 11, 'A', true),
      ('Mason', 'Rodriguez', 11, 'A', false),
      ('Isabella', 'Martinez', 11, 'B', false),
      ('James', 'Anderson', 11, 'B', false),
      ('Mia', 'Taylor', 12, 'A', false),
      ('Benjamin', 'Thomas', 12, 'A', false),
      ('Charlotte', 'Hernandez', 12, 'A', true),
      ('Lucas', 'Moore', 12, 'B', false),
      ('Amelia', 'Martin', 12, 'B', false),
      ('Alexander', 'Jackson', 9, 'A', false),
      ('Harper', 'Thompson', 9, 'A', false),
      ('Daniel', 'White', 9, 'B', true),
    ];

    final ids = <String>[];
    for (final s in students) {
      final id = _uuid.v4();
      ids.add(id);
      await repo.save(
        id,
        Student(
          id: id,
          firstName: s.$1,
          lastName: s.$2,
          grade: s.$3,
          section: s.$4,
          hasIEP: s.$5,
          createdAt: now,
          parentEmail: '${s.$1.toLowerCase()}.parent@email.com',
          parentPhone: '(555) ${100 + ids.length}-${1000 + ids.length}',
        ),
      );
    }
    return ids;
  }

  static Future<void> _seedAssignmentsAndGrades(
      List<String> studentIds) async {
    final assignmentRepo = AssignmentRepository();
    final gradeRepo = GradeEntryRepository();
    final now = DateTime.now();

    final assignments = [
      ('Chapter 5 Quiz', 'Math', AssignmentCategory.quiz, 20.0, -3),
      ('Lab Report: Photosynthesis', 'Science', AssignmentCategory.project, 50.0, -5),
      ('Essay: To Kill a Mockingbird', 'English', AssignmentCategory.homework, 100.0, -7),
      ('Civil War Test', 'History', AssignmentCategory.test, 100.0, -2),
      ('Homework Set 12', 'Math', AssignmentCategory.homework, 10.0, -1),
      ('Participation Week 8', 'English', AssignmentCategory.participation, 10.0, 0),
    ];

    final scores = [0.95, 0.87, 0.78, 0.92, 0.65, 0.88, 0.73, 0.91, 0.84, 0.69];

    for (final a in assignments) {
      final aId = _uuid.v4();
      await assignmentRepo.save(
        aId,
        Assignment(
          id: aId,
          title: a.$1,
          subject: a.$2,
          category: a.$3,
          totalPoints: a.$4,
          dueDate: now.add(Duration(days: a.$5)),
          createdAt: now.add(Duration(days: a.$5 - 3)),
        ),
      );

      for (var i = 0; i < studentIds.length; i++) {
        final gId = _uuid.v4();
        final score = a.$4 * scores[i % scores.length];
        await gradeRepo.save(
          gId,
          GradeEntry(
            id: gId,
            studentId: studentIds[i],
            assignmentId: aId,
            pointsEarned: double.parse(score.toStringAsFixed(1)),
            gradedAt: now.add(Duration(days: a.$5 + 1)),
          ),
        );
      }
    }
  }

  static Future<void> _seedAttendance(List<String> studentIds) async {
    final repo = AttendanceRepository();
    final now = DateTime.now();

    for (var day = 14; day >= 0; day--) {
      final date = now.subtract(Duration(days: day));
      if (date.weekday == DateTime.saturday ||
          date.weekday == DateTime.sunday) continue;

      for (var i = 0; i < studentIds.length; i++) {
        final id = _uuid.v4();
        AttendanceStatus status;
        if (i == 3 && day == 0) {
          status = AttendanceStatus.absent;
        } else if (i == 7 && day < 3) {
          status = AttendanceStatus.tardy;
        } else if (i == 12 && day == 1) {
          status = AttendanceStatus.excused;
        } else {
          status = AttendanceStatus.present;
        }

        await repo.save(
          id,
          AttendanceRecord(
            id: id,
            studentId: studentIds[i],
            date: DateTime(date.year, date.month, date.day),
            status: status,
          ),
        );
      }
    }
  }

  static Future<void> _seedLessonPlans() async {
    final repo = LessonPlanRepository();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final plans = [
      ('Quadratic Equations', 'Math', '8:00', '8:50', 'Students will solve quadratic equations using the quadratic formula', ['Textbook Ch 5', 'Graphing calculators', 'Worksheets'], false),
      ('Photosynthesis Lab', 'Science', '9:15', '10:05', 'Students will demonstrate understanding of photosynthesis through hands-on experiment', ['Lab equipment', 'Plant samples', 'Lab notebooks'], false),
      ('Literary Analysis', 'English', '10:20', '11:10', 'Students will analyze themes in To Kill a Mockingbird chapters 15-17', ['Novel copies', 'Discussion guide'], false),
      ('Civil War Causes', 'History', '12:00', '12:50', 'Students will identify and explain the primary causes of the Civil War', ['Textbook', 'Primary source documents', 'Timeline worksheet'], false),
      ('Review Session', 'Math', '1:05', '1:55', 'Review homework set 12 and prepare for upcoming test', ['Answer key', 'Whiteboard markers'], false),
    ];

    for (var dayOffset = -2; dayOffset <= 3; dayOffset++) {
      final date = today.add(Duration(days: dayOffset));
      if (date.weekday == DateTime.saturday ||
          date.weekday == DateTime.sunday) continue;

      for (final p in plans) {
        final id = _uuid.v4();
        await repo.save(
          id,
          LessonPlan(
            id: id,
            title: p.$1,
            subject: p.$2,
            date: date,
            startTime: p.$3,
            endTime: p.$4,
            objective: p.$5,
            materials: p.$6,
            activities: 'Warm-up activity, instruction, guided practice, independent work',
            isCompleted: dayOffset < 0,
            createdAt: date.subtract(const Duration(days: 2)),
          ),
        );
      }
    }
  }

  static Future<void> _seedIEPGoals(List<String> studentIds) async {
    final goalRepo = IEPGoalRepository();
    final noteRepo = IEPProgressNoteRepository();
    final now = DateTime.now();

    // IEP students are at indices 2, 6, 12, 17
    final iepStudents = [
      (studentIds[2], 'Reading', 'Improve reading comprehension to grade level by end of semester', 65.0, ['Extended time on reading assignments', 'Audio versions of texts']),
      (studentIds[2], 'Writing', 'Write 5-paragraph essays with minimal support', 40.0, ['Graphic organizers', 'Writing checklist']),
      (studentIds[6], 'Math', 'Master multi-step word problems with 80% accuracy', 75.0, ['Calculator access', 'Step-by-step problem guides']),
      (studentIds[6], 'Behavior', 'Stay on task for 30+ minutes during independent work', 50.0, ['Preferential seating', 'Break cards', 'Timer']),
      (studentIds[12], 'Reading', 'Increase reading fluency to 120 WPM', 80.0, ['Daily reading practice', 'Fluency passages']),
      (studentIds[12], 'Math', 'Complete algebra assignments with 70% accuracy', 55.0, ['Modified assignments', 'Peer tutoring']),
      (studentIds[17], 'Writing', 'Produce legible handwriting at grade-appropriate speed', 30.0, ['OT consultation', 'Typing alternative']),
      (studentIds[17], 'Social Skills', 'Initiate peer interactions 3+ times per day', 45.0, ['Social stories', 'Lunch buddy program']),
    ];

    for (final g in iepStudents) {
      final goalId = _uuid.v4();
      await goalRepo.save(
        goalId,
        IEPGoal(
          id: goalId,
          studentId: g.$1,
          category: g.$2,
          goalText: g.$3,
          progressPercent: g.$4,
          accommodations: g.$5,
          targetDate: now.add(const Duration(days: 90)),
          createdAt: now.subtract(const Duration(days: 30)),
        ),
      );

      // Add a couple progress notes per goal
      for (var w = 2; w >= 0; w--) {
        final noteId = _uuid.v4();
        await noteRepo.save(
          noteId,
          IEPProgressNote(
            id: noteId,
            goalId: goalId,
            note: 'Week ${3 - w} progress check - student ${w == 0 ? "showing improvement" : "working toward goal"}',
            progressPercent: g.$4 - (w * 10),
            recordedAt: now.subtract(Duration(days: w * 7)),
          ),
        );
      }
    }
  }
}
