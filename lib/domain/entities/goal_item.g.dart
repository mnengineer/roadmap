// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'goal_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GoalItem _$$_GoalItemFromJson(Map<String, dynamic> json) => _$_GoalItem(
      id: json['id'] as String?,
      title: json['title'] as String,
      description: json['description'] as String,
      deadline: DateTime.parse(json['deadline'] as String),
      imagePath: json['imagePath'] as String,
      isCompleted: json['isCompleted'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$_GoalItemToJson(_$_GoalItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'deadline': instance.deadline.toIso8601String(),
      'imagePath': instance.imagePath,
      'isCompleted': instance.isCompleted,
      'createdAt': instance.createdAt.toIso8601String(),
    };
