import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:masyu_app/objects/cell.dart';
import 'package:masyu_app/objects/cercle.dart';
import 'package:masyu_app/objects/grille.dart';
import 'package:masyu_app/objects/trait.dart';
import 'package:masyu_app/widgets/circle.dart';

class GrilleWidget extends StatefulWidget {

  final int gridSize;
  final Grille grille;
  final bool solution;
  const GrilleWidget({super.key, required this.gridSize, required this.grille, required this.solution});

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
    return row * 6 + column;
  }

  bool _isTapOnLine(Offset lineStart, Offset lineEnd, Offset tapPosition) {
    const threshold = 10; // Une tolérance pour tenir compte de la taille de l'écran et de la largeur de la ligne
    final distanceFromStart = (tapPosition - lineStart).distance;
    final distanceFromEnd = (tapPosition - lineEnd).distance;
    final lineLength = (lineEnd - lineStart).distance;
    return distanceFromStart + distanceFromEnd >= lineLength - threshold &&
        distanceFromStart + distanceFromEnd <= lineLength + threshold;
  }

  Offset _getCenterPosition(int index) {
    final RenderBox gridBox = context.findRenderObject() as RenderBox;
    final cellSize = gridBox.size.width / widget.gridSize; // La taille d'une case de la grille
    final row = (index / 6).floor(); // Le numéro de ligne de la case
    final col = index % 6; // Le numéro de colonne de la case
    final x = (col + 0.5) * cellSize; // La coordonnée x du centre de la case
    final y = (row + 0.5) * cellSize; // La coordonnée y du centre de la case
    return Offset(x, y); // Retourne l'offset du centre de la case
}

 @override
  void initState() {
    super.initState();
    liens =  List.generate(widget.gridSize * widget.gridSize, (_) => List<int>.filled(widget.gridSize * widget.gridSize, 0));

    SchedulerBinding.instance.addPostFrameCallback((_) {

      for(Cell cell in widget.grille.getListeCells()) {
        if(cell is Cercle) {
          cercles.add(
            CircleWidget(position: _getCenterPosition(cell.getPosX() + cell.getPosY()*widget.gridSize), couleur: cell.getColor() == 1 ? "blanc" : "noir", size: widget.gridSize),
          );
        }
      }

      if(widget.solution) {
        //TODO: Ajouter le traçage des traits de solution
        for(Trait t in widget.grille.getListeTraitsSolution()) {
                liens[t.getCaseDep().getPosX() + t.getCaseDep().getPosY() * widget.gridSize][t.getCaseArr().getPosX() + t.getCaseArr().getPosY() * widget.gridSize] = 1;
                liens[t.getCaseArr().getPosX() + t.getCaseArr().getPosY() * widget.gridSize][t.getCaseDep().getPosX() + t.getCaseDep().getPosY() * widget.gridSize] = 1;
        }
      }

    setState((){}); // Force la mise à jour de l'affichage
  });
  }

  @override
  Widget build(BuildContext context) {
    return (GestureDetector(
      // Nouveau GestureDetector
      onPanUpdate: (details) {
        final RenderBox gridBox = context.findRenderObject() as RenderBox;
        final startPos = gridBox.globalToLocal(details.globalPosition);
        final endPos =
            gridBox.globalToLocal(details.globalPosition + details.delta);

        final startIndex = ((startPos.dx / gridBox.size.width) * widget.gridSize).floor() +
            (((startPos.dy / gridBox.size.height) * widget.gridSize).floor() * widget.gridSize);
        final endIndex = ((endPos.dx / gridBox.size.width) * widget.gridSize).floor() +
            (((endPos.dy / gridBox.size.height) * widget.gridSize).floor() * widget.gridSize);

        if(!widget.solution) {
          if (startIndex >= 0 &&
            startIndex <= (widget.gridSize*widget.gridSize) - 1 &&
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
                // TODO: Ajouter le calcul des coordonnées de cases
                widget.grille.addTrait(Trait(widget.grille.getListeCells().firstWhere((element) => element.getPosX() == 1 && element.getPosY() == 0), widget.grille.getListeCells().firstWhere((element) => element.getPosX() == 1 && element.getPosY() == 0)));
                print('De case ${startIndex} à case ${endIndex}');
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
            padding: EdgeInsets.all(1.0),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
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

                if(index == 0) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Color(0xff373855),
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0))
                    ),
                  );
                } else if(index == widget.gridSize-1) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Color(0xff373855),
                      borderRadius: BorderRadius.only(topRight: Radius.circular(10.0))
                    ),
                  );
                } else if(index == widget.gridSize*(widget.gridSize-1)) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Color(0xff373855),
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.0))
                    ),
                  );
                } else if(index == widget.gridSize*widget.gridSize - 1) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Color(0xff373855),
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(10.0))
                    ),
                  );
                }

                return Container(
                  decoration: const BoxDecoration(
                    color: Color(0xff373855),
                  ),
                );
              },
            ) ,
          ),
          CustomPaint(
              painter: LinePainter(liens, context, widget.gridSize),
              child:  GestureDetector(
            onTapDown: (details) {
              for (int i = 0; i < liens.length; i++) {
                for (int j = 0; j < liens[0].length; j++) {
                  if (liens[i][j] == 1) {
                    final lineStart = _getCenterPosition(i);
                    final lineEnd = _getCenterPosition(j);
                    final tapPosition = details.localPosition;
                    if (_isTapOnLine(lineStart, lineEnd, tapPosition)) {
                      liens[i][j] = 0;
                      liens[j][i] = 0;
                      setState(() {
                        
                      });
                    }
                  }
                }
              }
            },),
            ),

            //Ajout des cercles
            ...cercles,          


        ]),
      ),
    ));
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
          canvas.drawLine(_getCenterPosition(i, gridSize), _getCenterPosition(j, gridSize), paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  Offset _getCenterPosition(int index, int gridSize) {
    final RenderBox gridBox = context.findRenderObject() as RenderBox;
    final cellSize =
        gridBox.size.width / gridSize; // La taille d'une case de la grille
    final row = (index / gridSize).floor(); // Le numéro de ligne de la case
    final col = index % gridSize; // Le numéro de colonne de la case
    final x = (col + 0.5) * cellSize; // La coordonnée x du centre de la case
    final y = (row + 0.5) * cellSize; // La coordonnée y du centre de la case
    return Offset(x, y); // Retourne l'offset du centre de la case
  }
}
