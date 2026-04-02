import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_agenda_core/open_agenda_core.dart';

final selectedPlanDateProvider =
    StateProvider<DateTime>((ref) => DateTime.now());

final lessonPlansForDateProvider =
    FutureProvider<List<LessonPlan>>((ref) {
  final date = ref.watch(selectedPlanDateProvider);
  return ref.watch(lessonPlanRepositoryProvider).getByDate(date);
});

final weekLessonPlansProvider =
    FutureProvider<List<LessonPlan>>((ref) {
  final now = DateTime.now();
  final start = now.subtract(Duration(days: now.weekday - 1));
  final end = start.add(const Duration(days: 6));
  return ref.watch(lessonPlanRepositoryProvider).getByDateRange(start, end);
});

final lessonPlanByIdProvider =
    FutureProvider.family<LessonPlan?, String>((ref, id) {
  return ref.watch(lessonPlanRepositoryProvider).getById(id);
});
