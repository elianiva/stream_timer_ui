import 'package:flutter/material.dart';
import 'package:stream_timer/bloc/countdown_bloc.dart';
import 'package:stream_timer/primitives/time_difference.dart';
import 'package:stream_timer/primitives/time_segment.dart';
import 'package:stream_timer/widgets/animated_countdown.dart';

class CountdownDisplay extends StatefulWidget {
  const CountdownDisplay({super.key, required this.end});

  final DateTime end;

  @override
  State<CountdownDisplay> createState() => _CountdownDisplayState();
}

class _CountdownDisplayState extends State<CountdownDisplay>
    with TickerProviderStateMixin {
  late final CountdownBloc _countdownBloc = CountdownBloc(end: widget.end);

  late List<AnimationController> _secondsAnimations;
  late List<AnimationController> _minutesAnimations;
  late List<AnimationController> _hoursAnimations;

  /// a list to store all animation controllers to make it easier when we want
  /// to operate on all of them
  late final List<AnimationController> _clockAnimations = [
    ..._secondsAnimations,
    ..._minutesAnimations,
    ..._hoursAnimations
  ];

  @override
  void initState() {
    super.initState();

    _secondsAnimations = [
      _buildClockAnimation(this), // tens
      _buildClockAnimation(this), // ones
    ];
    _minutesAnimations = [
      _buildClockAnimation(this), // tens
      _buildClockAnimation(this), // ones
    ];
    _hoursAnimations = [
      _buildClockAnimation(this), // tens
      _buildClockAnimation(this), // ones
    ];

    _countdownBloc.stream.listen(_animateDigits);
  }

  @override
  void dispose() {
    _countdownBloc.dispose();
    for (final controller in _clockAnimations) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 460,
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(color: Color(0xFFF9F9F9)),
            width: double.infinity,
            child: Image.asset("assets/illustrations/bike.png"),
          ),
          Positioned(
            top: 220,
            left: 16,
            child: Container(
              width: MediaQuery.of(context).size.width - 64,
              height: 210,
              decoration: const BoxDecoration(
                color: Color(0xFFFFFFFF),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x22000000),
                    blurRadius: 32,
                    blurStyle: BlurStyle.outer,
                    offset: Offset(0, 16),
                  ),
                ],
              ),
              child: Container(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Courier will arrive in",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    AnimatedCountdown(
                      countdownBloc: _countdownBloc,
                      hoursAnimation: _hoursAnimations,
                      minutesAnimation: _minutesAnimations,
                      secondsAnimation: _secondsAnimations,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  AnimationController _buildClockAnimation(TickerProvider tickerProvider) {
    return AnimationController(
      vsync: tickerProvider,
      duration: const Duration(milliseconds: 750),
    );
  }

  void _animateLeftDigit(
    int prev,
    int current,
    AnimationController controller,
  ) {
    final prevFirstDigit = (prev / 10).floor();
    final currentFirstDigit = (current / 10).floor();
    if (prevFirstDigit != currentFirstDigit) {
      controller.forward();
    }
  }

  void _animateDigits(countdown) {
    // reset all digits position
    for (final controller in _clockAnimations) {
      controller.reset();
    }

    // move the ones digit
    if (countdown.currentDiff.seconds != countdown.nextDiff.seconds) {
      _secondsAnimations[1].forward();
    }
    if (countdown.currentDiff.minutes != countdown.nextDiff.minutes) {
      _minutesAnimations[1].forward();
    }
    if (countdown.currentDiff.hours != countdown.nextDiff.hours) {
      _hoursAnimations[1].forward();
    }

    // move the 1st digit of the seconds segment
    _animateLeftDigit(
      countdown.currentDiff.seconds,
      countdown.nextDiff.seconds,
      _secondsAnimations[0],
    );

    // move the 1st digit of the minutes segment
    _animateLeftDigit(
      countdown.currentDiff.minutes,
      countdown.nextDiff.minutes,
      _minutesAnimations[0],
    );

    // move the 1st digit of the hours segment
    _animateLeftDigit(
      countdown.currentDiff.hours,
      countdown.nextDiff.hours,
      _hoursAnimations[0],
    );
  }
}
