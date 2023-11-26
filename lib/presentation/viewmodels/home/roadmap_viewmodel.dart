import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roadmap/domain/entities/goal_item.dart';
import 'package:roadmap/domain/entities/roadmap_item.dart';
import 'package:roadmap/domain/usecases/roadmap_item_usecase.dart';
import 'package:roadmap/presentation/routes/navigation_service.dart';

class RoadmapViewmodel extends StateNotifier<AsyncValue<List<RoadmapItem>>> {
  RoadmapViewmodel(this._navigationService, this._usecase)
      : super(const AsyncValue.loading());

  final NavigationService _navigationService;
  final RoadmapItemUsecase _usecase;

  void navigatePop() => _navigationService.navigatePop();
  void navigateToEdit({required GoalItem item}) =>
      _navigationService.navigateToEdit(item);

  void _updateStateWithSortedItems(List<RoadmapItem> items) {
    items.sort((a, b) => a.deadline.compareTo(b.deadline));
    state = AsyncValue.data(items);
  }

  Future<void> retrieveRoadmapItems(
    String itemId, {
    bool isRefreshing = false,
  }) async {
    if (isRefreshing) {
      state = const AsyncValue.loading();
    }
    try {
      final items = await _usecase.retrieveRoadmapItems(itemId);
      _updateStateWithSortedItems(items);
    } on Exception {
      state =
          const AsyncValue.error('Could not retrieve items.', StackTrace.empty);
    }
  }

  Future<void> addRoadmapItem({
    required String itemId,
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
          await _usecase.createRoadmapItem(itemId, roadmapItem);
      final newItems = List<RoadmapItem>.from(state.value ?? [])
        ..add(roadmapItem.copyWith(id: roadmapItemId));
      _updateStateWithSortedItems(newItems);
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
      _updateStateWithSortedItems(updatedItems);
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
      final newItems = List<RoadmapItem>.from(state.value ?? [])
        ..removeWhere((item) => item.id == roadmapItemId);
      _updateStateWithSortedItems(newItems);
    } on Exception {
      state =
          const AsyncValue.error('Could not delete item.', StackTrace.empty);
    }
  }
}
