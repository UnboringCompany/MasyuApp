import 'main.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_volume_controller/flutter_volume_controller.dart';
import 'package:masyu_app/widgets/core.dart';
import 'package:masyu_app/widgets/tile.dart';

class Rule extends StatefulWidget {
  const Rule({super.key});

  @override
  State<Rule> createState() => _Rule();
}

class _Rule extends State<Rule> {
  void seeHomePage() {
    Navigator.pushReplacement<void, void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => const MenuPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CoreWidget(
        child: Center(
            child: Column(children: [
      const SizedBox(height: 30),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        IconButton(
            onPressed: seeHomePage,
            icon: Icon(
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
      const SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'asset/rule1.png',
            width: 181,
            height: 182.31,
          ),
          Image.asset(
            'asset/rule2.png',
            width: 181,
            height: 182.31,
          )
        ],
      ),
      const SizedBox(height: 20),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset(
          'asset/rule3.png',
          width: 181,
          height: 182.31,
        ),
        Image.asset(
          'asset/rule4.png',
          width: 181,
          height: 182.31,
        )
      ]),
      const SizedBox(height: 15),
      Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "But du jeu :",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  "Vous devez relier tous les points de la grille pour faire une boucle unique.\nVous ne pouvez passer qu’une fois dans chaque case.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 15),
                Text(
                  "Pion Blanc :",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  "Pour passer dans un pion blanc, vous devezavancer en ligne droite.\nVous devez tourner de 90° dans la case d’avant, celle d’après ou les deux.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 15),
                Text(
                  "Pion Noir :",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  "Pour passer dans pion noir, vous devez faire un angle de 90° dans la case qui contient le pion.\nVous ne devez surtout pas tourner dans les cases juste avant et juste après.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                  textAlign: TextAlign.left,
                ),
              ]))
    ])));
  }
}
