import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:masyu_app/widgets/core.dart';
import 'package:masyu_app/widgets/tile.dart';
import 'main.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _Settings();
}

class _Settings extends State<Settings> {
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
    final size = MediaQuery.of(context).size;
    String _selectedOption = 'Option 1';
    List<String> _options = ['Option 1', 'Option 2', 'Option 3'];

    return CoreWidget(
        child: Center(
      child: Column(
        children: [
          const SizedBox(height: 100),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            IconButton(
                onPressed: seeHomePage,
                icon: Icon(
                  BootstrapIcons.arrow_left,
                  color: Colors.white,
                  size: 25,
                )),
            const Text("MASYU",
                style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 10,
                    fontSize: 40,
                    fontWeight: FontWeight.w600))
          ]),
          const SizedBox(height: 80),
          const SizedBox(height: 15),
          const SizedBox(height: 70),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Crédits :\n\nProjet Réalisé par :\nUnboring Company\n\nUne équipe composée de :\nLéo WADIN\nAurélien HOUDART\nDamien COLLOT\nElena BEYLAT",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              )
            ],
          )
        ],
      ),
    ));
  }
}
