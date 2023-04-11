import 'package:flutter/material.dart';
import 'package:masyu_app/widgets/core.dart';
import 'package:masyu_app/widgets/grille.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<StatefulWidget> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {

  @override
  Widget build(BuildContext context) {

    int _gridSize;

    final Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final type = args['type']; //new si nouvelle partie, resume si partie chargée depuis une sauvegarde
    final size = args['size'];

    if(size == "6x6") {
      _gridSize = 6;
    } else if(size == "8x8") {
      _gridSize = 8;
    } else {
      _gridSize = 10;
    }

    return(
      CoreWidget(
        child: Center(
          child: Column(
          children: [
            const SizedBox(height: 100),
            const Text("MASYU",
                style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 10,
                    fontSize: 40,
                    fontWeight: FontWeight.w600
              )
            ),
            const SizedBox(height: 80),
            GrilleWidget(gridSize: _gridSize),
          ]
          )
        )
      )
    );
  }


}