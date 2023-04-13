class Joueur {
  String pseudo;
  int partieGagne;
  int partiePerdu;
  int score;

  Joueur(this.pseudo, this.partieGagne, this.partiePerdu, this.score);

  Joueur.fromJson(Map<String, dynamic>? json)
      : pseudo = json?['pseudo'],
        partieGagne = json?['partieGagne'],
        partiePerdu = json?['partiePerdu'],
        score = json?['score'];

  Map<String, dynamic> toJson() => {
        'pseudo': pseudo,
        'partieGagne': partieGagne,
        'partiePerdu': partiePerdu,
        'score': score,
      };

  String getPseudo() {
    return pseudo;
  }

  int getPartieGagne() {
    return partieGagne;
  }

  int getPartiePerdue() {
    return partiePerdu;
  }

  int getScore() {
    return score;
  }

  @override
  String toString() {
    return 'Joueur{pseudo: $pseudo, partieGagne: $partieGagne, partiePerdu: $partiePerdu, score: $score}';
  }
}
