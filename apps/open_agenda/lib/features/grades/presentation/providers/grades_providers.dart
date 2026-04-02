import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_agenda_core/open_agenda_core.dart';

final selectedSubjectProvider = StateProvider<String?>((ref) => null);

final assignmentsBySubjectProvider = FutureProvider<List<Assignment>>((ref) {
  final subject = ref.watch(selectedSubjectProvider);
  final repo = ref.watch(assignmentRepositoryProvider);
  if (subject == null) return repo.getAll();
  return repo.getBySubject(subject);
});

final gradeEntriesForAssignmentProvider =
    FutureProvider.family<List<GradeEntry>, String>((ref, assignmentId) {
  return ref.watch(gradeEntryRepositoryProvider).getByAssignment(assignmentId);
});

final classAverageProvider =
    FutureProvider.family<double?, String>((ref, assignmentId) {
  return ref
      .watch(gradeEntryRepositoryProvider)
      .getAverageForAssignment(assignmentId);
});
