import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roadmap/domain/entities/roadmap_item.dart';
import 'package:roadmap/domain/usecases/roadmap_item_usecase.dart';
import 'package:roadmap/presentation/routes/navigation_service.dart';

class RoadmapViewmodel extends StateNotifier<AsyncValue<List<RoadmapItem>>> {
  RoadmapViewmodel(this._navigationService, this._usecase)
      : super(const AsyncValue.loading());

  final NavigationService _navigationService;
  final RoadmapItemUsecase _usecase;

  void navigatePop() => _navigationService.navigatePop();

  void _updateSortedState(List<RoadmapItem> roadmapItems) {
    roadmapItems.sort((a, b) => a.deadline.compareTo(b.deadline));
    state = AsyncValue.data(roadmapItems);
  }

  Future<void> retrieveRoadmapItems(String goalItemId) async {
    state = const AsyncValue.loading();
    try {
      final items = await _usecase.retrieveRoadmapItems(goalItemId);
      _updateSortedState(items);
    } on Exception {
      state =
          const AsyncValue.error('Could not retrieve items.', StackTrace.empty);
    }
  }

  Future<void> addRoadmapItem({
    required String goalItemId,
    required String title,
    required String description,
    required DateTime deadline,
    bool isCompleted = false,
  }) async {
    try {
      final roadmapItem = RoadmapItem(
        title: title,
        description: description,
        deadline: deadline,
        isCompleted: isCompleted,
        createdAt: DateTime.now(),
      );
      final roadmapItemId =
          await _usecase.createRoadmapItem(goalItemId, roadmapItem);
      final addedRoadmapItems = List<RoadmapItem>.from(state.value ?? [])
        ..add(roadmapItem.copyWith(id: roadmapItemId));
      _updateSortedState(addedRoadmapItems);
    } on Exception {
      state = const AsyncValue.error('Could not add item..', StackTrace.empty);
    }
  }

  Future<void> updateRoadmapItem({
    required String goalItemId,
    required RoadmapItem updatedItem,
  }) async {
    try {
      await _usecase.updateRoadmapItem(goalItemId, updatedItem);
      final currentItems = state.value?.toList() ?? [];
      final updatedItems = currentItems
          .map((item) => item.id == updatedItem.id ? updatedItem : item)
          .toList();
      _updateSortedState(updatedItems);
    } on Exception {
      state =
          const AsyncValue.error('Could not update item.', StackTrace.empty);
    }
  }

  Future<void> deleteRoadmapItem({
    required String itemId,
    required String roadmapItemId,
  }) async {
    try {
      await _usecase.deleteRoadmapItem(itemId, roadmapItemId);
      final currentItem = List<RoadmapItem>.from(state.value ?? [])
        ..removeWhere((item) => item.id == roadmapItemId);
      _updateSortedState(currentItem);
    } on Exception {
      state =
          const AsyncValue.error('Could not delete item.', StackTrace.empty);
    }
  }
}
