import 'package:flutter/material.dart';
import 'package:stream_timer/constants/colors.dart';
import 'package:stream_timer/widgets/time_segment.dart';

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
                style: const TextStyle(
                  fontSize: 82,
                  height: 1,
                  color: AppColors.softBlack,
                  fontWeight: FontWeight.w700,
                ),
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
                _findPreviousNumber(number, digitType).toString(),
                style: const TextStyle(
                  fontSize: 88,
                  height: 1,
                  color: AppColors.softBlack,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Finds the previous number and cap it according to the [digitType]
  int _findPreviousNumber(int number, SegmentDigitType type) {
    int prevNumber = number - 1;
    return prevNumber < 0 ? _findMaxSegmentNumber(type) : prevNumber;
  }

  int _findMaxSegmentNumber(SegmentDigitType segmentType) {
    switch (segmentType) {
      case SegmentDigitType.hoursLeft:
        return 1;
      case SegmentDigitType.minutesLeft:
      case SegmentDigitType.secondsLeft:
        return 5;
      case SegmentDigitType.hoursRight:
      case SegmentDigitType.minutesRight:
      case SegmentDigitType.secondsRight:
        return 9;
      default:
        return 0;
    }
  }
}
