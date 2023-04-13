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

import 'main.dart';
import 'objects/partie.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<StatefulWidget> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
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

    Future<String?> _getId() async {
      var deviceInfo = DeviceInfoPlugin();
      if (Platform.isIOS) {
        final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
        var data = await deviceInfoPlugin.iosInfo;
        var identifier = data.identifierForVendor;
        return identifier;
      } else if (Platform.isAndroid) {
        final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
        AndroidDeviceInfo androidInfo;
        try {
          androidInfo = await deviceInfo.androidInfo;
          return androidInfo.id;
        } catch (e) {
          print('Error: $e');
        }
      }
      return null;
    }

    void saveGame() async {
      try {
        String? id = await _getId();
        await Firebase.initializeApp();
        await FirebaseFirestore.instance
            .collection('grilles')
            .doc(id ?? 'loser')
            .set({
          'chrono': partie.getChrono(),
          'scorePartie': partie.getScorePartie(),
          'nbIndices': partie.getnbIndices(),
          'grille': {
            'size': partie.grille.getSize(),
            'listeCells': partie.grille
                .getListeCells()
                .map((cell) => cell.toJson())
                .toList(),
            'listeTraits': partie.grille
                .getListeTraits()
                .map((trait) => trait.toJson())
                .toList(),
            'listeTraitsSolution': partie.grille
                .getListeTraitsSolution()
                .map((trait) => trait.toJson())
                .toList(),
          }
        });
        print('Grille ajoutée avec succès');
      } catch (error) {
        print('Erreur lors de l\'ajout des données à Firebase: $error');
      }
    }

    void winPopup(BuildContext context, int nbPoints, int chrono) {
      String points = nbPoints.toString();
      String chrono2 = chrono.toString();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('bravo'.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white)),
            backgroundColor: Colors.transparent,
            content: Text(
                'bravo_text'.trParams({'points': points, 'time': chrono2}),
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
                    onPressed: () async {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/');
                      String? id = await _getId();
                      await Firebase.initializeApp();
                      final docRef = FirebaseFirestore.instance
                          .collection('grilles')
                          .doc(id);
                      final docSnapshot = await docRef.get();
                      docRef
                          .delete()
                          .then((value) => print('Document supprimé'))
                          .catchError((error) => print(
                              'Erreur lors de la suppression du document : $error'));
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
                      onPressed: () async {
                        Navigator.pop(context);
                        losePopup(context, partie.getScoreDefaite());
                        String? id = await _getId();
                        await Firebase.initializeApp();
                        final docRef = FirebaseFirestore.instance
                            .collection('grilles')
                            .doc(id);
                        final docSnapshot = await docRef.get();
                        docRef
                            .delete()
                            .then((value) => print('Document supprimé'))
                            .catchError((error) => print(
                                'Erreur lors de la suppression du document : $error'));
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

    valider() {
      if (partie.valider()) {
        // debugPrint('Victoire');
        // Navigator.pop(context);
        winPopup(context, partie.getScorePartie(), partie.getChrono());
      } else {
        //TOTEST
        Navigator.pop(context);
        losePopup(context, partie.getScorePartie());
      }
    }

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
                    title: Text('game_back'.tr,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white)),
                    content: Text('game_back_text'.trParams({'points': '40'}),
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
                              onPressed: () async {
                                String? id = await _getId();
                                await Firebase.initializeApp();
                                final docRef = FirebaseFirestore.instance
                                    .collection('grilles')
                                    .doc(id);
                                final docSnapshot = await docRef.get();
                                docRef
                                    .delete()
                                    .then((value) => print('Document supprimé'))
                                    .catchError((error) => print(
                                        'Erreur lors de la suppression du document : $error'));
                                Navigator.pop(context);
                                Navigator.pushNamed(context, '/solution',
                                    arguments: {'grille': partie.grille});
                                // TODO: Gérer la perte de points
                              },
                            ),
                            TextButton(
                              child: Text('save'.tr,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: Colors.white)),
                              onPressed: () async {
                                saveGame();
                                Navigator.pop(context);
                                Navigator.of(context).pushNamed('/');
                              },
                            )
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
      StopWatchWidget(),
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
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0x7F373855),
              ),
              child: IconButton(
                onPressed: () async {
                  saveGame();
                  Navigator.pop(context);
                  Navigator.of(context).pushNamed('/');
                },
                icon: const Icon(BootstrapIcons.cloud_upload),
                color: Colors.white,
              )),
          Container(
              width: 70.0,
              height: 70.0,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0x7F373855),
              ),
              child: IconButton(
                onPressed: () => {valider()},
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
