import 'dart:async';

import 'package:stream_timer/primitives/time_difference.dart';

/// Used to store the current and next diff used to schedule the ticking animation
class Countdown {
  const Countdown({required this.currentDiff, required this.nextDiff});
  final TimeDifference currentDiff;
  final TimeDifference nextDiff;
}

class CountdownBloc {
  CountdownBloc({required this.end}) {
    _diff = _calculateDiff(end);
    _streamController.add(_diff);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _diff = _calculateDiff(end);
      _streamController.add(_diff);
      if (_diff.currentDiff.isEmpty || _diff.nextDiff.isEmpty) {
        timer.cancel();
      }
    });
  }

  final DateTime end;

  Timer? _timer;
  Countdown _diff = const Countdown(
    currentDiff: TimeDifference(hours: 0, minutes: 0, seconds: 0),
    nextDiff: TimeDifference(hours: 0, minutes: 0, seconds: 0),
  );
  final _streamController = StreamController<Countdown>.broadcast();

  Stream<Countdown> get stream => _streamController.stream;

  Countdown _calculateDiff(DateTime end) {
    final now = DateTime.now();
    final current = end.difference(now);
    final next = end.subtract(const Duration(seconds: 1)).difference(now);
    final currentDiff = TimeDifference.from(current);
    final nextDiff = TimeDifference.from(next);
    return Countdown(currentDiff: currentDiff, nextDiff: nextDiff);
  }

  void dispose() {
    _timer?.cancel();
    _streamController.close();
  }
}
