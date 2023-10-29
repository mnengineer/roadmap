import 'package:roadmap/domain/entities/item.dart';
import 'package:roadmap/domain/entities/timelineItem.dart';

abstract class ItemRepository {
  Future<List<Item>> retrieveItems();
  Future<List<TimelineItem>> retrieveTimelineItems({
    required String itemId,
  });
  Future<String> createItem({required Item item});
  Future<String> createTimelineItem({
    required String itemId,
    required TimelineItem timelineItem,
  });
  Future<void> updateItem({required Item item});
  Future<void> updateTimelineItem({
    required String itemId,
    required TimelineItem timelineItem,
  });
  Future<void> deleteItem({required String id});
  Future<void> deleteTimelineItem({
    required String itemId,
    required String timelineItemId,
  });
}
