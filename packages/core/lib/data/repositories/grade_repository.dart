import '../base_repository.dart';
import '../hive_service.dart';
import '../../models/grade.dart';

class AssignmentRepository extends BaseRepository<Assignment> {
  AssignmentRepository() : super(HiveService.assignmentsBox);

  Future<List<Assignment>> getBySubject(String subject) async {
    final all = await getAll();
    return all.where((a) => a.subject == subject).toList();
  }
}

class GradeEntryRepository extends BaseRepository<GradeEntry> {
  GradeEntryRepository() : super(HiveService.gradeEntriesBox);

  Future<List<GradeEntry>> getByStudent(String studentId) async {
    final all = await getAll();
    return all.where((g) => g.studentId == studentId).toList();
  }

  Future<List<GradeEntry>> getByAssignment(String assignmentId) async {
    final all = await getAll();
    return all.where((g) => g.assignmentId == assignmentId).toList();
  }

  Future<double?> getAverageForStudent(String studentId) async {
    final grades = await getByStudent(studentId);
    if (grades.isEmpty) return null;
    final total = grades.fold(0.0, (sum, g) => sum + g.pointsEarned);
    return total / grades.length;
  }

  Future<double?> getAverageForAssignment(String assignmentId) async {
    final grades = await getByAssignment(assignmentId);
    if (grades.isEmpty) return null;
    final total = grades.fold(0.0, (sum, g) => sum + g.pointsEarned);
    return total / grades.length;
  }
}
