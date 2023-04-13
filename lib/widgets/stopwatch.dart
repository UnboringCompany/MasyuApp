import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StopWatchWidget extends StatefulWidget {
  const StopWatchWidget({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _StopWatchWidgetState();
}

class _StopWatchWidgetState extends State<StopWatchWidget> {
  Duration duration = const Duration();
  Timer? _timer;

  @override
  initState() {
    super.initState();
    startTimer();
  }

  void addTime() {
    const addSeconds = 1;

    if (mounted){
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
