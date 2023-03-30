import 'case.dart';
import 'trait.dart';

class Grille {
  // Attributs
  int size;
  List<Case> liste_cases;
  List<Trait> liste_traits;

  // Constructeur
  Grille(this.size){
    liste_cases = [];
    liste_traits = [];
  }

  // Méthodes
  void addCase(Case c) {
    liste_cases.add(c);
  }

  void addTrait(Trait t) {
    liste_traits.add(t);
  }

  void removeTrait(Trait t) {
    liste_traits.remove(t);
  }

  void reset() {
    // TODO
  }

  void generate() {
    // TODO
    for (int i = 0; i < size; i++) {
      for (int j = 0; j < size; j++) {
        addCase(Case(i, j));
      }
    }
    int nb_cercles_blancs = size * size ~/ 2;
    int nb_cercles_noirs = size * size - nb_cercles_blancs;


  }

  void solve() {
    // TODO
  }

  bool isValid() {
    // TODO
    for (case in liste_cases) {
      if (!case.isValid()) {
        return false;
      }
    }
    return true;
  }
}
