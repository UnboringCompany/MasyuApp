import 'dart:math';

import 'package:masyu_app/objects/cercle.dart';

import 'cell.dart';
import 'trait.dart';

class Grille {
  // Attributs
  int size;
  List<Cell> listeCells;
  List<Trait> listeTraits;
  List<Trait> listeSolution = List<Trait>.empty(growable: true);
  int choice = 0;

  // Constructeur
  Grille(this.size)
      : listeCells = List<Cell>.empty(growable: true),
        listeTraits = List<Trait>.empty(growable: true);

  // Méthodes
  void addCell(Cell c) {
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

  void generateCells() {
    for (int i = 0; i < size; i++) {
      for (int j = 0; j < size; j++) {
        addCell(Cell(i, j));
      }
    }
  }

  Cell getCell(int x, int y) {
    for (Cell c in listeCells) {
      if (c.posX == x && c.posY == y) {
        return c;
      }
    }
    return Cell(0, 0);
  }

  void replaceCell(int x, int y, int color) {
    for (int i = 0; i < size; i++) {
      if (listeCells[i].posX == x && listeCells[i].posY == y) {
        listeCells[i] = Cercle(x, y, color, false);
        break;
      }
    }
  }

  void generateGrille() {
    choice = Random().nextInt(5);
    generateCells();
    switch (choice) {
      case 0:
        replaceCell(0, 1, 1);
        replaceCell(1, 5, 1);
        replaceCell(2, 1, 1);
        replaceCell(2, 2, 1);
        replaceCell(2, 3, 1);
        replaceCell(3, 3, 2);
        replaceCell(4, 0, 1);
        replaceCell(4, 2, 2);
        replaceCell(5, 3, 1);
        listeSolution.add(Trait(getCell(0, 0), getCell(0, 1)));
        listeSolution.add(Trait(getCell(0, 1), getCell(0, 2)));
        listeSolution.add(Trait(getCell(0, 2), getCell(0, 3)));
        listeSolution.add(Trait(getCell(0, 3), getCell(0, 4)));
        listeSolution.add(Trait(getCell(0, 4), getCell(0, 5)));
        listeSolution.add(Trait(getCell(0, 5), getCell(1, 5)));
        listeSolution.add(Trait(getCell(1, 5), getCell(2, 5)));
        listeSolution.add(Trait(getCell(2, 5), getCell(3, 5)));
        listeSolution.add(Trait(getCell(3, 5), getCell(3, 4)));
        listeSolution.add(Trait(getCell(3, 4), getCell(3, 3)));
        listeSolution.add(Trait(getCell(3, 3), getCell(2, 3)));
        listeSolution.add(Trait(getCell(2, 3), getCell(1, 3)));
        listeSolution.add(Trait(getCell(1, 3), getCell(1, 2)));
        listeSolution.add(Trait(getCell(1, 2), getCell(2, 2)));
        listeSolution.add(Trait(getCell(2, 2), getCell(3, 2)));
        listeSolution.add(Trait(getCell(3, 2), getCell(4, 2)));
        listeSolution.add(Trait(getCell(4, 2), getCell(4, 3)));
        listeSolution.add(Trait(getCell(4, 3), getCell(4, 4)));
        listeSolution.add(Trait(getCell(4, 4), getCell(5, 4)));
        listeSolution.add(Trait(getCell(5, 4), getCell(5, 3)));
        listeSolution.add(Trait(getCell(5, 3), getCell(5, 2)));
        listeSolution.add(Trait(getCell(5, 2), getCell(5, 1)));
        listeSolution.add(Trait(getCell(5, 1), getCell(5, 0)));
        listeSolution.add(Trait(getCell(5, 0), getCell(4, 0)));
        listeSolution.add(Trait(getCell(4, 0), getCell(3, 0)));
        listeSolution.add(Trait(getCell(3, 0), getCell(3, 1)));
        listeSolution.add(Trait(getCell(3, 1), getCell(2, 1)));
        listeSolution.add(Trait(getCell(2, 1), getCell(1, 1)));
        listeSolution.add(Trait(getCell(1, 1), getCell(1, 0)));
        listeSolution.add(Trait(getCell(1, 0), getCell(0, 0)));
        break;
      case 1:
        replaceCell(0, 1, 2);
        replaceCell(0, 2, 1);
        replaceCell(1, 2, 2);
        replaceCell(1, 3, 1);
        replaceCell(1, 5, 1);
        replaceCell(3, 1, 1);
        replaceCell(3, 5, 1);
        replaceCell(4, 1, 2);
        replaceCell(4, 2, 1);
        replaceCell(4, 5, 1);
        replaceCell(5, 5, 2);
        listeSolution.add(Trait(getCell(0, 1), getCell(0, 2)));
        listeSolution.add(Trait(getCell(0, 2), getCell(0, 3)));
        listeSolution.add(Trait(getCell(0, 3), getCell(0, 4)));
        listeSolution.add(Trait(getCell(0, 4), getCell(0, 5)));
        listeSolution.add(Trait(getCell(0, 5), getCell(1, 5)));
        listeSolution.add(Trait(getCell(1, 5), getCell(2, 5)));
        listeSolution.add(Trait(getCell(2, 5), getCell(2, 4)));
        listeSolution.add(Trait(getCell(2, 4), getCell(1, 4)));
        listeSolution.add(Trait(getCell(1, 4), getCell(1, 3)));
        listeSolution.add(Trait(getCell(1, 3), getCell(1, 2)));
        listeSolution.add(Trait(getCell(1, 2), getCell(2, 2)));
        listeSolution.add(Trait(getCell(2, 2), getCell(3, 2)));
        listeSolution.add(Trait(getCell(3, 2), getCell(3, 3)));
        listeSolution.add(Trait(getCell(3, 3), getCell(3, 4)));
        listeSolution.add(Trait(getCell(3, 4), getCell(3, 5)));
        listeSolution.add(Trait(getCell(3, 5), getCell(4, 5)));
        listeSolution.add(Trait(getCell(4, 5), getCell(5, 5)));
        listeSolution.add(Trait(getCell(5, 5), getCell(5, 4)));
        listeSolution.add(Trait(getCell(5, 4), getCell(5, 3)));
        listeSolution.add(Trait(getCell(5, 3), getCell(4, 3)));
        listeSolution.add(Trait(getCell(4, 3), getCell(4, 2)));
        listeSolution.add(Trait(getCell(4, 2), getCell(4, 1)));
        listeSolution.add(Trait(getCell(4, 1), getCell(3, 1)));
        listeSolution.add(Trait(getCell(3, 1), getCell(2, 1)));
        listeSolution.add(Trait(getCell(2, 1), getCell(1, 1)));
        listeSolution.add(Trait(getCell(1, 1), getCell(0, 1)));
        break;
      case 2:
        replaceCell(0, 0, 2);
        replaceCell(1, 0, 1);
        replaceCell(1, 5, 1);
        replaceCell(2, 1, 1);
        replaceCell(2, 3, 1);
        replaceCell(3, 0, 1);
        replaceCell(3, 1, 1);
        replaceCell(3, 3, 2);
        replaceCell(3, 5, 2);
        replaceCell(4, 2, 1);
        replaceCell(5, 3, 1);
        replaceCell(5, 3, 1);
        listeSolution.add(Trait(getCell(0, 0), getCell(0, 1)));
        listeSolution.add(Trait(getCell(0, 1), getCell(0, 2)));
        listeSolution.add(Trait(getCell(0, 2), getCell(0, 3)));
        listeSolution.add(Trait(getCell(0, 3), getCell(0, 4)));
        listeSolution.add(Trait(getCell(0, 4), getCell(0, 5)));
        listeSolution.add(Trait(getCell(0, 5), getCell(1, 5)));
        listeSolution.add(Trait(getCell(1, 5), getCell(2, 5)));
        listeSolution.add(Trait(getCell(2, 5), getCell(2, 4)));
        listeSolution.add(Trait(getCell(2, 4), getCell(1, 4)));
        listeSolution.add(Trait(getCell(1, 4), getCell(1, 3)));
        listeSolution.add(Trait(getCell(1, 3), getCell(2, 3)));
        listeSolution.add(Trait(getCell(2, 3), getCell(3, 3)));
        listeSolution.add(Trait(getCell(3, 3), getCell(3, 4)));
        listeSolution.add(Trait(getCell(3, 4), getCell(3, 5)));
        listeSolution.add(Trait(getCell(3, 5), getCell(4, 5)));
        listeSolution.add(Trait(getCell(4, 5), getCell(5, 5)));
        listeSolution.add(Trait(getCell(5, 5), getCell(5, 4)));
        listeSolution.add(Trait(getCell(5, 4), getCell(5, 3)));
        listeSolution.add(Trait(getCell(5, 3), getCell(5, 2)));
        listeSolution.add(Trait(getCell(5, 2), getCell(4, 2)));
        listeSolution.add(Trait(getCell(4, 2), getCell(3, 2)));
        listeSolution.add(Trait(getCell(3, 2), getCell(2, 2)));
        listeSolution.add(Trait(getCell(2, 2), getCell(1, 2)));
        listeSolution.add(Trait(getCell(1, 2), getCell(1, 1)));
        listeSolution.add(Trait(getCell(1, 1), getCell(2, 1)));
        listeSolution.add(Trait(getCell(2, 1), getCell(3, 1)));
        listeSolution.add(Trait(getCell(3, 1), getCell(4, 1)));
        listeSolution.add(Trait(getCell(4, 1), getCell(4, 0)));
        listeSolution.add(Trait(getCell(4, 0), getCell(3, 0)));
        listeSolution.add(Trait(getCell(3, 0), getCell(2, 0)));
        listeSolution.add(Trait(getCell(2, 0), getCell(1, 0)));
        listeSolution.add(Trait(getCell(1, 0), getCell(0, 0)));
        break;
      case 3:
        replaceCell(0, 1, 1);
        replaceCell(0, 3, 1);
        replaceCell(1, 1, 2);
        replaceCell(1, 3, 1);
        replaceCell(2, 1, 1);
        replaceCell(3, 1, 1);
        replaceCell(4, 2, 1);
        replaceCell(3, 4, 1);
        replaceCell(3, 5, 2);
        replaceCell(5, 0, 2);
        replaceCell(5, 1, 1);
        replaceCell(5, 4, 1);
        listeSolution.add(Trait(getCell(0, 0), getCell(0, 1)));
        listeSolution.add(Trait(getCell(0, 1), getCell(0, 2)));
        listeSolution.add(Trait(getCell(0, 2), getCell(0, 3)));
        listeSolution.add(Trait(getCell(0, 3), getCell(0, 4)));
        listeSolution.add(Trait(getCell(0, 4), getCell(1, 4)));
        listeSolution.add(Trait(getCell(1, 4), getCell(1, 3)));
        listeSolution.add(Trait(getCell(1, 3), getCell(1, 2)));
        listeSolution.add(Trait(getCell(1, 2), getCell(1, 1)));
        listeSolution.add(Trait(getCell(1, 1), getCell(2, 1)));
        listeSolution.add(Trait(getCell(2, 1), getCell(3, 1)));
        listeSolution.add(Trait(getCell(3, 1), getCell(4, 1)));
        listeSolution.add(Trait(getCell(4, 1), getCell(4, 2)));
        listeSolution.add(Trait(getCell(4, 2), getCell(4, 3)));
        listeSolution.add(Trait(getCell(4, 3), getCell(3, 3)));
        listeSolution.add(Trait(getCell(3, 3), getCell(3, 4)));
        listeSolution.add(Trait(getCell(3, 4), getCell(3, 5)));
        listeSolution.add(Trait(getCell(3, 5), getCell(4, 5)));
        listeSolution.add(Trait(getCell(4, 5), getCell(5, 5)));
        listeSolution.add(Trait(getCell(5, 5), getCell(5, 4)));
        listeSolution.add(Trait(getCell(5, 4), getCell(5, 3)));
        listeSolution.add(Trait(getCell(5, 3), getCell(5, 2)));
        listeSolution.add(Trait(getCell(5, 2), getCell(5, 1)));
        listeSolution.add(Trait(getCell(5, 1), getCell(5, 0)));
        listeSolution.add(Trait(getCell(5, 0), getCell(4, 0)));
        listeSolution.add(Trait(getCell(4, 0), getCell(3, 0)));
        listeSolution.add(Trait(getCell(3, 0), getCell(2, 0)));
        listeSolution.add(Trait(getCell(2, 0), getCell(1, 0)));
        listeSolution.add(Trait(getCell(1, 0), getCell(0, 0)));
        break;
    }
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
    generateGrille();
    print(listeCells.toString());
  }
}
