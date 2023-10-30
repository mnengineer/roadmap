// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'roadmap_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RoadmapItem _$$_RoadmapItemFromJson(Map<String, dynamic> json) =>
    _$_RoadmapItem(
      id: json['id'] as String?,
      title: json['title'] as String,
      description: json['description'] as String,
      deadline: DateTime.parse(json['deadline'] as String),
      isCompleted: json['isCompleted'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$_RoadmapItemToJson(_$_RoadmapItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'deadline': instance.deadline.toIso8601String(),
      'isCompleted': instance.isCompleted,
      'createdAt': instance.createdAt.toIso8601String(),
    };
