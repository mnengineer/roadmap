import 'package:roadmap/domain/entities/item.dart';
import 'package:roadmap/domain/repositories/item_repository.dart';

class ItemUsecase {
  ItemUsecase(this._repository);

  final ItemRepository _repository;

  Future<List<Item>> retrieveItems() => _repository.retrieveItems();
  Future<String> createItem(Item item) => _repository.createItem(item: item);
  Future<void> updateItem(Item item) => _repository.updateItem(item: item);
  Future<void> deleteItem(String id) => _repository.deleteItem(id: id);
}
