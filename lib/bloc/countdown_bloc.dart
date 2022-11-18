import 'dart:async';

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
}

class CountdownBloc {
  CountdownBloc({required this.end}) {
    _diff = _calculateDiff(end);
    _streamController.add(_diff);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _diff = _calculateDiff(end);
      _streamController.add(_diff);
      if (_diff.isEmpty) timer.cancel();
    });
  }

  final DateTime end;

  Timer? _timer;
  TimeDifference _diff = const TimeDifference(hours: 0, minutes: 0, seconds: 0);
  final _streamController = StreamController<TimeDifference>.broadcast();

  Stream<TimeDifference> get stream => _streamController.stream;

  TimeDifference _calculateDiff(DateTime end) {
    final timeDiff = end.difference(DateTime.now());
    return TimeDifference(
      hours: timeDiff.inHours,
      minutes: (timeDiff.inMinutes % 60).floor(),
      seconds: (timeDiff.inSeconds % 60).floor(),
    );
  }

  void dispose() {
    _timer?.cancel();
    _streamController.close();
  }
}
