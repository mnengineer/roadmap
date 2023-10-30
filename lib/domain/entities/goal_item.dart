import 'package:freezed_annotation/freezed_annotation.dart';

part 'goal_item.freezed.dart';
part 'goal_item.g.dart';

@freezed
class GoalItem with _$GoalItem {
  factory GoalItem({
    String? id,
    required String title,
    required String description,
    required DateTime deadline,
    required String imagePath,
    @Default(false) bool isCompleted,
    required DateTime createdAt,
  }) = _GoalItem;

  const GoalItem._();

  factory GoalItem.empty() => GoalItem(
        title: '',
        description: '',
        deadline: DateTime.now(),
        imagePath: '',
        createdAt: DateTime.now(),
      );
  factory GoalItem.fromJson(Map<String, dynamic> json) =>
      _$GoalItemFromJson(json);
}
