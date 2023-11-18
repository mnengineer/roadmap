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

  Future<void> retrieveRoadmapItems(
    String itemId, {
    bool isRefreshing = false,
  }) async {
    if (isRefreshing) {
      state = const AsyncValue.loading();
    }
    try {
      final items = await _usecase.retrieveRoadmapItems(itemId);
      if (mounted) {
        state = AsyncValue.data(items);
      }
    } on Exception {
      // NOP
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
      state.whenData(
        (items) => state = AsyncValue.data(
          items..add(roadmapItem.copyWith(id: roadmapItemId)),
        ),
      );
    } on Exception {
      // NOP
    }
  }

  Future<void> updateRoadmapItem({
    required String itemId,
    required RoadmapItem updatedItem,
  }) async {
    try {
      await _usecase.updateRoadmapItem(itemId, updatedItem);
      state.whenData(
        (items) {
          state = AsyncValue.data(
            [
              for (final item in items)
                if (item.id == updatedItem.id) updatedItem else item,
            ],
          );
        },
      );
    } on Exception {
      // NOP
    }
  }

  Future<void> deleteRoadmapItem({
    required String itemId,
    required String roadmapItemId,
  }) async {
    try {
      await _usecase.deleteRoadmapItem(itemId, roadmapItemId);
      state.whenData(
        (items) => state = AsyncValue.data(
          items..removeWhere((item) => item.id == itemId),
        ),
      );
    } on Exception {
      // NOP
    }
  }
}
