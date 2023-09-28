import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:roadmap/core/constants/colors.dart';
import 'package:roadmap/core/constants/image_strings.dart';
import 'package:roadmap/core/constants/text_strings.dart';
import 'package:roadmap/domain/entities/onboarding.dart';
import 'package:roadmap/presentation/widgets/on_boarding_page_widget.dart';

class OnBoardingViewModel extends StateNotifier<int> {
  OnBoardingViewModel() : super(0);
  final controller = LiquidController();

  void skip() => controller.jumpToPage(page: 2);
  void animateToNextSlide() => controller.animateToPage(page: state + 1);
  // ignore: use_setters_to_change_properties
  void onPageChangedCallback(int activePageIndex) => state = activePageIndex;

  final pages = const [
    OnBoardingPageWidget(
      model: OnBoarding(
        image: tOnBoardingImage1,
        title: tOnBoardingTitle1,
        subTitle: tOnBoardingSubTitle1,
        counterText: tOnBoardingCounter1,
        bgColor: tOnBoardingPage1Color,
      ),
    ),
    OnBoardingPageWidget(
      model: OnBoarding(
        image: tOnBoardingImage2,
        title: tOnBoardingTitle2,
        subTitle: tOnBoardingSubTitle2,
        counterText: tOnBoardingCounter2,
        bgColor: tOnBoardingPage2Color,
      ),
    ),
    OnBoardingPageWidget(
      model: OnBoarding(
        image: tOnBoardingImage3,
        title: tOnBoardingTitle3,
        subTitle: tOnBoardingSubTitle3,
        counterText: tOnBoardingCounter3,
        bgColor: tOnBoardingPage3Color,
      ),
    ),
  ];
}
