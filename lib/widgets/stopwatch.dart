import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StopWatchWidget extends StatefulWidget {
  const StopWatchWidget({super.key, required this.time});

  final int time;

  @override
  State<StatefulWidget> createState() => _StopWatchWidgetState(time: time);
}

class _StopWatchWidgetState extends State<StopWatchWidget> {
  _StopWatchWidgetState({required this.time});
  Duration duration = const Duration();
  final int time;
  Timer? _timer;

  @override
  initState() {
    super.initState();
    duration = Duration(seconds: time);
    startTimer();
  }

  void addTime() {
    const addSeconds = 1;

    if (mounted) {
      setState(() {
        final seconds = duration.inSeconds + addSeconds;

        duration = Duration(seconds: seconds);
      });
    }
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
  }

  @override
  Widget build(BuildContext context) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    // debugPrint("Duration : $duration");

    return (Text('$minutes:$seconds',
        style: const TextStyle(color: Colors.white, fontSize: 30),
        textAlign: TextAlign.center));
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
