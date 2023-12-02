import 'package:roadmap/data/datasources/remote/firebase/goal_item_datasource.dart';
import 'package:roadmap/data/mappers/goal_item_mapper.dart';
import 'package:roadmap/domain/entities/goal_item.dart';
import 'package:roadmap/domain/repositories/goal_item_repository.dart';

class GoalItemRepositoryImpl implements GoalItemRepository {
  GoalItemRepositoryImpl(this._dataSource);
  final GoalItemDatasource _dataSource;

  @override
  Future<List<GoalItem>> retrieveGoalItems() async {
    try {
      final snap = await _dataSource.retrieveGoalItems();
      return snap.docs.map(fromDocument).toList();
    } on Exception {
      return [];
    }
  }

  @override
  Future<String> createGoalItem({required GoalItem goalItem}) async {
    try {
      final docRef = await _dataSource.createGoalItem(toDocument(goalItem));
      return docRef.id;
    } on Exception {
      return '';
    }
  }

  @override
  Future<void> updateGoalItem({required GoalItem goalItem}) async {
    try {
      await _dataSource.updateGoalItem(goalItem.id!, toDocument(goalItem));
    } on Exception {
      // NOP
    }
  }

  @override
  Future<void> deleteGoalItem({required String goalItemId}) async {
    try {
      await _dataSource.deleteGoalItem(goalItemId);
    } on Exception {
      // NOP
    }
  }
}
