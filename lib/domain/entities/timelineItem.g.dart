// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timelineItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TimelineItem _$$_TimelineItemFromJson(Map<String, dynamic> json) =>
    _$_TimelineItem(
      id: json['id'] as String?,
      title: json['title'] as String,
      description: json['description'] as String,
      deadline: DateTime.parse(json['deadline'] as String),
      isCompleted: json['isCompleted'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$_TimelineItemToJson(_$_TimelineItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'deadline': instance.deadline.toIso8601String(),
      'isCompleted': instance.isCompleted,
      'createdAt': instance.createdAt.toIso8601String(),
    };
