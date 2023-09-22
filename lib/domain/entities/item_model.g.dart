// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Item _$$_ItemFromJson(Map<String, dynamic> json) => _$_Item(
      id: json['id'] as String?,
      title: json['title'] as String,
      isCompleted: json['isCompleted'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$_ItemToJson(_$_Item instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'isCompleted': instance.isCompleted,
      'createdAt': instance.createdAt.toIso8601String(),
    };
