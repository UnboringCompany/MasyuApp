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
            GrilleWidget(gridSize: 10),
          ]
          )
        )
      )
    );
  }


}