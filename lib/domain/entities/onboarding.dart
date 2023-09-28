import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding.freezed.dart';

@freezed
class OnBoarding with _$OnBoarding {
  const factory OnBoarding({
    required String image,
    required String title,
    required String subTitle,
    required String counterText,
    required Color bgColor,
  }) = _OnBoarding;
}
