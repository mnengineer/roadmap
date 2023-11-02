import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roadmap/domain/entities/goal_item.dart';
import 'package:roadmap/domain/usecases/goal_item_usecase.dart';
import 'package:roadmap/presentation/routes/navigation_service.dart';

class HomeTabViewModel extends StateNotifier<AsyncValue<List<GoalItem>>> {
  HomeTabViewModel(this._navigationService, this._usecase)
      : super(const AsyncValue.loading()) {
    retrieveItems();
  }

  final NavigationService _navigationService;
  final GoalItemUsecase _usecase;
  bool? _filter;

  void navigateToAdd() => _navigationService.navigateToAdd();
  void navigatePop() => _navigationService.navigatePop();
  void navigateToDetail({required GoalItem item}) =>
      _navigationService.navigateToDetail(item);
  void navigateToEdit({required GoalItem item}) =>
      _navigationService.navigateToEdit(item);

  void filterItems({bool? isCompleted}) {
    _filter = isCompleted;
    retrieveItems();
  }

  Future<void> retrieveItems({bool isRefreshing = false}) async {
    if (isRefreshing) {
      state = const AsyncValue.loading();
    }
    try {
      final items = await _usecase.retrieveItems();
      state = AsyncValue.data(
        _filter == null
            ? items
            : items.where((item) => item.isCompleted == _filter).toList(),
      );
    } on Exception catch (e) {
      state = AsyncValue.error(e, StackTrace.empty);
    }
  }

  Future<void> addItem({
    required String title,
    required String description,
    required DateTime deadline,
    required String imagePath,
    bool isCompleted = false,
  }) async {
    try {
      final item = GoalItem(
        title: title,
        description: description,
        deadline: deadline,
        imagePath: imagePath,
        isCompleted: isCompleted,
        createdAt: DateTime.now(),
      );
      final itemId = await _usecase.createItem(item);
      state.maybeWhen(
        data: (items) {
          state = AsyncValue.data(items..add(item.copyWith(id: itemId)));
        },
        orElse: () {},
      );
    } on Exception catch (e) {
      state = AsyncValue.error(e, StackTrace.empty);
    }
  }

  Future<void> updateItem({required GoalItem updatedItem}) async {
    try {
      await _usecase.updateItem(updatedItem);
      state.maybeWhen(
        data: (items) {
          state = AsyncValue.data(
            [
              for (final item in items)
                if (item.id == updatedItem.id) updatedItem else item,
            ],
          );
        },
        orElse: () {},
      );
    } on Exception catch (e) {
      state = AsyncValue.error(e, StackTrace.empty);
    }
  }

  Future<void> deleteItem({required String itemId}) async {
    try {
      await _usecase.deleteItem(itemId);
      state.maybeWhen(
        data: (items) {
          state = AsyncValue.data(
            items..removeWhere((item) => item.id == itemId),
          );
        },
        orElse: () {},
      );
    } on Exception catch (e) {
      state = AsyncValue.error(e, StackTrace.empty);
    }
  }
}
