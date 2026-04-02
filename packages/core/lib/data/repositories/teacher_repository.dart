import '../base_repository.dart';
import '../hive_service.dart';
import '../../models/teacher_profile.dart';

class TeacherRepository extends BaseRepository<TeacherProfile> {
  static const String _profileKey = 'default';

  TeacherRepository() : super(HiveService.teacherProfileBox);

  Future<TeacherProfile?> getProfile() async {
    return getById(_profileKey);
  }

  Future<void> saveProfile(TeacherProfile profile) async {
    await save(_profileKey, profile);
  }
}
