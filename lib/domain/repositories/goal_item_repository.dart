import 'package:roadmap/domain/entities/goal_item.dart';

abstract class GoalItemRepository {
  Future<List<GoalItem>> retrieveItems();
  Future<String> createItem({required GoalItem goalItem});
  Future<void> updateItem({required GoalItem goalItem});
  Future<void> deleteItem({required String goalItemId});
}
