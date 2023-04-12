import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimerWatch extends StatefulWidget {
  const TimerWatch({super.key, required this.time, required this.point});

  final int time;
  final int point;

  @override
  State<StatefulWidget> createState() =>
      _TimerWatchState(time: time, point: point);
}

class _TimerWatchState extends State<TimerWatch> {
  _TimerWatchState({required this.time, required this.point});
  final int time;
  final int point;

  Duration duration = const Duration();
  Timer? timer;
  bool popup = false;

  void afficherPopup(BuildContext context, String titre, String contenu) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(titre, textAlign: TextAlign.center),
          content: Text(contenu, textAlign: TextAlign.center),
          actions: <Widget>[
            TextButton(
              child: Text('Fermer'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  initState() {
    super.initState();
    duration = Duration(seconds: time);
    startTimer();
  }

  void addTime() {
    const addSeconds = 1;

    setState(() {
      final seconds = duration.inSeconds - addSeconds;
      if (seconds < 0) {
        timer?.cancel();
      } else if (seconds == 0 && !popup) {
        popup = true;
        afficherPopup(context, "timer_defeat_title".tr,
            "timer_defeat_content".trParams({"points": point.toString()}));
      } else {
        duration = Duration(seconds: seconds);
      }
    });
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  @override
  Widget build(BuildContext context) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return (Text('$minutes:$seconds',
        style: const TextStyle(color: Colors.white, fontSize: 30),
        textAlign: TextAlign.center));
  }
}
