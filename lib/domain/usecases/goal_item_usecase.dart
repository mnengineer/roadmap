import 'package:roadmap/domain/entities/goal_item.dart';
import 'package:roadmap/domain/repositories/goal_item_repository.dart';

class GoalItemUsecase {
  GoalItemUsecase(this._repository);

  final GoalItemRepository _repository;

  Future<List<GoalItem>> retrieveItems() => _repository.retrieveItems();

  Future<String> createItem(GoalItem goalItem) =>
      _repository.createItem(goalItem: goalItem);

  Future<void> updateItem(GoalItem goalItem) =>
      _repository.updateItem(goalItem: goalItem);

  Future<void> deleteItem(String goalItemId) =>
      _repository.deleteItem(goalItemId: goalItemId);
}
