import 'package:roadmap/data/datasources/remote/firebase_item_datasource.dart';
import 'package:roadmap/domain/entities/item_model.dart';
import 'package:roadmap/domain/repositories/item_repository.dart';

class ItemRepositoryImpl implements ItemRepository {
  ItemRepositoryImpl(this._dataSource);
  final FirebaseItemDataSource _dataSource;

  @override
  Future<List<Item>> retrieveItems() async {
    try {
      final snap = await _dataSource.retrieveItems();
      return snap.docs.map(Item.fromDocument).toList();
    } on Exception {
      return [];
    }
  }

  @override
  Future<String> createItem({
    required Item item,
  }) async {
    try {
      final docRef = await _dataSource.createItem(item);
      return docRef.id;
    } on Exception {
      return '';
    }
  }

  @override
  Future<void> updateItem({
    required Item item,
  }) async {
    try {
      await _dataSource.updateItem(item);
    } on Exception {
      // NOP
    }
  }

  @override
  Future<void> deleteItem({
    required String id,
  }) async {
    try {
      await _dataSource.deleteItem(id);
    } on Exception {
      // NOP
    }
  }
}
