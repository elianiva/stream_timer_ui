import 'package:flutter/material.dart';
import 'package:stream_timer/constants/colors.dart';
import 'package:stream_timer/primitives/time_difference.dart';
import 'package:stream_timer/primitives/time_segment.dart';

class AnimatedNumber extends StatelessWidget {
  const AnimatedNumber({
    super.key,
    required this.number,
    required this.animationController,
    required this.digitType,
  });

  final int number;
  final SegmentDigitType digitType;
  final AnimationController animationController;
  final int translationOffset = 100;

  final numberTextStyle = const TextStyle(
    fontSize: 82,
    height: 1,
    color: AppColors.softBlack,
    fontWeight: FontWeight.w700,
  );

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: SizedBox(
        width: 54,
        height: 80,
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedBuilder(
              animation: animationController,
              builder: (context, animatedWidget) {
                return Transform.translate(
                  offset:
                      Offset(0, animationController.value * -translationOffset),
                  child: animatedWidget,
                );
              },
              child: Text(
                number.toString(),
                style: numberTextStyle,
              ),
            ),
            AnimatedBuilder(
              animation: animationController,
              builder: (context, animatedWidget) {
                return Transform.translate(
                  offset: Offset(
                    0,
                    animationController.value * -translationOffset +
                        translationOffset,
                  ),
                  child: animatedWidget,
                );
              },
              child: Text(
                TimeDifference.findPreviousTimeValue(number, digitType)
                    .toString(),
                style: numberTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
