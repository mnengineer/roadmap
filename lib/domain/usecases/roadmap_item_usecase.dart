import 'package:roadmap/domain/entities/roadmap_item.dart';
import 'package:roadmap/domain/repositories/roadmap_item_repository.dart';

class RoadmapItemUsecase {
  RoadmapItemUsecase(this._repository);

  final RoadmapItemRepository _repository;

  Future<List<RoadmapItem>> retrieveRoadmapItems(String goalItemId) =>
      _repository.retrieveRoadmapItems(goalItemId: goalItemId);

  Future<String> createRoadmapItem(
    String goalItemId,
    RoadmapItem roadmapItem,
  ) =>
      _repository.createRoadmapItem(
        goalItemId: goalItemId,
        roadmapItem: roadmapItem,
      );

  Future<void> updateRoadmapItem(String goalItemId, RoadmapItem roadmapItem) =>
      _repository.updateRoadmapItem(
        goalItemId: goalItemId,
        roadmapItem: roadmapItem,
      );

  Future<void> deleteRoadmapItem(String goalItemId, String roadmapItemId) =>
      _repository.deleteRoadmapItem(
        goalItemId: goalItemId,
        roadmapItemId: roadmapItemId,
      );
}
