// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'goal_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GoalItem _$GoalItemFromJson(Map<String, dynamic> json) {
  return _GoalItem.fromJson(json);
}

/// @nodoc
mixin _$GoalItem {
  String? get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  DateTime get deadline => throw _privateConstructorUsedError;
  int get backgroundColorValue => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GoalItemCopyWith<GoalItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GoalItemCopyWith<$Res> {
  factory $GoalItemCopyWith(GoalItem value, $Res Function(GoalItem) then) =
      _$GoalItemCopyWithImpl<$Res, GoalItem>;
  @useResult
  $Res call(
      {String? id,
      String title,
      String description,
      DateTime deadline,
      int backgroundColorValue,
      bool isCompleted,
      DateTime createdAt});
}

/// @nodoc
class _$GoalItemCopyWithImpl<$Res, $Val extends GoalItem>
    implements $GoalItemCopyWith<$Res> {
  _$GoalItemCopyWithImpl(this._value, this._then);

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
    Object? backgroundColorValue = null,
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
      backgroundColorValue: null == backgroundColorValue
          ? _value.backgroundColorValue
          : backgroundColorValue // ignore: cast_nullable_to_non_nullable
              as int,
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
abstract class _$$_GoalItemCopyWith<$Res> implements $GoalItemCopyWith<$Res> {
  factory _$$_GoalItemCopyWith(
          _$_GoalItem value, $Res Function(_$_GoalItem) then) =
      __$$_GoalItemCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String title,
      String description,
      DateTime deadline,
      int backgroundColorValue,
      bool isCompleted,
      DateTime createdAt});
}

/// @nodoc
class __$$_GoalItemCopyWithImpl<$Res>
    extends _$GoalItemCopyWithImpl<$Res, _$_GoalItem>
    implements _$$_GoalItemCopyWith<$Res> {
  __$$_GoalItemCopyWithImpl(
      _$_GoalItem _value, $Res Function(_$_GoalItem) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? description = null,
    Object? deadline = null,
    Object? backgroundColorValue = null,
    Object? isCompleted = null,
    Object? createdAt = null,
  }) {
    return _then(_$_GoalItem(
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
      backgroundColorValue: null == backgroundColorValue
          ? _value.backgroundColorValue
          : backgroundColorValue // ignore: cast_nullable_to_non_nullable
              as int,
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
class _$_GoalItem extends _GoalItem {
  _$_GoalItem(
      {this.id,
      required this.title,
      required this.description,
      required this.deadline,
      required this.backgroundColorValue,
      this.isCompleted = false,
      required this.createdAt})
      : super._();

  factory _$_GoalItem.fromJson(Map<String, dynamic> json) =>
      _$$_GoalItemFromJson(json);

  @override
  final String? id;
  @override
  final String title;
  @override
  final String description;
  @override
  final DateTime deadline;
  @override
  final int backgroundColorValue;
  @override
  @JsonKey()
  final bool isCompleted;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'GoalItem(id: $id, title: $title, description: $description, deadline: $deadline, backgroundColorValue: $backgroundColorValue, isCompleted: $isCompleted, createdAt: $createdAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GoalItem &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.deadline, deadline) ||
                other.deadline == deadline) &&
            (identical(other.backgroundColorValue, backgroundColorValue) ||
                other.backgroundColorValue == backgroundColorValue) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, description, deadline,
      backgroundColorValue, isCompleted, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GoalItemCopyWith<_$_GoalItem> get copyWith =>
      __$$_GoalItemCopyWithImpl<_$_GoalItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GoalItemToJson(
      this,
    );
  }
}

abstract class _GoalItem extends GoalItem {
  factory _GoalItem(
      {final String? id,
      required final String title,
      required final String description,
      required final DateTime deadline,
      required final int backgroundColorValue,
      final bool isCompleted,
      required final DateTime createdAt}) = _$_GoalItem;
  _GoalItem._() : super._();

  factory _GoalItem.fromJson(Map<String, dynamic> json) = _$_GoalItem.fromJson;

  @override
  String? get id;
  @override
  String get title;
  @override
  String get description;
  @override
  DateTime get deadline;
  @override
  int get backgroundColorValue;
  @override
  bool get isCompleted;
  @override
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$_GoalItemCopyWith<_$_GoalItem> get copyWith =>
      throw _privateConstructorUsedError;
}
