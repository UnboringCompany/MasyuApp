import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:masyu_app/objects/joueur.dart';

import 'grille.dart';

class Partie {
  late Grille grille;
  int tailleGrille;
  int chrono = 0;
  late Joueur player;
  int scorePartie = 0;
  int nbIndices = 0;

  Partie(this.tailleGrille) {
    grille = Grille(tailleGrille);
    generatePlayer();
    startPartie(tailleGrille);
  }

  Future<String?> _getId() async {
    if (Platform.isIOS) {
      final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
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

  Future<Joueur> _getPlayer() async {
    String? id = await _getId();
    await Firebase.initializeApp();
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await FirebaseFirestore.instance
            .collection('utilisateur')
            .doc(id)
            .get();
    if (documentSnapshot.exists) {
      return Joueur.fromJson(documentSnapshot.data());
    } else {
      return Joueur(id ?? 'Joueur', 0, 0, 0);
    }
  }

  void generatePlayer() async {
    player = await _getPlayer();
  }

  Partie.fromJson(Map<String, dynamic> json, Map<String, dynamic> joueur)
      : grille = Grille.fromJson(json['grille']),
        chrono = json['chrono'],
        tailleGrille = json['grille']['size'],
        player = Joueur.fromJson(joueur),
        scorePartie = json['scorePartie'],
        nbIndices = json['nbIndices'];

  int getScorePartie() => scorePartie;

  void startPartie(int tailleGrille) {
    chrono = 0;
    nbIndices = 0;
    if (tailleGrille == 6) {
      scorePartie = 40;
    } else if (tailleGrille == 8) {
      scorePartie = 60;
    } else if (tailleGrille == 10) {
      scorePartie = 80;
    }

    grille.generate();
  }

  Map<String, dynamic> toJson() => {
        'grille': grille,
        'chrono': chrono,
        'player': player,
        'scorePartie': scorePartie,
        'nbIndices': nbIndices,
      };

  void save() {
    //TODO
  }

  bool valider() {
    // debugPrint("Validation de la partie");
    // debugPrint("Liste trait : ${grille.getListeTraits()}");
    if (grille.isValid()) {
      chrono = chrono ~/ 1000000;
      nbIndices = grille.getNbIndices();
      scorePartie = scorePartie - (chrono ~/ 12);
      scorePartie = scorePartie - (5 * nbIndices);
      player.score += scorePartie;
      player.partieGagne += 1;
      updateJoueur();
      return true;
    } else {
      getScoreDefaite();
      updateJoueur();
      return false;
    }
  }

  int getScoreDefaite() {
    player.partiePerdu += 1;
    if (grille.getSize() == 6) {
      scorePartie = -25;
    } else if (grille.getSize() == 8) {
      scorePartie = -40;
    } else if (grille.getSize() == 10) {
      scorePartie = -50;
    }
    player.score += scorePartie;
    return scorePartie;
  }

  void charger() {
    //TODO
  }

  @override
  String toString() {
    return 'Partie{grille: $grille, chrono: $chrono, player: $player, scorePartie: $scorePartie}';
  }

  int getChrono() {
    return chrono;
  }

  int getnbIndices() {
    return nbIndices;
  }

  Future<void> updateJoueur() async {
    String? id = await _getId();
    await Firebase.initializeApp();
    if (player.pseudo != id && player.pseudo != 'Joueur') {
      await FirebaseFirestore.instance
          .collection('utilisateur')
          .doc(id)
          .update({
        'partieGagne': player.partieGagne,
        'score': player.score,
        'partiePerdu': player.partiePerdu
      });
    } else {
      await FirebaseFirestore.instance
          .collection('utilisateur')
          .doc(id)
          .set(player.toJson());
    }
  }
}
