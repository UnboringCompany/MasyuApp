import 'cell.dart';

class Trait{
  // Attributs
  Cell _cellDep;
  Cell _cellArr;

  // Constructeur
  Trait(this._cellDep, this._cellArr);

  // Méthodes

  /// Vérifie si le trait est vertical
  /// @return true si le trait est vertical, false sinon
  bool isVertical() {
    if (_cellArr.getPosX() == _cellDep.getPosX() && _cellArr.getPosY() != _cellDep.getPosY()) {
      return true;
    }
    return false;
  }

  /// Vérifie si le trait est horizontal
  /// @return true si le trait est horizontal, false sinon
  bool isHorizontal() {
    if (_cellArr.getPosX() != _cellDep.getPosX() && _cellArr.getPosY() == _cellDep.getPosY()) {
      return true;
    }
    return false;
  }

  // Accesseurs

  /// Retourne la case de départ du trait
  /// @return cellule de départ
  Cell getCaseDep() {
    return _cellDep;
  }

  /// Retourne la case d'arrivée du trait
  /// @return cellule d'arrivée
  Cell getCaseArr() {
    return _cellArr;
  }

  @override
  String toString() {
    return 'Trait de $_cellDep à $_cellArr';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Trait &&
          _cellDep == other._cellDep &&
          _cellArr == other._cellArr;
          

}