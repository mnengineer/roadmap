// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$OnBoarding {
  String get image => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get subTitle => throw _privateConstructorUsedError;
  String get counterText => throw _privateConstructorUsedError;
  Color get bgColor => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $OnBoardingCopyWith<OnBoarding> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnBoardingCopyWith<$Res> {
  factory $OnBoardingCopyWith(
          OnBoarding value, $Res Function(OnBoarding) then) =
      _$OnBoardingCopyWithImpl<$Res, OnBoarding>;
  @useResult
  $Res call(
      {String image,
      String title,
      String subTitle,
      String counterText,
      Color bgColor});
}

/// @nodoc
class _$OnBoardingCopyWithImpl<$Res, $Val extends OnBoarding>
    implements $OnBoardingCopyWith<$Res> {
  _$OnBoardingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? image = null,
    Object? title = null,
    Object? subTitle = null,
    Object? counterText = null,
    Object? bgColor = null,
  }) {
    return _then(_value.copyWith(
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subTitle: null == subTitle
          ? _value.subTitle
          : subTitle // ignore: cast_nullable_to_non_nullable
              as String,
      counterText: null == counterText
          ? _value.counterText
          : counterText // ignore: cast_nullable_to_non_nullable
              as String,
      bgColor: null == bgColor
          ? _value.bgColor
          : bgColor // ignore: cast_nullable_to_non_nullable
              as Color,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_OnBoardingCopyWith<$Res>
    implements $OnBoardingCopyWith<$Res> {
  factory _$$_OnBoardingCopyWith(
          _$_OnBoarding value, $Res Function(_$_OnBoarding) then) =
      __$$_OnBoardingCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String image,
      String title,
      String subTitle,
      String counterText,
      Color bgColor});
}

/// @nodoc
class __$$_OnBoardingCopyWithImpl<$Res>
    extends _$OnBoardingCopyWithImpl<$Res, _$_OnBoarding>
    implements _$$_OnBoardingCopyWith<$Res> {
  __$$_OnBoardingCopyWithImpl(
      _$_OnBoarding _value, $Res Function(_$_OnBoarding) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? image = null,
    Object? title = null,
    Object? subTitle = null,
    Object? counterText = null,
    Object? bgColor = null,
  }) {
    return _then(_$_OnBoarding(
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subTitle: null == subTitle
          ? _value.subTitle
          : subTitle // ignore: cast_nullable_to_non_nullable
              as String,
      counterText: null == counterText
          ? _value.counterText
          : counterText // ignore: cast_nullable_to_non_nullable
              as String,
      bgColor: null == bgColor
          ? _value.bgColor
          : bgColor // ignore: cast_nullable_to_non_nullable
              as Color,
    ));
  }
}

/// @nodoc

class _$_OnBoarding implements _OnBoarding {
  const _$_OnBoarding(
      {required this.image,
      required this.title,
      required this.subTitle,
      required this.counterText,
      required this.bgColor});

  @override
  final String image;
  @override
  final String title;
  @override
  final String subTitle;
  @override
  final String counterText;
  @override
  final Color bgColor;

  @override
  String toString() {
    return 'OnBoarding(image: $image, title: $title, subTitle: $subTitle, counterText: $counterText, bgColor: $bgColor)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OnBoarding &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subTitle, subTitle) ||
                other.subTitle == subTitle) &&
            (identical(other.counterText, counterText) ||
                other.counterText == counterText) &&
            (identical(other.bgColor, bgColor) || other.bgColor == bgColor));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, image, title, subTitle, counterText, bgColor);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OnBoardingCopyWith<_$_OnBoarding> get copyWith =>
      __$$_OnBoardingCopyWithImpl<_$_OnBoarding>(this, _$identity);
}

abstract class _OnBoarding implements OnBoarding {
  const factory _OnBoarding(
      {required final String image,
      required final String title,
      required final String subTitle,
      required final String counterText,
      required final Color bgColor}) = _$_OnBoarding;

  @override
  String get image;
  @override
  String get title;
  @override
  String get subTitle;
  @override
  String get counterText;
  @override
  Color get bgColor;
  @override
  @JsonKey(ignore: true)
  _$$_OnBoardingCopyWith<_$_OnBoarding> get copyWith =>
      throw _privateConstructorUsedError;
}
