import '../base_repository.dart';
import '../hive_service.dart';
import '../../models/lesson_plan.dart';

class LessonPlanRepository extends BaseRepository<LessonPlan> {
  LessonPlanRepository() : super(HiveService.lessonPlansBox);

  Future<List<LessonPlan>> getByDate(DateTime date) async {
    final all = await getAll();
    return all
        .where((p) =>
            p.date.year == date.year &&
            p.date.month == date.month &&
            p.date.day == date.day)
        .toList()
      ..sort((a, b) => a.startTime.compareTo(b.startTime));
  }

  Future<List<LessonPlan>> getByDateRange(
      DateTime start, DateTime end) async {
    final all = await getAll();
    return all
        .where(
            (p) => !p.date.isBefore(start) && !p.date.isAfter(end))
        .toList()
      ..sort((a, b) => a.date.compareTo(b.date));
  }

  Future<List<LessonPlan>> getIncomplete() async {
    final all = await getAll();
    return all.where((p) => !p.isCompleted).toList();
  }
}
