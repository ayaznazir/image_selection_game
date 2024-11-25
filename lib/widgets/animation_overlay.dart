import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../constants/animation_constants.dart';
import '../constants/app_constants.dart';
import '../constants/color_constants.dart';
import '../constants/string_constants.dart';

class AnimationOverlay extends StatelessWidget {
  final bool showSuccess;
  final bool showFailure;

  const AnimationOverlay({
    super.key,
    required this.showSuccess,
    required this.showFailure,
  });

  @override
  Widget build(BuildContext context) {
    if (!showSuccess && !showFailure) return SizedBox.shrink();

    return Container(
      color: ColorConstants.overlayDark.withOpacity(
        ColorConstants.overlayOpacity,
      ),
      child: Center(
        child: SizedBox(
          width: AnimationConstants.size,
          height: AnimationConstants.size,
          child: Lottie.asset(
            showSuccess
                ? AnimationConstants.success
                : AnimationConstants.failure,
            repeat: false,
            animate: true,
            errorBuilder: (context, error, stackTrace) {
              return const Center(
                child: Text(
                  StringConstants.errorLoadingAnimation,
                  style: TextStyle(color: ColorConstants.background),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
