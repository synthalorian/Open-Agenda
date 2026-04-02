import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_agenda_core/open_agenda_core.dart';

final settingsTeacherProfileProvider =
    FutureProvider<TeacherProfile?>((ref) {
  return ref.watch(teacherRepositoryProvider).getProfile();
});
