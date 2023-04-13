import 'dart:io';

import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:masyu_app/objects/grille.dart';
import 'package:get/get.dart';
import 'package:masyu_app/widgets/core.dart';
import 'package:masyu_app/widgets/grille.dart';
import 'package:masyu_app/widgets/stopwatch.dart';
import 'package:masyu_app/widgets/timer.dart';

import 'main.dart';
import 'objects/partie.dart';

class GameAgainstClockPage extends StatefulWidget {
  const GameAgainstClockPage({super.key});

  @override
  State<StatefulWidget> createState() => _GameAgainstClockPageState();
}

class _GameAgainstClockPageState extends State<GameAgainstClockPage> {
  void seeHomePage() {
    Navigator.pushReplacement<void, void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => const MenuPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int _gridSize;
    Partie partie;
    

    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final type = args[
        'type']; //new si nouvelle partie, fromSave si partie chargée depuis une sauvegarde
    final size = args['size'];

    if (size == "10x10") {
      _gridSize = 10;
    } else if (size == "8x8") {
      _gridSize = 8;
    } else {
      _gridSize = 6;
    }

    if (type == 'new') {
      partie = Partie(
          _gridSize); //TODO : quand on ajoutera le joueur au constructeur, faudra le faire ici aussi
    } else {
      partie = args['partie'];
    }

    final TimerWatch timer = TimerWatch(key: UniqueKey(), time: 60, partie : partie);

    void winPopup(BuildContext context, int nbPoints) {
      String points = nbPoints.toString();
      // String chrono2 = chrono.toString();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('timer_victory_title'.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white)),
            backgroundColor: Colors.transparent,
            content: Text(
                'timer_victory_content'.trParams({'points': points}),
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

    void losePopup(BuildContext context, int nbPoints) {
      nbPoints = -nbPoints;
      String points = nbPoints.toString();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('game_over'.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white)),
            backgroundColor: Colors.transparent,
            content: Text('game_over_text'.trParams({'points': points}),
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
                      Navigator.pushNamed(context, '/solution',
                          arguments: {'grille': partie.grille});
                    },
                  )),
            ],
          );
        },
      );
    }

    void abandonPopup(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'abandon'.tr,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.transparent,
            content: Text('abandon_text'.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white)),
            actions: <Widget>[
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                    alignment: Alignment.bottomCenter,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0x7F373855),
                    ),
                    child: IconButton(
                      icon: const Icon(BootstrapIcons.check),
                      onPressed: () {
                        partie.player.score += -15;
                        partie.player.partiePerdu += 1;
                        partie.updateJoueur();
                        Navigator.pop(context);
                        losePopup(context, -15);
                      },
                      color: Colors.white,
                    )),
                const SizedBox(width: 50),
                Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0x7F373855),
                    ),
                    child: IconButton(
                      icon: const Icon(BootstrapIcons.x),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: Colors.red,
                    ))
              ]),
            ],
          );
        },
      );
    }

    String getTime(int chrono) {
      debugPrint("chrono : $chrono");
      int minutes = (chrono / 60).floor();
      int secondes = ((chrono) % 60).floor();
      String minutes2 = minutes.toString();
      String secondes2 = secondes.toString();
      if (minutes < 10) {
        minutes2 = '0$minutes2';
      }
      if (secondes < 10) {
        secondes2 = '0$secondes2';
      }
      return '$minutes2:$secondes2';
    }

    valider(Stopwatch chrono) {
      chrono.stop();
      partie.chrono = chrono.elapsedMicroseconds;
      if (partie.valider()) {
        // debugPrint('Victoire');
        timer.stopTimer();
        Navigator.pop(context);
        partie.player.score += 20;
        partie.player.partieGagne += 1;
        partie.updateJoueur();
        winPopup(context, 20);
      } else {
        //TOTEST
        Navigator.pop(context);
        partie.player.score += -15;
        partie.player.partiePerdu += 1;
        partie.updateJoueur();
        losePopup(context, -15);
      }
    }

    Stopwatch chrono = Stopwatch()..start();

    return (CoreWidget(
        child: Center(
            child: Column(children: [
      const SizedBox(height: 100),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Colors.transparent,
                    title: Text('give_up_timer'.tr,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white)),
                    content: Text(
                        'game_back_text'
                            .trParams({'points': 15.toString()}),
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white)),
                    actions: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              child: Text('give_up'.tr,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: Colors.white)),
                              onPressed: () {
                                partie.player.score += -15;
                                partie.player.partiePerdu += 1;
                                partie.updateJoueur();
                                Navigator.pop(context);
                                Navigator.pushNamed(context, '/solution',
                                    arguments: {'grille': partie.grille});
                                // TODO: Gérer la perte de points
                              },
                            ),
                          ])
                    ],
                  );
                },
              );
            },
            icon: const Icon(
              BootstrapIcons.arrow_left,
              color: Colors.white,
              size: 25,
            )),
        const SizedBox(width: 15),
        const Text("MASYU",
            style: TextStyle(
                color: Colors.white,
                letterSpacing: 10,
                fontSize: 40,
                fontWeight: FontWeight.w600))
      ]),
      const SizedBox(height: 30),
      timer,
      // StopWatchWidget(),
      const SizedBox(height: 30),
      GrilleWidget(
        gridSize: _gridSize,
        grille: partie.grille,
        solution: false,
      ),
      const SizedBox(height: 40),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
              width: 70.0,
              height: 70.0,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0x7F373855),
              ),
              child: IconButton(
                onPressed: () => {valider(chrono)},
                icon: const Icon(BootstrapIcons.check2),
                color: Colors.white,
                iconSize: 30,
              )),
          Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0x7F373855),
              ),
              child: IconButton(
                onPressed: () => {abandonPopup(context)},
                icon: const Icon(BootstrapIcons.x),
                color: Colors.red,
              )),
        ],
      )
    ]))));
  }
}
