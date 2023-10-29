import 'package:roadmap/domain/entities/item.dart';
import 'package:roadmap/domain/entities/timelineItem.dart';
import 'package:roadmap/domain/repositories/item_repository.dart';

class ItemUsecase {
  ItemUsecase(this._repository);

  final ItemRepository _repository;

  Future<List<Item>> retrieveItems() => _repository.retrieveItems();

  Future<List<TimelineItem>> retrieveTimelineItems(String itemId) =>
      _repository.retrieveTimelineItems(itemId: itemId);

  Future<String> createItem(Item item) => _repository.createItem(item: item);

  Future<String> createTimelineItem(String itemId, TimelineItem timelineItem) =>
      _repository.createTimelineItem(
        itemId: itemId,
        timelineItem: timelineItem,
      );
  Future<void> updateItem(Item item) => _repository.updateItem(item: item);

  Future<void> updateTimelineItem(String itemId, TimelineItem timelineItem) =>
      _repository.updateTimelineItem(
        itemId: itemId,
        timelineItem: timelineItem,
      );

  Future<void> deleteItem(String id) => _repository.deleteItem(id: id);

  Future<void> deleteTimelineItem(String itemId, String timelineId) =>
      _repository.deleteTimelineItem(
        itemId: itemId,
        timelineItemId: timelineId,
      );
}
