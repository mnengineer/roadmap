import 'package:flutter/material.dart';
import 'package:roadmap/core/constants/sizes.dart';
import 'package:roadmap/domain/entities/onboarding.dart';

class OnBoardingPageWidget extends StatelessWidget {
  const OnBoardingPageWidget({
    super.key,
    required this.model,
  });

  final OnBoarding model;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(tDefaultSpace),
      color: model.bgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image(
            image: AssetImage(model.image),
            height: size.height * 0.45,
          ),
          Column(
            children: [
              Text(
                model.title,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              Text(
                model.subTitle,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Text(
            model.counterText,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 80,
          ),
        ],
      ),
    );
  }
}
