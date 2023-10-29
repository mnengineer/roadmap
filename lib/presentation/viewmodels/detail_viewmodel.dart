import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roadmap/domain/entities/item.dart';
import 'package:roadmap/domain/entities/timelineItem.dart';
import 'package:roadmap/domain/usecases/item_usecase.dart';
import 'package:roadmap/presentation/routes/navigation_service.dart';

class DetailViewmodel extends StateNotifier<AsyncValue<List<TimelineItem>>> {
  DetailViewmodel(this._navigationService, this._usecase)
      : super(const AsyncValue.loading());
  final NavigationService _navigationService;
  final ItemUsecase _usecase;

  void navigatePop() => _navigationService.navigatePop();
  void navigateToEdit({required Item item}) =>
      _navigationService.navigateToEdit(item);

  Future<void> retrieveTimelineItems(
    String itemId, {
    bool isRefreshing = false,
  }) async {
    if (isRefreshing) {
      state = const AsyncValue.loading();
    }
    try {
      final items = await _usecase.retrieveTimelineItems(itemId);
      if (mounted) {
        state = AsyncValue.data(items);
      }
    } on Exception {
      // NOP
    }
  }

  Future<void> addTimelineItem({
    required String itemId,
    required String title,
    required String description,
    required DateTime deadline,
    bool isCompleted = false,
  }) async {
    try {
      final timelineItem = TimelineItem(
        title: title,
        description: description,
        deadline: deadline,
        isCompleted: isCompleted,
        createdAt: DateTime.now(),
      );
      final timelineItemId =
          await _usecase.createTimelineItem(itemId, timelineItem);
      state.whenData(
        (items) => state = AsyncValue.data(
          items..add(timelineItem.copyWith(id: timelineItemId)),
        ),
      );
    } on Exception {
      // NOP
    }
  }

  Future<void> updateTimelineItem({
    required String itemId,
    required TimelineItem updatedItem,
  }) async {
    try {
      await _usecase.updateTimelineItem(itemId, updatedItem);
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

  Future<void> deleteTimelineItem({
    required String itemId,
    required String timelineItemId,
  }) async {
    try {
      await _usecase.deleteTimelineItem(itemId, timelineItemId);
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
