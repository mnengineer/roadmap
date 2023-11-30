import 'package:flutter/material.dart';
import 'package:roadmap/core/constants/colors.dart';

class FormHeaderWidget extends StatelessWidget {
  const FormHeaderWidget({
    super.key,
    this.imageColor,
    this.heightBetween,
    required this.image,
    required this.title,
    required this.subTitle,
    this.imageHeight = 0.15,
    this.textAlign,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  final Color? imageColor;
  final double imageHeight;
  final double? heightBetween;
  final String image;
  final String title;
  final String subTitle;
  final CrossAxisAlignment crossAxisAlignment;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Image(
          image: AssetImage(image),
          color: imageColor,
          height: size.height * imageHeight,
        ),
        SizedBox(height: heightBetween),
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .displayLarge
              ?.copyWith(color: tDarkColor),
        ),
        Text(
          subTitle,
          textAlign: textAlign,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: tDarkColor),
        ),
      ],
    );
  }
}
