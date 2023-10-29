import 'package:freezed_annotation/freezed_annotation.dart';

part 'timelineItem.freezed.dart';
part 'timelineItem.g.dart';

@freezed
class TimelineItem with _$TimelineItem {
  factory TimelineItem({
    String? id,
    required String title,
    required String description,
    required DateTime deadline,
    @Default(false) bool isCompleted,
    required DateTime createdAt,
  }) = _TimelineItem;

  const TimelineItem._();

  factory TimelineItem.empty() => TimelineItem(
        title: '',
        description: '',
        deadline: DateTime.now(),
        createdAt: DateTime.now(),
      );
  factory TimelineItem.fromJson(Map<String, dynamic> json) =>
      _$TimelineItemFromJson(json);
}
