import 'package:masyu_app/objects/joueur.dart';

import 'grille.dart';

class Partie {
  Grille grille;
  int chrono;
  Joueur player;
  int scorePartie;

  Partie(this.grille, this.chrono, this.player, this.scorePartie);

  Partie.fromJson(Map<String, dynamic> json)
      : grille = Grille.fromJson(json['grille']),
        chrono = json['chrono'],
        player = Joueur.fromJson(json['player']),
        scorePartie = json['scorePartie'];

  Map<String, dynamic> toJson() => {
        'grille': grille,
        'chrono': chrono,
        'player': player,
        'scorePartie': scorePartie,
      };

  void updateScoreJoueur() {
    player.score += scorePartie;
    if (grille.isValid()) {
      player.partieGagne += 1;
      player.score = player.score + scorePartie;
    } else {
      player.partiePerdu += 1;
      player.score = player.score - scorePartie;
      if (player.score < 0) {
        player.score = 0;
      }
    }
  }

  void startPartie() {
    grille.generate();
    chrono = 0;
  }

  void save() {
    //TODO
  }

  void valider() {
    if (grille.isValid()) {
      updateScoreJoueur();
    } else {
      updateScoreJoueur();
    }
  }

  void charger() {
    //TODO
  }

  @override
  String toString() {
    return 'Partie{grille: $grille, chrono: $chrono, player: $player, scorePartie: $scorePartie}';
  }
}
