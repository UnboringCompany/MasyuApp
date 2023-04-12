import 'dart:math';

import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:masyu_app/objects/cell.dart';
import 'package:masyu_app/objects/cercle.dart';
import 'package:masyu_app/objects/grille.dart';
import 'package:masyu_app/objects/trait.dart';
import 'package:masyu_app/widgets/circle.dart';

class GrilleWidget extends StatefulWidget {
  final int gridSize;
  final Grille grille;
  final bool solution;
  const GrilleWidget(
      {super.key,
      required this.gridSize,
      required this.grille,
      required this.solution});

  @override
  State<StatefulWidget> createState() => _GrilleWidgetState();
}

class _GrilleWidgetState extends State<GrilleWidget> {
  List<CircleWidget> cercles = List.empty(growable: true);
  late List<List<int>> liens;

  int _calculateIndex(Offset offset) {
    final double width = context.size!.width / widget.gridSize;
    final int column = (offset.dx / width).floor();
    final int row = (offset.dy / width).floor();
    return row * widget.gridSize + column;
  }

  bool _isTapOnLine(Offset lineStart, Offset lineEnd, Offset tapPosition) {
    const threshold =
        5; // Une tolérance pour tenir compte de la taille de l'écran et de la largeur de la ligne
    final distanceFromStart = (tapPosition - lineStart).distance;
    final distanceFromEnd = (tapPosition - lineEnd).distance;
    final lineLength = (lineEnd - lineStart).distance;
    return distanceFromStart + distanceFromEnd >= lineLength - threshold &&
        distanceFromStart + distanceFromEnd <= lineLength + threshold;
  }

  Offset _getCenterPosition(int index) {

    final cellSize = 350 /
        widget.gridSize; // La taille d'une case de la grille
    final row =
        (index / widget.gridSize).floor(); // Le numéro de ligne de la case
    final col = index % widget.gridSize; // Le numéro de colonne de la case
    final x = (col + 0.5) * cellSize; // La coordonnée x du centre de la case
    final y = (row + 0.5) * cellSize; // La coordonnée y du centre de la case
    return Offset(x, y); // Retourne l'offset du centre de la case
  }

  @override
  void initState() {
    super.initState();

    liens = List.generate(widget.gridSize * widget.gridSize,
        (_) => List<int>.filled(widget.gridSize * widget.gridSize, 0));

    SchedulerBinding.instance.addPostFrameCallback((_) {
      for (Cell cell in widget.grille.getListeCells()) {
        if (cell is Cercle) {
          cercles.add(
            CircleWidget(
                position: _getCenterPosition(
                    cell.getPosX() + cell.getPosY() * widget.gridSize),
                couleur: cell.getColor() == 1 ? "blanc" : "noir",
                size: widget.gridSize),
          );
        }
      }

      if (widget.solution) {
        for (Trait t in widget.grille.getListeTraitsSolution()) {
          liens[t.getCaseDep().getPosX() +
                  t.getCaseDep().getPosY() * widget.gridSize][
              t.getCaseArr().getPosX() +
                  t.getCaseArr().getPosY() * widget.gridSize] = 1;
          liens[t.getCaseArr().getPosX() +
                  t.getCaseArr().getPosY() * widget.gridSize][
              t.getCaseDep().getPosX() +
                  t.getCaseDep().getPosY() * widget.gridSize] = 1;
        }
      }

      setState(() {}); // Force la mise à jour de l'affichage
    });
  }

  resetGame() {
    widget.grille.reset();
    for (int i = 0; i < widget.gridSize * widget.gridSize; i++) {
      for (int j = 0; j < widget.gridSize * widget.gridSize; j++) {
        liens[i][j] = 0;
      }
    }
    setState(() {});
  }

  addClue() {
    Trait toAdd = widget.grille.getClue();

    widget.grille.addTrait(toAdd);

    liens[toAdd.getCaseDep().getPosX() +
            toAdd.getCaseDep().getPosY() * widget.grille.getSize()][
        toAdd.getCaseArr().getPosX() +
            toAdd.getCaseArr().getPosY() * widget.grille.getSize()] = 1;
    liens[toAdd.getCaseArr().getPosX() +
            toAdd.getCaseArr().getPosY() * widget.grille.getSize()][
        toAdd.getCaseDep().getPosX() +
            toAdd.getCaseDep().getPosY() * widget.grille.getSize()] = 1;
    int x = toAdd.getCaseDep().getPosX() +
        toAdd.getCaseDep().getPosY() * widget.grille.getSize();
    int y = toAdd.getCaseArr().getPosX() +
        toAdd.getCaseArr().getPosY() * widget.grille.getSize();
    debugPrint("lien ajouté : de $x à $y ");
    debugPrint("trait ajouté : $toAdd");

    setState(() {});
  }

  void cluePopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('clue'.tr,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white)),
          backgroundColor: Colors.transparent,
          content: Text('clue_text'.trParams({'points': '10'}),
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white)),
          actions: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                  alignment: Alignment.bottomCenter,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0x7F373855),
                  ),
                  child: IconButton(
                    icon: const Icon(BootstrapIcons.check),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.pushNamed(context, "/video");
                      addClue();
                    },
                    color: Colors.white,
                  )),
              const SizedBox(width: 50),
              Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0x7F373855),
                  ),
                  child: IconButton(
                    icon: const Icon(BootstrapIcons.x),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    color: Colors.red,
                  ))
            ]),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          // Nouveau GestureDetector
          onPanUpdate: (details) {
            final RenderBox gridBox = context.findRenderObject() as RenderBox;
            final startPos = gridBox.globalToLocal(details.globalPosition);
            final endPos =
                gridBox.globalToLocal(details.globalPosition + details.delta);

            final startIndex =
                ((startPos.dx / 350) * widget.gridSize).floor() +
                    (((startPos.dy / 350) * widget.gridSize)
                            .floor() *
                        widget.gridSize);
            final endIndex =
                ((endPos.dx / 350) * widget.gridSize).floor() +
                    (((endPos.dy / 350) * widget.gridSize)
                            .floor() *
                        widget.gridSize);

            if (!widget.solution) {
              if (startIndex >= 0 &&
                  startIndex <= (widget.gridSize * widget.gridSize) - 1 &&
                  endIndex >= 0 &&
                  endIndex <= (widget.gridSize * widget.gridSize) - 1) {
                if (liens[startIndex][endIndex] == 0 &&
                    liens[endIndex][startIndex] == 0 &&
                    startIndex != endIndex) {
                  if ((startIndex - endIndex).abs() == 1 ||
                      (startIndex - endIndex).abs() == widget.gridSize) {
                    if (((startIndex + 1) % widget.gridSize == 0 &&
                        (startIndex - endIndex) == -1)) {
                    } else if (((startIndex + 1) % widget.gridSize == 1 &&
                        (startIndex - endIndex) == 1)) {
                    } else {
                      liens[startIndex][endIndex] = 1;
                      liens[endIndex][startIndex] = 1;
                      widget.grille.addTrait(Trait(
                          widget.grille.getListeCells().firstWhere((element) =>
                              element.getPosX() ==
                                  (startIndex % widget.gridSize) &&
                              element.getPosY() ==
                                  (startIndex ~/ widget.gridSize)),
                          widget.grille.getListeCells().firstWhere((element) =>
                              element.getPosX() ==
                                  (endIndex % widget.gridSize) &&
                              element.getPosY() ==
                                  (endIndex ~/ widget.gridSize))));
                      debugPrint('De case ${startIndex} à case ${endIndex}');
                      setState(() {});
                    }
                  }
                }
              }
            }
          },
          child: Container(
            height: 350,
            width: 350,
            child: Stack(children: [
              // Déplacez le Stack dans le GestureDetector
              Container(
                padding: const EdgeInsets.all(1.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0)),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.gridSize * widget.gridSize,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: widget.gridSize,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 1.0,
                    mainAxisSpacing: 1.0,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return Container(
                        decoration: const BoxDecoration(
                            color: Color(0xff373855),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0))),
                      );
                    } else if (index == widget.gridSize - 1) {
                      return Container(
                        decoration: const BoxDecoration(
                            color: Color(0xff373855),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10.0))),
                      );
                    } else if (index ==
                        widget.gridSize * (widget.gridSize - 1)) {
                      return Container(
                        decoration: const BoxDecoration(
                            color: Color(0xff373855),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10.0))),
                      );
                    } else if (index == widget.gridSize * widget.gridSize - 1) {
                      return Container(
                        decoration: const BoxDecoration(
                            color: Color(0xff373855),
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10.0))),
                      );
                    }

                    return Container(
                      decoration: const BoxDecoration(
                        color: Color(0xff373855),
                      ),
                    );
                  },
                ),
              ),
              CustomPaint(
                painter: LinePainter(liens, context, widget.gridSize),
                child: GestureDetector(
                  onTapUp: (details) {
                    for (int i = 0; i < liens.length; i++) {
                      for (int j = 0; j < liens[0].length; j++) {
                        if (liens[i][j] == 1) {
                          final lineStart = _getCenterPosition(i);
                          final lineEnd = _getCenterPosition(j);
                          final tapPosition = details.localPosition;
                          if (_isTapOnLine(lineStart, lineEnd, tapPosition) && !widget.solution) {
                            liens[i][j] = 0;
                            liens[j][i] = 0;
                            setState(() {});
                          }
                        }
                      }
                    }
                  },
                ),
              ),

              //Ajout des cercles
              ...cercles,
            ]),
     
        ),
        ),
        !widget.solution ? const SizedBox(height: 30, width: 350) : const SizedBox(),
        !widget.solution ? SizedBox(
          width: 350,
          child: Row(
            // TODO : les faire apparaitre que lorsque l'on joue pas dans la solution
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: [
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0x7F373855),
                ),
                child: IconButton(
                  onPressed: () => {
                    cluePopup(context),
                    // TOTEST
                  },
                  icon: const Icon(BootstrapIcons.lightbulb),
                  color: Colors.white,
                  iconSize: 25,
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0x7F373855),
                ),
                child: IconButton(
                  onPressed: () => {
                    // TOTEST
                    resetGame(),
                  },
                  icon: const Icon(Icons.undo),
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ) : const SizedBox(),
      ],
    );
    // );
  }
}

class LinePainter extends CustomPainter {
  final List<List<int>> liens;
  final int gridSize;
  BuildContext context;

  LinePainter(this.liens, this.context, this.gridSize);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xff3D4AEB)
      ..strokeWidth = 4;

    for (int i = 0; i < liens.length; i++) {
      for (int j = 0; j < liens[0].length; j++) {
        if (liens[i][j] == 1) {
          canvas.drawLine(_getCenterPosition(i, gridSize),
              _getCenterPosition(j, gridSize), paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  Offset _getCenterPosition(int index, int gridSize) {
    final cellSize =
        350 / gridSize; // La taille d'une case de la grille
    final row = (index / gridSize).floor(); // Le numéro de ligne de la case
    final col = index % gridSize; // Le numéro de colonne de la case
    final x = (col + 0.5) * cellSize; // La coordonnée x du centre de la case
    final y = (row + 0.5) * cellSize; // La coordonnée y du centre de la case
    return Offset(x, y); // Retourne l'offset du centre de la case
  }
}
