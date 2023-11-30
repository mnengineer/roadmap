import 'package:flutter/material.dart';
import 'package:roadmap/core/constants/colors.dart';

class ClickableRichTextWidget extends StatelessWidget {
  const ClickableRichTextWidget({
    required this.text1,
    required this.text2,
    required this.onPressed,
    super.key,
  });

  final String text1;
  final String text2;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '$text1 ',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: tDarkColor),
              ),
              TextSpan(
                text: text2,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .apply(color: tFacebookBgColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
