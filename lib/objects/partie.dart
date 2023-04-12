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
    player = Joueur(
        "Joueur", 0, 0, 0); // TODO : A modifier quand on aura des joueurs biens
    startPartie(tailleGrille);
  }

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

  Partie.fromJson(Map<String, dynamic> json)
      : grille = Grille.fromJson(json['grille']),
        chrono = 0,
        tailleGrille = json['grille']['size'],
        player = Joueur.fromJson(json['player']),
        scorePartie = 0,
        nbIndices = 0;

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
    debugPrint("Validation de la partie");
    debugPrint("Liste trait : ${grille.getListeTraits()}");
    if (grille.isValid()) {
      scorePartie = scorePartie - (chrono ~/ 12);
      scorePartie = scorePartie - (5 * nbIndices);
      player.score += scorePartie;
      player.partieGagne += 1;
      return true;
    } else {
      getScoreDefaite();
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
}
