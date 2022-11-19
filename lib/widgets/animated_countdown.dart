import 'package:flutter/material.dart';
import 'package:stream_timer/bloc/countdown_bloc.dart';
import 'package:stream_timer/primitives/time_difference.dart';
import 'package:stream_timer/primitives/time_segment.dart';
import 'package:stream_timer/widgets/time_segment.dart';

class AnimatedCountdown extends StatelessWidget {
  const AnimatedCountdown({
    Key? key,
    required CountdownBloc countdownBloc,
    required List<AnimationController> hoursControllers,
    required List<AnimationController> minutesControllers,
    required List<AnimationController> secondsControllers,
  })  : _countdownBloc = countdownBloc,
        _hoursControllers = hoursControllers,
        _minutesControllers = minutesControllers,
        _secondsControllers = secondsControllers,
        super(key: key);

  final CountdownBloc _countdownBloc;
  final List<AnimationController> _hoursControllers;
  final List<AnimationController> _minutesControllers;
  final List<AnimationController> _secondsControllers;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TimeDifference>(
      stream: _countdownBloc.stream,
      initialData: const TimeDifference(
        hours: 0,
        minutes: 0,
        seconds: 0,
      ),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Container();
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TimeSegment(
              time: snapshot.data!.hours.toString().padLeft(2, '0'),
              label: "HOURS",
              animated: true,
              leftAnimationController: _hoursControllers[0],
              rightAnimationController: _hoursControllers[1],
              segmentType: SegmentType.hours,
            ),
            TimeSegment(time: ":", label: ""),
            TimeSegment(
              time: snapshot.data!.minutes.toString().padLeft(2, '0'),
              label: "MINUTES",
              animated: true,
              leftAnimationController: _minutesControllers[0],
              rightAnimationController: _minutesControllers[1],
              segmentType: SegmentType.minutes,
            ),
            TimeSegment(time: ":", label: ""),
            TimeSegment(
              time: snapshot.data!.seconds.toString().padLeft(2, '0'),
              label: "SECONDS",
              animated: true,
              leftAnimationController: _secondsControllers[0],
              rightAnimationController: _secondsControllers[1],
              segmentType: SegmentType.seconds,
            ),
          ],
        );
      },
    );
  }
}
