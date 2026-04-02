import '../base_repository.dart';
import '../hive_service.dart';
import '../../models/student.dart';

class StudentRepository extends BaseRepository<Student> {
  StudentRepository() : super(HiveService.studentsBox);

  Future<List<Student>> searchByName(String query) async {
    final all = await getAll();
    final q = query.toLowerCase();
    return all
        .where((s) => s.fullName.toLowerCase().contains(q))
        .toList();
  }

  Future<List<Student>> getByGrade(int grade) async {
    final all = await getAll();
    return all.where((s) => s.grade == grade).toList();
  }

  Future<List<Student>> getActiveStudents() async {
    final all = await getAll();
    return all.where((s) => s.isActive).toList();
  }

  Future<List<Student>> getIEPStudents() async {
    final all = await getAll();
    return all.where((s) => s.hasIEP && s.isActive).toList();
  }
}
