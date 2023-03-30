import 'cell.dart';

class Cercle extends Cell {
  // Attributs
  int color;
  bool isValid;

  // Constructeur
  Cercle(int posX, int posY, this.color, this.isValid)
      : super(posX, posY);

  // Méthodes
  void getColor() {
    // TODO
  }

  @override
  bool isCellValid() {
    // TODO
    return true;
  }
}
