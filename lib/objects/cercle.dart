import 'cell.dart';

class cercle extends Cell {
  // Attributs
  int color;
  bool isValid;

  // Constructeur
  cercle(int posX, int posY, this.color, this.isValid)
      : super(posX, posY);

  // Méthodes
  void getColor() {
    // TODO
  }

  @override
  bool isValid() {
    // TODO
    return true;
  }
}
