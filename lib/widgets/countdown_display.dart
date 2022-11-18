import 'package:flutter/material.dart';
import 'package:stream_timer/bloc/countdown_bloc.dart';
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

  late List<AnimationController> _secondsControllers;
  late List<AnimationController> _minutesControllers;
  late List<AnimationController> _hoursControllers;

  /// a list to store all animation controllers to make it easier when we want
  /// to operate on all of them
  late final List<AnimationController> _animationControllers = [
    ..._secondsControllers,
    ..._minutesControllers,
    ..._hoursControllers
  ];

  @override
  void initState() {
    super.initState();

    _secondsControllers = [
      _buildClockAnimation(this),
      _buildClockAnimation(this),
    ];
    _minutesControllers = [
      _buildClockAnimation(this),
      _buildClockAnimation(this),
    ];
    _hoursControllers = [
      _buildClockAnimation(this),
      _buildClockAnimation(this),
    ];

    TimeDifference prevDiff = const TimeDifference(
      hours: 0,
      minutes: 0,
      seconds: 0,
    );

    // we need this to prevent the clock animating on the first iteration
    bool hasRan = false;
    _countdownBloc.stream.listen((currentDiff) {
      if (!hasRan) {
        hasRan = true;
        // set the previous value to the first iteration value so we don't need to animate it
        // on the first run
        prevDiff = currentDiff;
        return;
      }

      // reset all digits position
      for (final controller in _animationControllers) {
        controller.reset();
      }

      // move the 2nd digit of the seconds segment whenever it changes
      if (currentDiff.seconds != prevDiff.seconds) {
        _secondsControllers[1].forward();
      }

      // animate the second digit of the minute segment whenever the seconds changes from 00 to 59
      // offset by +1 because the sliding numbers are getting a -1 offset, we need to normalise it
      if (prevDiff.seconds == 1 && currentDiff.seconds == 0) {
        _minutesControllers[1].forward();
      }

      // same rule as the minutes segment applies here
      if (prevDiff.minutes == 1 && currentDiff.minutes == 0) {
        _hoursControllers[1].forward();
      }

      // move the 1st digit of the seconds segment
      _animateLeftDigit(
        prevDiff.seconds - 1,
        currentDiff.seconds - 1,
        _secondsControllers[0],
      );

      // move the 1st digit of the minutes segment
      _animateLeftDigit(
        prevDiff.minutes - 1,
        currentDiff.minutes - 1,
        _minutesControllers[0],
      );

      // move the 1st digit of the hours segment
      _animateLeftDigit(
        prevDiff.hours - 1,
        currentDiff.hours - 1,
        _hoursControllers[0],
      );

      prevDiff = currentDiff;
    });
  }

  @override
  void dispose() {
    _countdownBloc.dispose();
    for (final controller in _animationControllers) {
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
                      hoursControllers: _hoursControllers,
                      minutesControllers: _minutesControllers,
                      secondsControllers: _secondsControllers,
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
      // prevent unnecessary animation, how does it work? I literally have no idea
      // I somehow figured it out, but I still don't know how
      if (!(prevFirstDigit == -1 && currentFirstDigit == 5)) {
        controller.forward();
      }
    }
  }
}
