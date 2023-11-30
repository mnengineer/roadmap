import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roadmap/domain/entities/goal_item.dart';
import 'package:roadmap/domain/usecases/goal_item_usecase.dart';
import 'package:roadmap/presentation/routes/navigation_service.dart';

class GoalViewModel extends StateNotifier<AsyncValue<List<GoalItem>>> {
  GoalViewModel(this._navigationService, this._usecase)
      : super(const AsyncValue.loading()) {
    retrieveItems();
  }

  final NavigationService _navigationService;
  final GoalItemUsecase _usecase;
  bool? _filter;

  void navigateToHome() => _navigationService.navigateToHome();
  void navigateToAdd() => _navigationService.navigateToAdd();
  void navigatePop() => _navigationService.navigatePop();
  void navigateToDetail({required GoalItem item}) =>
      _navigationService.navigateToDetail(item);
  void navigateToEdit({required GoalItem goalItem}) =>
      _navigationService.navigateToEdit(goalItem);

  void _updateSortedState(List<GoalItem> goalItems) {
    goalItems.sort((a, b) => a.deadline.compareTo(b.deadline));
    state = AsyncValue.data(goalItems);
  }

  Future<void> retrieveItems() async {
    state = const AsyncValue.loading();
    try {
      final items = await _usecase.retrieveItems();
      _updateSortedState(
        _filter == null
            ? items
            : items.where((item) => item.isCompleted == _filter).toList(),
      );
    } on Exception {
      state =
          const AsyncValue.error('Could not retrieve items.', StackTrace.empty);
    }
  }

  Future<void> addItem({
    required String title,
    required String description,
    required DateTime deadline,
    required Color backgroundColor,
    bool isCompleted = false,
  }) async {
    try {
      final item = GoalItem(
        title: title,
        description: description,
        deadline: deadline,
        backgroundColorValue: backgroundColor.value,
        isCompleted: isCompleted,
        createdAt: DateTime.now(),
      );
      final itemId = await _usecase.createItem(item);
      final addedGoalItems = List<GoalItem>.from(state.value ?? [])
        ..add(item.copyWith(id: itemId));
      _updateSortedState(addedGoalItems);
    } on Exception {
      state = const AsyncValue.error('Could not add item..', StackTrace.empty);
    }
  }

  Future<void> updateItem({required GoalItem updatedItem}) async {
    try {
      await _usecase.updateItem(updatedItem);
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

  Future<void> deleteItem({required String itemId}) async {
    try {
      await _usecase.deleteItem(itemId);
      final currentItem = List<GoalItem>.from(state.value ?? [])
        ..removeWhere((item) => item.id == itemId);
      _updateSortedState(currentItem);
    } on Exception {
      state =
          const AsyncValue.error('Could not delete item.', StackTrace.empty);
    }
  }
}
