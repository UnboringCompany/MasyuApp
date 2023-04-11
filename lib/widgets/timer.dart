import 'dart:async';

import 'package:flutter/material.dart';

class TimerWatch extends StatefulWidget {
  const TimerWatch({super.key, required this.time});

  final int time;

  @override
  State<StatefulWidget> createState() => _TimerWatchState(time: time);
}

class _TimerWatchState extends State<TimerWatch> {
  _TimerWatchState({required this.time});
  final int time;

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
        afficherPopup(
            context, "Défaite", "Temps de résolution dépassé dommage");
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
