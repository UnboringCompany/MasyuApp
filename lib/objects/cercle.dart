import 'package:flutter/material.dart';

import 'cell.dart';
import 'grille.dart';

class Cercle extends Cell {
  // Attributs
  int _color;
  bool _isValid;

  // Constructeur
  Cercle(int posX, int posY, this._color, this._isValid) : super(posX, posY);

  @override
  Map<String, dynamic> toJson() => {
        'posX': getPosX(),
        'posY': getPosY(),
        'color': _color,
        'isValid': _isValid,
      };

  // Méthodes

  /// Modifie la validité du cercle
  /// @param grille Grille de jeu
  /// @param isValid true si le cercle est valide, false sinon
  void validate(Grille grille) {
    // On récupère les cellules précédente et suivante
    List<Cell> liste = getCellsVoisines(grille);
    if(liste.length == 2){
      if (liste[0] != null && liste[1] != null) {
        // Si elles existent, on vérifie si les conditions en fonction des couleurs sont respectées
        if (_color == 1) {
          if ((liste[0].verifCellTurning(grille) ||
                  liste[1].verifCellTurning(grille)) &&
              !verifCellTurning(grille)) {
            _isValid = true;
          }
        } else if (_color == 2) {
          if (!(liste[0].verifCellTurning(grille) &&
                  liste[1].verifCellTurning(grille)) &&
              verifCellTurning(grille)) {
            _isValid = true;
          }
        }
      }
    }
    
  }

  // Accesseurs

  /// Retourne la couleur du cercle
  /// @return couleur du cercle
  int getColor() {
    return _color;
  }

  /// Retourne si le cercle est valide
  /// @return true si le cercle est valide, false sinon
  bool getIsValid() {
    return _isValid;
  }

  @override
  bool isCellValid(Grille grille) {
    validate(grille);
    // debugPrint("Le cercle $this est valide : $_isValid");
    if (super.isCellValid(grille)) {
      return _isValid;
    }
    // debugPrint("Le cercle $this n'est pas valide en tant que cellule");
    return false;
  }

  @override
  String toString() {
    String couleur = 'M';
    if (_color == 1) {
      couleur = 'B';
    } else if (_color == 2) {
      couleur = 'N';
    }
    return '$couleur(${getPosX()} , ${getPosY()})';
  }
}
