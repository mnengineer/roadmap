import 'package:roadmap/domain/entities/roadmap_item.dart';

abstract class RoadmapItemRepository {
  Future<List<RoadmapItem>> retrieveRoadmapItems({
    required String goalItemId,
  });
  Future<String> createRoadmapItem({
    required String goalItemId,
    required RoadmapItem roadmapItem,
  });
  Future<void> updateRoadmapItem({
    required String goalItemId,
    required RoadmapItem roadmapItem,
  });
  Future<void> deleteRoadmapItem({
    required String goalItemId,
    required String roadmapItemId,
  });
}
