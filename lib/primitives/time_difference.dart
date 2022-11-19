import 'package:stream_timer/primitives/time_segment.dart';

class TimeDifference {
  const TimeDifference({
    required this.hours,
    required this.minutes,
    required this.seconds,
  });

  final int hours;
  final int minutes;
  final int seconds;

  bool get isEmpty => hours <= 0 && minutes <= 0 && seconds <= 0;

  /// Finds the previous time value and cap it according to the [digitType]
  static int findPreviousTimeValue(int number, SegmentDigitType digitType) {
    int prevNumber = number - 1;
    return prevNumber < 0 ? findMaxSegmentNumber(digitType) : prevNumber;
  }

  static int findMaxSegmentNumber(SegmentDigitType segmentType) {
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
