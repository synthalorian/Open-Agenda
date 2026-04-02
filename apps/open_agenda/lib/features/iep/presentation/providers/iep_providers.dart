import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_agenda_core/open_agenda_core.dart';

enum GoalFilter { all, active, dueSoon, met }

final iepGoalFilterProvider = StateProvider<GoalFilter>((ref) => GoalFilter.active);

final filteredIEPGoalsProvider = FutureProvider<List<IEPGoal>>((ref) async {
  final filter = ref.watch(iepGoalFilterProvider);
  final repo = ref.watch(iepGoalRepositoryProvider);

  switch (filter) {
    case GoalFilter.all:
      return repo.getAll();
    case GoalFilter.active:
      return repo.getActiveGoals();
    case GoalFilter.dueSoon:
      return repo.getGoalsDueSoon(14);
    case GoalFilter.met:
      final all = await repo.getAll();
      return all.where((g) => g.status == GoalStatus.met).toList();
  }
});

final iepGoalByIdProvider =
    FutureProvider.family<IEPGoal?, String>((ref, id) {
  return ref.watch(iepGoalRepositoryProvider).getById(id);
});

final progressNotesForGoalProvider =
    FutureProvider.family<List<IEPProgressNote>, String>((ref, goalId) {
  return ref.watch(iepProgressNoteRepositoryProvider).getByGoal(goalId);
});
