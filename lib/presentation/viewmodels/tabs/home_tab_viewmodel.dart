import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roadmap/domain/entities/item.dart';
import 'package:roadmap/domain/usecases/item_usecase.dart';

class HomeTabViewmodel extends StateNotifier<AsyncValue<List<Item>>> {
  HomeTabViewmodel(this._usecase) : super(const AsyncValue.loading()) {
    retrieveItems();
  }
  final ItemUsecase _usecase;

  Future<void> retrieveItems({bool isRefreshing = false}) async {
    if (isRefreshing) {
      state = const AsyncValue.loading();
    }
    try {
      final items = await _usecase.retrieveItems();
      if (mounted) {
        state = AsyncValue.data(items);
      }
    } on Exception {
      // NOP
    }
  }

  Future<void> addItem({
    required String title,
    bool isCompleted = false,
  }) async {
    try {
      final item = Item(
        title: title,
        isCompleted: isCompleted,
        createdAt: DateTime.now(),
      );
      final itemId = await _usecase.createItem(item);
      state.whenData(
        (items) => state = AsyncValue.data(
          items..add(item.copyWith(id: itemId)),
        ),
      );
    } on Exception {
      // NOP
    }
  }

  Future<void> updateItem({required Item updatedItem}) async {
    try {
      await _usecase.updateItem(updatedItem);
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

  Future<void> deleteItem({required String itemId}) async {
    try {
      await _usecase.deleteItem(itemId);
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
