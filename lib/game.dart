import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:masyu_app/objects/grille.dart';
import 'package:masyu_app/widgets/core.dart';
import 'package:masyu_app/widgets/grille.dart';
import 'package:masyu_app/widgets/stopwatch.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<StatefulWidget> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  

  @override
  Widget build(BuildContext context) {

    int _gridSize;
    Grille grille;

    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final type = args[
        'type']; //new si nouvelle partie, resume si partie chargée depuis une sauvegarde, defi si defi contre la montre
    final size = args['size'];

    if (size == "10x10") {
      _gridSize = 10;
    } else if (size == "8x8") {
      _gridSize = 8;
    } else {
      _gridSize = 6;
    }

    grille = Grille(_gridSize);
    grille.generate();

    return (CoreWidget(
        child: Center(
            child: Column(children: [
      const SizedBox(height: 100),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Enregistrer ou abandonner'),
                    content: Text('Si vous abandonnez la partie vous perdrez x points'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Abandonner'),
                        onPressed: () {
                          Navigator.of(context).pushNamed('/');
                          // TODO: Gérer la perte de points
                        },
                      ),
                      TextButton(
                        child: Text('Sauvegarder'),
                        onPressed: () {
                          // faire quelque chose ici
                           Navigator.of(context).pushNamed('/');
                           //TODO: Gérer la sauvegarde
                        },
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(
              BootstrapIcons.arrow_left,
              color: Colors.white,
              size: 25,
            )),
        const SizedBox(width: 15),
        const Text("MASYU",
            style: TextStyle(
                color: Colors.white,
                letterSpacing: 10,
                fontSize: 40,
                fontWeight: FontWeight.w600))
      ]),
      const SizedBox(height: 30),
      StopWatchWidget(),
      const SizedBox(height: 30),
      GrilleWidget(gridSize: _gridSize, grille: grille, solution: false,),
      const SizedBox(height: 40),
      Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0x7F373855),
          ),
          child: IconButton(
            onPressed: () => {},
            icon: const Icon(BootstrapIcons.lightbulb),
            color: Colors.white,
          )),
      const SizedBox(
        height: 40,
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0x7F373855),
              ),
              child: IconButton(
                onPressed: () => {},
                icon: const Icon(BootstrapIcons.cloud_upload),
                color: Colors.white,
              )),
          Container(
              width: 70.0,
              height: 70.0,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0x7F373855),
              ),
              child: IconButton(
                onPressed: () => {},
                icon: const Icon(BootstrapIcons.check2),
                color: Colors.white,
                iconSize: 30,
              )),
          Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0x7F373855),
              ),
              child: IconButton(
                onPressed: () => {
                    Navigator.pushNamed(context, '/solution', arguments: {'grille': grille})
                },
                icon: const Icon(BootstrapIcons.x),
                color: Colors.red,
              )),
        ],
      )
    ]))));
  }
}
