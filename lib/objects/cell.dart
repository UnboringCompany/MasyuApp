import 'package:flutter/cupertino.dart';
import 'cercle.dart';
import 'grille.dart';
import 'trait.dart';

class Cell {
  // Attributs
  int _posX;
  int _posY;

  // Constructeur
  Cell(this._posX, this._posY);

  // Cell.fromJson(Map<String, dynamic> json)
  //     : _cellDep = Cell.fromJson(json['cellDep']),
  //       _cellArr = Cell.fromJson(json['cellArr']);

  Map<String, dynamic> toJson() => {
        'posX': _posX,
        'posY': _posY,
      };

  // Méthodes

  /// Vérifie la validité de la cellule
  /// @param grille Grille de jeu
  /// @return true si la cellule est valide, false sinon
  bool isCellValid(Grille grille) {
    // Vérifie que la cellule a bien soit 2 traits, soit aucun trait
    Trait? t = getTraitArrivant(grille);
    Trait? t2 = getTraitPartant(grille);
    if (t != null && t2 != null) {
      return true;
    } else if (t == null && t2 == null) {
      return true;
    }
    return false;
  }

  /// Vérifie si la cellule est une intersection
  /// @param grille Grille de jeu
  /// @return true si la cellule est une intersection, false sinon
  bool isCellTurning(Grille grille) {
    Trait t1 = getTraitArrivant(grille)!;
    Trait t2 = getTraitPartant(grille)!;
    if (t1.isHorizontal() && t2.isVertical()) {
      return true;
    }
    if (t1.isVertical() && t2.isHorizontal()) {
      return true;
    }
    return false;
  }

  /// Récupère le trait arrivant sur la cellule s'il existe
  /// @param grille Grille de jeu
  /// @return Trait arrivant sur la cellule
  Trait? getTraitArrivant(Grille grille) {
    for (Trait t in grille.getListeTraits()) {
      if (t.getCaseArr() == this) {
        return t;
      }
    }
    return null;
  }

  /// Récupère le trait partant de la cellule s'il existe
  /// @param grille Grille de jeu
  /// @return Trait partant de la cellule
  Trait? getTraitPartant(Grille grille) {
    for (Trait t in grille.getListeTraits()) {
      if (t.getCaseDep() == this) {
        return t;
      }
    }
    return null;
  }

  /// Récupère la cellule précédente de la cellule s'il existe
  /// @param grille Grille de jeu
  /// @return Cellule précédente de la cellule
  Cell getCellPrecedente(Grille grille) {
    Trait? t = getTraitArrivant(grille);
    if (t != null) {
      return t.getCaseDep();
    }
    return Cell(-1, -1);
  }

  /// Récupère la cellule suivante de la cellule s'il existe
  /// @param grille Grille de jeu
  /// @return Cellule suivante de la cellule
  Cell getCellSuivante(Grille grille) {
    Trait? t = getTraitPartant(grille);
    if (t != null) {
      return t.getCaseArr();
    }
    return Cell(-1, -1);
  }

  // Accesseurs

  /// Retourne la position en X de la cellule
  /// @return position en X
  int getPosX() {
    return _posX;
  }

  /// Retourne la position en Y de la cellule
  /// @return position en Y
  int getPosY() {
    return _posY;
  }

  @override
  String toString() {
    return 'C($_posX, $_posY)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Cell && _posX == other.getPosX() && _posY == other.getPosY();
}
