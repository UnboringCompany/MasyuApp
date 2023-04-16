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

  //fonction pour récupérer le pseudo du joueur
  String getPseudo() {
    return pseudo;
  }

  //fonction pour récupérer le nombre de partie gagnée du joueur
  int getPartieGagne() {
    return partieGagne;
  }

  //fonction pour récupérer le nombre de partie perdue du joueur
  int getPartiePerdue() {
    return partiePerdu;
  }

  //fonction pour récupérer le score du joueur
  int getScore() {
    return score;
  }

  //fonction pour afficher le pseudo, le nombre de partie gagnée, le nombre de partie perdue et le score du joueur dans une methode toString()
  @override
  String toString() {
    return 'Joueur{pseudo: $pseudo, partieGagne: $partieGagne, partiePerdu: $partiePerdu, score: $score}';
  }
}
