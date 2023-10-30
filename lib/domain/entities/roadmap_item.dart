import 'package:freezed_annotation/freezed_annotation.dart';

part 'roadmap_item.freezed.dart';
part 'roadmap_item.g.dart';

@freezed
class RoadmapItem with _$RoadmapItem {
  factory RoadmapItem({
    String? id,
    required String title,
    required String description,
    required DateTime deadline,
    @Default(false) bool isCompleted,
    required DateTime createdAt,
  }) = _RoadmapItem;

  const RoadmapItem._();

  factory RoadmapItem.empty() => RoadmapItem(
        title: '',
        description: '',
        deadline: DateTime.now(),
        createdAt: DateTime.now(),
      );
  factory RoadmapItem.fromJson(Map<String, dynamic> json) =>
      _$RoadmapItemFromJson(json);
}
