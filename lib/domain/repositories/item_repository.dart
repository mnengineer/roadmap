import 'package:roadmap/domain/entities/item.dart';

abstract class ItemRepository {
  Future<List<Item>> retrieveItems();
  Future<String> createItem({required Item item});
  Future<void> updateItem({required Item item});
  Future<void> deleteItem({required String id});
}
