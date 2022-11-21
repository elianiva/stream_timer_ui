import 'package:flutter/material.dart';
import 'package:stream_timer/bloc/countdown_bloc.dart';
import 'package:stream_timer/primitives/time_difference.dart';
import 'package:stream_timer/primitives/time_segment.dart';
import 'package:stream_timer/widgets/time_segment.dart';

class AnimatedCountdown extends StatelessWidget {
  const AnimatedCountdown({
    Key? key,
    required this.countdownBloc,
    required this.hoursAnimation,
    required this.minutesAnimation,
    required this.secondsAnimation,
  }) : super(key: key);

  final CountdownBloc countdownBloc;
  final List<AnimationController> hoursAnimation;
  final List<AnimationController> minutesAnimation;
  final List<AnimationController> secondsAnimation;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Countdown>(
      stream: countdownBloc.stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Container();
        final currentDiff = snapshot.data!.currentDiff;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TimeSegment(
              time: currentDiff.hours.toString().padLeft(2, '0'),
              label: "HOURS",
              animated: true,
              leftAnimation: hoursAnimation[0],
              rightAnimation: hoursAnimation[1],
              segmentType: SegmentType.hours,
            ),
            TimeSegment(time: ":", label: ""),
            TimeSegment(
              time: currentDiff.minutes.toString().padLeft(2, '0'),
              label: "MINUTES",
              animated: true,
              leftAnimation: minutesAnimation[0],
              rightAnimation: minutesAnimation[1],
              segmentType: SegmentType.minutes,
            ),
            TimeSegment(time: ":", label: ""),
            TimeSegment(
              time: currentDiff.seconds.toString().padLeft(2, '0'),
              label: "SECONDS",
              animated: true,
              leftAnimation: secondsAnimation[0],
              rightAnimation: secondsAnimation[1],
              segmentType: SegmentType.seconds,
            ),
          ],
        );
      },
    );
  }
}
