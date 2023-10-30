import 'package:roadmap/data/datasources/remote/firebase/goal_item_datasource.dart';
import 'package:roadmap/data/mappers/goal_item_mapper.dart';
import 'package:roadmap/domain/entities/goal_item.dart';
import 'package:roadmap/domain/repositories/goal_item_repository.dart';

class GoalItemRepositoryImpl implements GoalItemRepository {
  GoalItemRepositoryImpl(this._dataSource);
  final GoalItemDatasource _dataSource;

  @override
  Future<List<GoalItem>> retrieveItems() async {
    try {
      final snap = await _dataSource.retrieveItems();
      return snap.docs.map(fromDocument).toList();
    } on Exception {
      return [];
    }
  }

  @override
  Future<String> createItem({required GoalItem goalItem}) async {
    try {
      final docRef = await _dataSource.createItem(toDocument(goalItem));
      return docRef.id;
    } on Exception {
      return '';
    }
  }

  @override
  Future<void> updateItem({required GoalItem goalItem}) async {
    try {
      await _dataSource.updateItem(goalItem.id!, toDocument(goalItem));
    } on Exception {
      // NOP
    }
  }

  @override
  Future<void> deleteItem({required String goalItemId}) async {
    try {
      await _dataSource.deleteItem(goalItemId);
    } on Exception {
      // NOP
    }
  }
}
