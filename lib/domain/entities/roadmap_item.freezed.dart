// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'roadmap_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RoadmapItem _$RoadmapItemFromJson(Map<String, dynamic> json) {
  return _RoadmapItem.fromJson(json);
}

/// @nodoc
mixin _$RoadmapItem {
  String? get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  DateTime get deadline => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RoadmapItemCopyWith<RoadmapItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoadmapItemCopyWith<$Res> {
  factory $RoadmapItemCopyWith(
          RoadmapItem value, $Res Function(RoadmapItem) then) =
      _$RoadmapItemCopyWithImpl<$Res, RoadmapItem>;
  @useResult
  $Res call(
      {String? id,
      String title,
      String description,
      DateTime deadline,
      bool isCompleted,
      DateTime createdAt});
}

/// @nodoc
class _$RoadmapItemCopyWithImpl<$Res, $Val extends RoadmapItem>
    implements $RoadmapItemCopyWith<$Res> {
  _$RoadmapItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? description = null,
    Object? deadline = null,
    Object? isCompleted = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      deadline: null == deadline
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RoadmapItemCopyWith<$Res>
    implements $RoadmapItemCopyWith<$Res> {
  factory _$$_RoadmapItemCopyWith(
          _$_RoadmapItem value, $Res Function(_$_RoadmapItem) then) =
      __$$_RoadmapItemCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String title,
      String description,
      DateTime deadline,
      bool isCompleted,
      DateTime createdAt});
}

/// @nodoc
class __$$_RoadmapItemCopyWithImpl<$Res>
    extends _$RoadmapItemCopyWithImpl<$Res, _$_RoadmapItem>
    implements _$$_RoadmapItemCopyWith<$Res> {
  __$$_RoadmapItemCopyWithImpl(
      _$_RoadmapItem _value, $Res Function(_$_RoadmapItem) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? description = null,
    Object? deadline = null,
    Object? isCompleted = null,
    Object? createdAt = null,
  }) {
    return _then(_$_RoadmapItem(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      deadline: null == deadline
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RoadmapItem extends _RoadmapItem {
  _$_RoadmapItem(
      {this.id,
      required this.title,
      required this.description,
      required this.deadline,
      this.isCompleted = false,
      required this.createdAt})
      : super._();

  factory _$_RoadmapItem.fromJson(Map<String, dynamic> json) =>
      _$$_RoadmapItemFromJson(json);

  @override
  final String? id;
  @override
  final String title;
  @override
  final String description;
  @override
  final DateTime deadline;
  @override
  @JsonKey()
  final bool isCompleted;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'RoadmapItem(id: $id, title: $title, description: $description, deadline: $deadline, isCompleted: $isCompleted, createdAt: $createdAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RoadmapItem &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.deadline, deadline) ||
                other.deadline == deadline) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, title, description, deadline, isCompleted, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RoadmapItemCopyWith<_$_RoadmapItem> get copyWith =>
      __$$_RoadmapItemCopyWithImpl<_$_RoadmapItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RoadmapItemToJson(
      this,
    );
  }
}

abstract class _RoadmapItem extends RoadmapItem {
  factory _RoadmapItem(
      {final String? id,
      required final String title,
      required final String description,
      required final DateTime deadline,
      final bool isCompleted,
      required final DateTime createdAt}) = _$_RoadmapItem;
  _RoadmapItem._() : super._();

  factory _RoadmapItem.fromJson(Map<String, dynamic> json) =
      _$_RoadmapItem.fromJson;

  @override
  String? get id;
  @override
  String get title;
  @override
  String get description;
  @override
  DateTime get deadline;
  @override
  bool get isCompleted;
  @override
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$_RoadmapItemCopyWith<_$_RoadmapItem> get copyWith =>
      throw _privateConstructorUsedError;
}
