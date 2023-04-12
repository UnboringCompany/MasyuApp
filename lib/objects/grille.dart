import 'dart:math';
import 'package:flutter/material.dart';
import 'cell.dart';
import 'cercle.dart';
import 'trait.dart';
import 'dart:io';

class Grille {
  // Attributs
  int _size;
  List<Cell> _listeCells;
  List<Cercle> _listeCercle;
  List<Trait> _listeTraits;
  List<Trait> _listeTraitsSolution;

  // Constructeur
  Grille(this._size)
      : _listeCells = List<Cell>.empty(growable: true),
        _listeCercle = List<Cercle>.empty(growable: true),
        _listeTraits = List<Trait>.empty(growable: true),
        _listeTraitsSolution = List<Trait>.empty(growable: true);

  // Constructeur à partir d'un json
  Grille.fromJson(Map<String, dynamic> json)
      : _size = json['size'],
        _listeCells = json['listeCells'],
        _listeCercle = json['listeCercle'],
        _listeTraits = json['listeTraits'],
        _listeTraitsSolution = json['listeTraitsSolution'];

  // Convertit la grille en json
  Map<String, dynamic> toJson() => {
        'size': _size,
        'listeCells': _listeCells,
        'listeTraits': _listeTraits,
        'listeTraitsSolution': _listeTraitsSolution,
      };

  // Méthodes

  /// Ajoute une cellule à la grille
  /// @param c la cellule à ajouter
  void addCell(Cell c) {
    _listeCells.add(c);
  }

  void addCercle(Cercle c) {
    _listeCercle.add(c);
  }

  void removeCercle(Cercle c) {
    _listeCercle.remove(c);
  }

  /// Supprime une cellule de la grille
  /// @param c la cellule à supprimer
  void removeCell(Cell c) {
    _listeCells.remove(c);
  }

  /// Remplace une cellule par un cercle de la couleur indiquée
  /// @param c la cellule à remplacer
  /// @param couleur la couleur du cercle, 1 pour blanc et 2 pour noir
  void replaceCellbyCercle(Cell c, int couleur) {
    Cercle c2 = Cercle(c.getPosX(), c.getPosY(), couleur, false);
    _listeCells[_listeCells.indexOf(c)] = c2;
    addCercle(c2);
  }

  /// Ajoute un trait à la grille
  /// @param t le trait à ajouter
  void addTrait(Trait t) {
    _listeTraits.add(t);
  }

  /// Supprime un trait de la grille
  /// @param t le trait à supprimer
  void removeTrait(Trait t) {
    _listeTraits.remove(t);
  }

  /// Ajoute un trait à la solution
  /// @param t le trait à ajouter
  void addTraitSolution(Trait t) {
    _listeTraitsSolution.add(t);
  }

  /// Supprime un trait de la solution
  /// @param t le trait à supprimer
  void removeTraitSolution(Trait t) {
    _listeTraitsSolution.remove(t);
  }

  /// Réinitialise la liste de traits
  void reset() {
    _listeTraits.clear();
  }

  /// Fonction qui permet de savoir si le chemin est assez long
  /// pour être considéré comme une solution
  /// @param tailleChemin la taille du chemin
  /// @param tailleMin la taille minimale du chemin
  /// @return true si le chemin est assez long, false sinon
  bool isThePathLongEnough(int tailleChemin, int tailleMin) {
    if (tailleChemin >= tailleMin) {
      return true;
    }
    return false;
  }

  /// Fonction qui donne les voisins d'une cellule
  /// @param cell la cellule dont on veut les voisins
  /// @param ordreChemin la liste des cellules du chemin
  /// @return la liste des voisins de la cellule
  getVoisins(Cell cell, List<Cell> ordreChemin) {
    int x = cell.getPosX();
    int y = cell.getPosY();

    var voisins = List<Cell>.empty(growable: true);

    // Les cellules dans les coins et sur les bords ont moins de voisins, on s'assure donc de ne pas ajouter de voisins hors de la grille qui de ce fait n'éxisteraient pas
    if (x > 0) {
      voisins.add(Cell(x - 1, y));
    }
    if (x < _size - 1) {
      voisins.add(Cell(x + 1, y));
    }
    if (y > 0) {
      voisins.add(Cell(x, y - 1));
    }
    if (y < _size - 1) {
      voisins.add(Cell(x, y + 1));
    }

    // Si la cellule actuelle a des voisins non visités
    var tailleChemin = ordreChemin.length;
    var tailleMin = (_size * _size * 4) ~/ 5;
    if (isThePathLongEnough(tailleChemin, tailleMin)) {
      voisins = voisins
          .where((voisin) =>
              !ordreChemin.contains(voisin) || voisin == ordreChemin[0])
          .toList();
    } else {
      voisins =
          voisins.where((voisin) => !ordreChemin.contains(voisin)).toList();
    }

    // On retourne la liste des voisins
    return voisins;
  }

  /// Fonction qui permet de générer la grille de jeu et la solution qui est gardée en mémoire pour si l'utilisateur à besoin d'un indice ou de la réponse.
  void generate() {
    // TOTEST
    generateCells();
    generateChemin();
    // On copie la liste des solutions dans la liste des traits pour ne pas doubler les méthodes utilisées
    for (Trait t in _listeTraitsSolution) {
      _listeTraits.add(t);
    }
    // On ajoute les cellules de la boucle dans la liste ordreChemin
    var ordreChemin = List<Cell>.empty(growable: true);
    for (Trait trait in _listeTraitsSolution) {
      ordreChemin.add(trait.getCaseDep());
    }
    // Pour chaque cellule de la boucle, on vérifie qu'on peut y mettre un cercle noir ou blanc et si c'est le cas on le met
    for (Cell cell in ordreChemin) {
      if (iCanPutABlackCellHere(cell)) {
        replaceCellbyCercle(cell, 2);
      } else if (iCanPutAWhiteCellHere(cell)) {
        replaceCellbyCercle(cell, 1);
      }
    }
    // On efface la liste des traits car elle sera à remplir par l'utilisateur lorsqu'il jouera
    _listeTraits.clear();
  }

  /// Fonction qui permet de générer les cellules de la grille
  void generateCells() {
    for (int i = 0; i < _size; i++) {
      for (int j = 0; j < _size; j++) {
        addCell(Cell(i, j));
      }
    }
  }

  /// Fonction qui permet de générer le chemin de la grille dans la liste des trais de la solution
  void generateChemin() {
    // Création de la pile de traits et de la liste ordonnée de cellules visitées
    var pile = List<Trait>.empty(growable: true);
    var ordreChemin = List<Cell>.empty(growable: true);

    // Sélection de la cellule de départ presque aléatoire ( on essaye de ne pas placer le début sur un bord pour que la génération se fasse mieux)
    Cell cellDep = Cell(Random().nextInt(_size ~/ 2) + _size ~/ 3,
        Random().nextInt(_size ~/ 2) + _size ~/ 3);
    Cell theCell = cellDep;
    Cell cellArr = Cell(-1, -1);
    ordreChemin.add(cellDep);
    int i = 0;
    int imax = (_size * _size * 11) ~/ 10;

    // Boucle principale de construction du chemin
    for (i; i <= imax && theCell != cellArr; i++) {
      // Sélection de la liste des voisins de la cellule actuelle
      List<Cell> voisins = getVoisins(cellDep, ordreChemin);
      // debugPrint("Voisins de $cellDep : $voisins");

      if (voisins.isEmpty) {
        // Si la cellule actuelle n'a pas de voisin non visité, on dépile la dernière cellule visitée
        if (pile.isNotEmpty) {
          Trait dernierTrait = pile.removeLast();
          _listeTraitsSolution.remove(dernierTrait);
          Cell cretiree = ordreChemin.removeLast();
          cellDep = dernierTrait.getCaseDep();
          cellArr = dernierTrait.getCaseArr();
        } else {
          // Sinon, le chemin est terminé
          break;
        }
      } else {
        // Sélection d'un voisin aléatoire
        Cell voisin = voisins[Random().nextInt(voisins.length)];
        // Ajout d'un trait entre la cellule actuelle et le voisin sélectionné
        Trait trait = Trait(cellDep, voisin);
        addTraitSolution(trait);
        pile.add(trait);

        // Définition de la nouvelle cellule de départ et ajout à la liste ordonnée de cellules visitées
        cellDep = voisin;
        cellArr = cellDep;
        ordreChemin.add(cellDep);
      }

      // Si on a parcouru trop de cellules sans trouver de solution, on recommence
      if (i == imax - 1) {
        i = 0;
        voisins.clear();
        ordreChemin.clear();
        ordreChemin.add(theCell);
        cellDep = theCell;
        pile.clear();
        _listeTraitsSolution.clear();
        cellArr = Cell(-1, -1);
      }
    }
  }

  /// Fonction qui permet de vérifier les conditions pour pouvoir mettre un cercle blanc sur une cellule
  /// @param c : la cellule à vérifier
  /// @return true si on peut mettre un cercle blanc sur la cellule, false sinon
  bool iCanPutAWhiteCellHere(Cell c) {
    Cell? cellPrecedente = c.getCellPrecedente(this);
    Cell? cellSuivante = c.getCellSuivante(this);
    if (cellPrecedente != null && cellSuivante != null) {
      if ((cellPrecedente.isCellTurning(this) ||
              cellSuivante.isCellTurning(this)) &&
          !c.isCellTurning(this)) {
        // Les conditions sont de tourner avant ou après mais pas dans la cellule
        return true;
      }
    }
    return false;
  }

  /// Fonction qui permet de vérifier les conditions pour pouvoir mettre un cercle noir sur une cellule
  /// @param c : la cellule à vérifier
  /// @return true si on peut mettre un cercle noir sur la cellule, false sinon
  bool iCanPutABlackCellHere(Cell c) {
    Cell? cellPrecedente = c.getCellPrecedente(this);
    Cell? cellSuivante = c.getCellSuivante(this);
    if (cellPrecedente != null && cellSuivante != null) {
      if (!cellPrecedente.isCellTurning(this) &&
          !cellSuivante.isCellTurning(this) &&
          c.isCellTurning(this)) {
        // Les conditions sont d'aller tout droit avant et après et de tourner dans la cellule
        return true;
      }
    }
    return false;
  }

  /// Fonction qui permet de vérifier si la grille est valide
  bool isValid() {
    // On vérifie que chaque cellule est valide
    for (Cell cell in _listeCells) {
      if (!cell.isCellValid(this)) {
        // debugPrint("La cellule ${cell.toString()} n'est pas valide");
        return false;
      }
    }
    return true;
  }

  /// Fonction qui permet d'aller chercher un indice
  /// @return true si la grille est complète, false sinon
  getClue() {
    // Cherche dans la liste des traits de la solution un trait qui n'est pas dans la liste des traits de la grille
    List<Trait> listeTraitNotPlaced = List<Trait>.empty(growable: true);
    for (Trait trait in _listeTraitsSolution) {
      if (!_listeTraits.contains(trait)) {
        listeTraitNotPlaced.add(trait);
      }
    }
    int size = listeTraitNotPlaced.length;

    return listeTraitNotPlaced[Random().nextInt(size)];
  }

  // Accesseurs

  /// Fonction qui permet de récupérer la taille de la grille
  /// @return la taille de la grille
  int getSize() {
    return _size;
  }

  /// Fonction qui permet de récupérer la liste des cellules de la grille
  /// @return la liste des cellules de la grille
  List<Cell> getListeCells() {
    return _listeCells;
  }

  List<Cercle> getListeCercle() {
    return _listeCercle;
  }

  /// Fonction qui permet de récupérer la liste des traits de la grille
  /// @return la liste des traits de la grille
  List<Trait> getListeTraits() {
    return _listeTraits;
  }

  /// Fonction qui permet de récupérer la liste des traits de la solution de la grille
  /// @return la liste des traits de la solution de la grille
  List<Trait> getListeTraitsSolution() {
    return _listeTraitsSolution;
  }

  // Fonctions d'affichage dans la console pour le debug
  void printGrid() {
    generate();
    afficheChemin();
    afficheGrid();
  }

  void afficheGrid() {
    int cptBlanc = 0;
    int cptNoir = 0;
    for (int i = 0; i < _size; i++) {
      for (int j = 0; j < _size; j++) {
        for (Cell cell in _listeCells) {
          if (cell.getPosX() == i && cell.getPosY() == j) {
            if (cell is Cercle) {
              Cercle cercle = cell;
              if (cercle.getColor() == 1) {
                // debugPrint("B : ${cercle.getPosX()}, ${cercle.getPosY()}");
                cptBlanc++;
              } else if (cercle.getColor() == 2) {
                // debugPrint("N : ${cercle.getPosX()}, ${cercle.getPosY()}");
                cptNoir++;
              }
            } else {}
          }
        }
      }
    }
    // debugPrint("Nombre de cellules blanches : $cptBlanc");
    // debugPrint("Nombre de cellules noires : $cptNoir");
  }

  void afficheChemin() {
    _listeTraitsSolution.forEach((element) {
      // debugPrint(element.toString());
    });
  }

  @override
  String toString() {
    return 'Grid{_size: $_size, _listeCells: $_listeCells, _listeTraits: $_listeTraits}';
  }
}
