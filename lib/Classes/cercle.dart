import 'case.dart';

class cercle extends Case {
  // Attributs
  int color;
  bool is_valid;

  // Constructeur
  cercle(int pos_x, int pos_y, this.color, this.is_valid)
      : super(pos_x, pos_y);

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
