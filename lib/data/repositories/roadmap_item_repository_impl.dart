import 'package:roadmap/data/datasources/remote/firebase/roadmap_item_datasource.dart';
import 'package:roadmap/data/mappers/roadmap_item_mapper.dart';
import 'package:roadmap/domain/entities/roadmap_item.dart';
import 'package:roadmap/domain/repositories/roadmap_item_repository.dart';

class RoadmapItemRepositoryImpl implements RoadmapItemRepository {
  RoadmapItemRepositoryImpl(this._dataSource);
  final RoadmapItemDatasource _dataSource;

  @override
  Future<List<RoadmapItem>> retrieveRoadmapItems({
    required String goalItemId,
  }) async {
    try {
      final snap = await _dataSource.retrieveRoadmapItems(goalItemId);
      return snap.docs.map(fromDocument).toList();
    } on Exception {
      return [];
    }
  }

  @override
  Future<String> createRoadmapItem({
    required String goalItemId,
    required RoadmapItem roadmapItem,
  }) async {
    try {
      final docRef = await _dataSource.createRoadmapItem(
        goalItemId,
        toDocument(roadmapItem),
      );
      return docRef.id;
    } on Exception {
      return '';
    }
  }

  @override
  Future<void> updateRoadmapItem({
    required String goalItemId,
    required RoadmapItem roadmapItem,
  }) async {
    try {
      await _dataSource.updateRoadmapItem(
        goalItemId,
        roadmapItem.id!,
        toDocument(roadmapItem),
      );
    } on Exception {
      // NOP
    }
  }

  @override
  Future<void> deleteRoadmapItem({
    required String goalItemId,
    required String roadmapItemId,
  }) async {
    try {
      await _dataSource.deleteRoadmapItem(goalItemId, roadmapItemId);
    } on Exception {
      // NOP
    }
  }
}
