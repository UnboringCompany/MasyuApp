import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:masyu_app/objects/grille.dart';
import 'package:masyu_app/widgets/core.dart';
import 'package:masyu_app/widgets/grille.dart';
import 'package:masyu_app/widgets/stopwatch.dart';

class SolutionPage extends StatefulWidget {
  const SolutionPage({super.key});

  @override
  State<StatefulWidget> createState() => _SolutionPageState();
}

class _SolutionPageState extends State<SolutionPage> {
  

  @override
  Widget build(BuildContext context) {

    int _gridSize;
  
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final Grille grille = args['grille'];


    return (CoreWidget(
        child: Center(
            child: Column(children: [
      const SizedBox(height: 100),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/');
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
      const SizedBox(height: 90),
      GrilleWidget(gridSize: grille.getSize(), grille: grille, solution: true),
      const SizedBox(height: 40),
      Container(
          width: 70.0,
          height: 70.0,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0x7F373855),
          ),
          child: IconButton(
            onPressed: () => {
              Navigator.pushNamed(context, '/')
            },
            icon: const Icon(BootstrapIcons.house),
            color: Colors.white,
            iconSize: 30,
          )),
    ]))));
  }
}
