import 'cell.dart';
import 'grille.dart';

class Cercle extends Cell {
  // Attributs
  int _color;
  bool _isValid;

  // Constructeur
  Cercle(int posX, int posY, this._color, this._isValid) : super(posX, posY);

  // Méthodes

  /// Modifie la validité du cercle
  /// @param grille Grille de jeu
  /// @param isValid true si le cercle est valide, false sinon
  void validate(Grille grille) {
    // On récupère les cellules précédente et suivante
    Cell? cellPrecedente = getCellPrecedente(grille);
    Cell? cellSuivante = getCellSuivante(grille);
    if (cellPrecedente != null && cellSuivante != null) {
      // Si elles existent, on vérifie si les conditions en fonction des couleurs sont respectées
      if (_color == 1) {
        if ((cellSuivante.isCellTurning(grille) ||
                cellPrecedente.isCellTurning(grille)) &&
            !isCellTurning(grille)) {
          _isValid = true;
        }
      } else if (_color == 2) {
        if (!(cellSuivante.isCellTurning(grille) &&
                cellPrecedente.isCellTurning(grille)) &&
            isCellTurning(grille)) {
          _isValid = true;
        }
      }
    }

    _isValid = false;
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
    if (super.isCellValid(grille)) {
      return _isValid;
      // return true;
    }
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
