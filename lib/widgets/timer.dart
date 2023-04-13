import 'dart:async';

import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../objects/partie.dart';

class TimerWatch extends StatefulWidget {
  const TimerWatch({super.key, required this.time, required this.partie});

  final int time;
  final int nbPoints = 0;
  final Partie partie;

  void stopTimer() {
    _TimerWatchState(nbPoints: nbPoints, partie: partie, time : time).timer?.cancel();
  }

  @override
  State<StatefulWidget> createState() =>
      _TimerWatchState(time: time, nbPoints: nbPoints, partie: partie);
}

class _TimerWatchState extends State<TimerWatch> {
  _TimerWatchState(
      {required this.time, required this.nbPoints, required this.partie});
  final int time;
  final int nbPoints;
  final Partie partie;

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

  void loseTimerPopup(BuildContext context, int nbPoints) {
    nbPoints = -nbPoints;
    String points = nbPoints.toString();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('timer_defeat_title'.tr,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white)),
          backgroundColor: Colors.transparent,
          content: Text('timer_defeat_content'.trParams({'points': points}),
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white)),
          actions: <Widget>[
            Container(
                alignment: Alignment.bottomCenter,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0x7F373855),
                ),
                child: IconButton(
                  icon: const Icon(BootstrapIcons.x),
                  color: Colors.red,
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/');
                  },
                )),
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
        partie.player.score += -15;
        partie.player.partiePerdu += 1;
        partie.updateJoueur();
        loseTimerPopup(context, -15);
      } else {
        duration = Duration(seconds: seconds);
      }
    });
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  void stopTimer() {
    timer?.cancel();
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
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
