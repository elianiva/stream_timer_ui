import 'package:flutter/material.dart';
import 'package:stream_timer/constants/colors.dart';
import 'package:stream_timer/primitives/time_segment.dart';
import 'package:stream_timer/widgets/animated_number.dart';

class TimeSegment extends StatefulWidget {
  TimeSegment(
      {super.key,
      required this.time,
      required this.label,
      this.animated = false,
      this.leftAnimationController,
      this.rightAnimationController,
      this.segmentType = SegmentType.unknown}) {
    if (animated) {
      assert(time.length == 2);
      assert(leftAnimationController != null);
      assert(rightAnimationController != null);
    }
  }

  final String time;
  final String label;
  final bool animated;
  final SegmentType segmentType;
  AnimationController? leftAnimationController;
  AnimationController? rightAnimationController;

  @override
  State<TimeSegment> createState() => _TimeSegmentState();
}

class _TimeSegmentState extends State<TimeSegment> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.animated && widget.rightAnimationController != null
            ? Row(
                children: [
                  AnimatedNumber(
                    number: int.tryParse(widget.time[0])!,
                    animationController: widget.leftAnimationController!,
                    digitType: _segmentToDigitType(widget.segmentType, "left"),
                  ),
                  AnimatedNumber(
                    number: int.tryParse(widget.time[1])!,
                    animationController: widget.rightAnimationController!,
                    digitType: _segmentToDigitType(widget.segmentType, "right"),
                  ),
                ],
              )
            : Text(
                widget.time,
                style: const TextStyle(
                  fontSize: 88,
                  height: 1,
                  color: AppColors.softBlack,
                  fontWeight: FontWeight.w700,
                ),
              ),
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w300,
            color: AppColors.grey,
          ),
        )
      ],
    );
  }

  SegmentDigitType _segmentToDigitType(
    SegmentType segmentType,
    String position,
  ) {
    if (position != "left" && position != "right") {
      throw ArgumentError("Invalid position");
    }

    final isLeft = position == "left";
    switch (segmentType) {
      case SegmentType.hours:
        return isLeft
            ? SegmentDigitType.hoursLeft
            : SegmentDigitType.hoursRight;
      case SegmentType.minutes:
        return isLeft
            ? SegmentDigitType.minutesLeft
            : SegmentDigitType.minutesRight;
      case SegmentType.seconds:
        return isLeft
            ? SegmentDigitType.secondsLeft
            : SegmentDigitType.secondsRight;
      default:
        return SegmentDigitType.unknown;
    }
  }
}
