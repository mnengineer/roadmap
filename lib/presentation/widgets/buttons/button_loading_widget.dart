import 'package:flutter/material.dart';
import 'package:roadmap/core/constants/colors.dart';

class ButtonLoadingWidget extends StatelessWidget {
  const ButtonLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(color: tWhiteColor),
        ),
        SizedBox(width: 10),
        Text('Loading...'),
      ],
    );
  }
}
