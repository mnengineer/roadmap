import 'package:roadmap/domain/entities/goal_item.dart';
import 'package:roadmap/domain/repositories/goal_item_repository.dart';

class GoalItemUsecase {
  GoalItemUsecase(this._repository);

  final GoalItemRepository _repository;

  Future<List<GoalItem>> retrieveGoalItems() => _repository.retrieveGoalItems();

  Future<String> createGoalItem(GoalItem goalItem) =>
      _repository.createGoalItem(goalItem: goalItem);

  Future<void> updateGoalItem(GoalItem goalItem) =>
      _repository.updateGoalItem(goalItem: goalItem);

  Future<void> deleteGoalItem(String goalItemId) =>
      _repository.deleteGoalItem(goalItemId: goalItemId);
}
