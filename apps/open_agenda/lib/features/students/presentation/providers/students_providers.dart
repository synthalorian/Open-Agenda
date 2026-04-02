import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_agenda_core/open_agenda_core.dart';

final studentSearchQueryProvider = StateProvider<String>((ref) => '');

final filteredStudentsProvider = FutureProvider<List<Student>>((ref) {
  final query = ref.watch(studentSearchQueryProvider);
  final repo = ref.watch(studentRepositoryProvider);
  if (query.isEmpty) return repo.getActiveStudents();
  return repo.searchByName(query);
});

final studentByIdProvider =
    FutureProvider.family<Student?, String>((ref, id) {
  return ref.watch(studentRepositoryProvider).getById(id);
});
