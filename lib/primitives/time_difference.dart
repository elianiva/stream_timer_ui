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

  factory TimeDifference.from(Duration diff) {
    return TimeDifference(
      hours: diff.inHours,
      minutes: (diff.inMinutes % 60).round(),
      seconds: (diff.inSeconds % 60).round(),
    );
  }

  /// Finds the previous time value and cap it according to the [digitType]
  static int findPreviousTimeValue(int number, SegmentDigitType digitType) {
    int prevNumber = number - 1;
    return prevNumber < 0 ? findMaxSegmentNumber(digitType) : prevNumber;
  }

  /// Finds the maximum number for the given [segmentType]
  static int findMaxSegmentNumber(SegmentDigitType segmentType) {
    switch (segmentType) {
      case SegmentDigitType.minutesTens:
      case SegmentDigitType.secondsTens:
        return 5;
      case SegmentDigitType.hoursTens:
      case SegmentDigitType.hoursOnes:
      case SegmentDigitType.minutesOnes:
      case SegmentDigitType.secondsOnes:
        return 9;
      default:
        return 0;
    }
  }
}
