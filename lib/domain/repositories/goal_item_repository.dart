import 'package:roadmap/domain/entities/goal_item.dart';

abstract class GoalItemRepository {
  Future<List<GoalItem>> retrieveGoalItems();
  Future<String> createGoalItem({required GoalItem goalItem});
  Future<void> updateGoalItem({required GoalItem goalItem});
  Future<void> deleteGoalItem({required String goalItemId});
}
