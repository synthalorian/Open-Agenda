import '../base_repository.dart';
import '../hive_service.dart';
import '../../models/iep_goal.dart';

class IEPGoalRepository extends BaseRepository<IEPGoal> {
  IEPGoalRepository() : super(HiveService.iepGoalsBox);

  Future<List<IEPGoal>> getByStudent(String studentId) async {
    final all = await getAll();
    return all.where((g) => g.studentId == studentId).toList();
  }

  Future<List<IEPGoal>> getActiveGoals() async {
    final all = await getAll();
    return all.where((g) => g.status == GoalStatus.active).toList();
  }

  Future<List<IEPGoal>> getGoalsDueSoon(int days) async {
    final all = await getAll();
    final cutoff = DateTime.now().add(Duration(days: days));
    return all
        .where((g) =>
            g.status == GoalStatus.active &&
            g.targetDate.isBefore(cutoff))
        .toList();
  }
}

class IEPProgressNoteRepository extends BaseRepository<IEPProgressNote> {
  IEPProgressNoteRepository() : super(HiveService.iepProgressNotesBox);

  Future<List<IEPProgressNote>> getByGoal(String goalId) async {
    final all = await getAll();
    return all
        .where((n) => n.goalId == goalId)
        .toList()
      ..sort((a, b) => b.recordedAt.compareTo(a.recordedAt));
  }
}
