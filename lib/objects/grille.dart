import 'cell.dart';
import 'trait.dart';

class Grille {
  // Attributs
  int size;
  List<Cell> listeCells;
  List<Trait> listeTraits;

  // Constructeur
    Grille(this.size)
      : listeCells = List<Cell>.empty(growable: true),
        listeTraits = List<Trait>.empty(growable: true);

  // Méthodes
  void addCase(Cell c) {
    listeCells.add(c);
  }

  void addTrait(Trait t) {
    listeTraits.add(t);
  }

  void removeTrait(Trait t) {
    listeTraits.remove(t);
  }

  void reset() {
    // TODO
  }

  void generate() {
    // TODO
    for (int i = 0; i < size; i++) {
      for (int j = 0; j < size; j++) {
        addCase(Cell(i, j));
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
    for (Cell cell in listeCells) {
      if (!cell.isCellValid()) {
        return false;
      }
    }
    return true;
  }

  void printGrid() {
    generate();
    print(listeCells.toString());
  }
}
