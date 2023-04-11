import 'cercle.dart';

class Case {
  // Attributs
  int pos_x;
  int pos_y;

  // Constructeur
  Case(this.pos_x, this.pos_y);

  bool isValid() {
    // TODO
    return true;
  }

  int getPos_x() {
    return pos_x;
  }

  int getPos_y() {
    return pos_y;
  }

  void getID() {
    // TODO
  }

  bool isaCercle() {
    if(this is Cercle)
    {
      return true;
    }
    return false;
  }


}
