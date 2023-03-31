import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class GrilleWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GrilleWidgetState();
}

class _GrilleWidgetState extends State<GrilleWidget> {
  late List<Widget> _gridWidgets;
  List<List<int>> liens =
      List.generate(6 * 6, (_) => List<int>.filled(6 * 6, 0));

  _GrilleWidgetState() {
    _gridWidgets = List.generate(
        6 * 6,
        (index) => Container(
              color: Colors.grey[200],
              child: Center(
                child: Text(
                  '${index}',
                  textAlign: TextAlign.center,
                ),
              ),
            ));
  }

  void _updateGridWidget(int index, Widget newWidget) {
    setState(() {
      _gridWidgets[index] = newWidget;
    });
  }

  int _calculateIndex(Offset offset) {
    final double width = context.size!.width / 6;
    final int column = (offset.dx / width).floor();
    final int row = (offset.dy / width).floor();
    return row * 6 + column;
  }

  bool _isTapOnLine(Offset lineStart, Offset lineEnd, Offset tapPosition) {
    final threshold =10; // Une tolérance pour tenir compte de la taille de l'écran et de la largeur de la ligne
    final distanceFromStart = (tapPosition - lineStart).distance;
    final distanceFromEnd = (tapPosition - lineEnd).distance;
    final lineLength = (lineEnd - lineStart).distance;
    return distanceFromStart + distanceFromEnd >= lineLength - threshold &&
        distanceFromStart + distanceFromEnd <= lineLength + threshold;
  }

  Offset _getCenterPosition(int index) {
    final RenderBox gridBox = context.findRenderObject() as RenderBox;
    final cellSize = gridBox.size.width / 6; // La taille d'une case de la grille
    final row = (index / 6).floor(); // Le numéro de ligne de la case
    final col = index % 6; // Le numéro de colonne de la case
    final x = (col + 0.5) * cellSize; // La coordonnée x du centre de la case
    final y = (row + 0.5) * cellSize; // La coordonnée y du centre de la case
    return Offset(x, y); // Retourne l'offset du centre de la case
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

        final startIndex = ((startPos.dx / gridBox.size.width) * 6).floor() +
            (((startPos.dy / gridBox.size.height) * 6).floor() * 6);
        final endIndex = ((endPos.dx / gridBox.size.width) * 6).floor() +
            (((endPos.dy / gridBox.size.height) * 6).floor() * 6);

        if (startIndex >= 0 &&
            startIndex <= 35 &&
            endIndex >= 0 &&
            endIndex <= 35) {
          if (liens[startIndex][endIndex] == 0 &&
              liens[endIndex][startIndex] == 0 &&
              startIndex != endIndex) {
            if ((startIndex - endIndex).abs() == 1 ||
                (startIndex - endIndex).abs() == 6) {
              if (((startIndex + 1) % 6 == 0 &&
                  (startIndex - endIndex) == -1)) {
                print('hit !');
              } else if (((startIndex + 1) % 6 == 1 &&
                  (startIndex - endIndex) == 1)) {
                print('hit2 !');
              } else {
                liens[startIndex][endIndex] = 1;
                liens[endIndex][startIndex] = 1;
                print('De case ${startIndex} à case ${endIndex}');
                setState(() {});
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
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 6 * 6,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6,
              childAspectRatio: 1.0,
              crossAxisSpacing: 1.0,
              mainAxisSpacing: 1.0,
            ),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () => _updateGridWidget(
                    index, Icon(Icons.favorite, color: Colors.red)),
                child: _gridWidgets[index],
              );
            },
          ),
         
          CustomPaint(
              painter: LinePainter(liens, context),
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
        ]),
      ),
    ));
  }
}

class LinePainter extends CustomPainter {
  final List<List<int>> liens;
  BuildContext context;

  LinePainter(this.liens, this.context);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 5;

    for (int i = 0; i < liens.length; i++) {
      for (int j = 0; j < liens[0].length; j++) {
        if (liens[i][j] == 1) {
          canvas.drawLine(_getCenterPosition(i), _getCenterPosition(j), paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  Offset _getCenterPosition(int index) {
    final RenderBox gridBox = context.findRenderObject() as RenderBox;
    final cellSize =
        gridBox.size.width / 6; // La taille d'une case de la grille
    final row = (index / 6).floor(); // Le numéro de ligne de la case
    final col = index % 6; // Le numéro de colonne de la case
    final x = (col + 0.5) * cellSize; // La coordonnée x du centre de la case
    final y = (row + 0.5) * cellSize; // La coordonnée y du centre de la case
    return Offset(x, y); // Retourne l'offset du centre de la case
  }
}
