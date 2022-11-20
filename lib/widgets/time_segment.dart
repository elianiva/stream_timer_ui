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
      this.leftAnimation,
      this.rightAnimation,
      this.segmentType = SegmentType.unknown}) {
    if (animated) {
      assert(time.length == 2);
      assert(leftAnimation != null);
      assert(rightAnimation != null);
    }
  }

  final String time;
  final String label;
  final bool animated;
  final SegmentType segmentType;
  AnimationController? leftAnimation;
  AnimationController? rightAnimation;

  @override
  State<TimeSegment> createState() => _TimeSegmentState();
}

class _TimeSegmentState extends State<TimeSegment> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.animated && widget.rightAnimation != null
            ? Row(
                children: [
                  AnimatedNumber(
                    number: int.tryParse(widget.time[0])!,
                    animationController: widget.leftAnimation!,
                    digitType: _segmentToDigitType(widget.segmentType, "left"),
                  ),
                  AnimatedNumber(
                    number: int.tryParse(widget.time[1])!,
                    animationController: widget.rightAnimation!,
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
            ? SegmentDigitType.hoursTens
            : SegmentDigitType.hoursOnes;
      case SegmentType.minutes:
        return isLeft
            ? SegmentDigitType.minutesTens
            : SegmentDigitType.minutesOnes;
      case SegmentType.seconds:
        return isLeft
            ? SegmentDigitType.secondsTens
            : SegmentDigitType.secondsOnes;
      default:
        return SegmentDigitType.unknown;
    }
  }
}
