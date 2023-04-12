import 'package:flutter/material.dart';
import 'package:masyu_app/LocalString.dart';
import 'package:masyu_app/classement.dart';
import 'package:masyu_app/objects/grille.dart';
import 'package:masyu_app/objects/cell.dart';
import 'package:masyu_app/objects/trait.dart';
import 'package:flutter/services.dart';
import 'package:masyu_app/rule.dart';
import 'package:masyu_app/setings.dart';
import 'package:masyu_app/solution.dart';
import 'package:masyu_app/widgets/citation.dart';
import 'package:masyu_app/widgets/sizedropdown.dart';
import 'package:masyu_app/widgets/tile.dart';
import 'package:masyu_app/widgets/core.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:get/get.dart';
import 'package:masyu_app/video.dart';
import 'package:confetti/confetti.dart';
import 'package:masyu_app/widgets/tripletap.dart';

import 'game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return GetMaterialApp(
      translations: LocalString(),
      locale: Locale('fr', 'FR'),
      debugShowCheckedModeBanner: false,
      title: 'MASYU',
      initialRoute: '/',
      routes: {
        '/': (context) => const MenuPage(),
        '/game': (context) => GamePage(),
        '/solution': (context) => SolutionPage(),
        '/video': (context) => Video(),
        '/settings': (context) => Settings(),
        '/rules': (context) => Rule(),
        '/classement' : (context) => ClassementPage(),
      },
    );
  }
}

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MenuState();
}

class _MenuState extends State<MenuPage> {
  String _dropdownValue = '';
  late ConfettiController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ConfettiController(duration: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _controller.play();
  }

  void seeSettings() {
    Navigator.of(context).pushNamed('/settings');
  }

  void seeClassement() {
    Navigator.of(context).pushNamed('/classement');
  }


  void seeRules() {
    Navigator.of(context).pushNamed('/rules');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    String _selectedOption = '6x6';
    List<String> _options = ['6x6', '8x8', '10x10'];

    return CoreWidget(
        child: Stack(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 0.1 * MediaQuery.of(context).size.height),
              TripleTapButton(
                onPressed: _startAnimation,
                child: Text(
                  'title'.tr,
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 10,
                    fontSize: 0.10 * MediaQuery.of(context).size.width,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              CitationWidget(),
              SizedBox(height: 0.1 * MediaQuery.of(context).size.height),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Tile(
                    icon: Icon(
                      BootstrapIcons.play,
                      color: Color(0xff3D4AEB),
                      size: 0.15 * MediaQuery.of(context).size.width,
                    ),
                    title: 'resume'.tr,
                    onPressed: () {},
                  ),
                  Tile(
                    icon: Icon(
                      BootstrapIcons.watch,
                      color: Color(0xff3D4AEB),
                      size: 0.12 * MediaQuery.of(context).size.width,
                    ),
                    title: 'challenge'.tr,
                    onPressed: () {},
                  ),
                
                ],
              ),
              SizedBox(height: 0.1 * MediaQuery.of(context).size.height),
              Container(
                width: 0.85 * MediaQuery.of(context).size.width,
                height: 0.07 * MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Color(0xff3D4AEB),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      "/game",
                      arguments: {'type': 'new', 'size': _dropdownValue},
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    elevation: 0,
                  ),
                  child: Text('new_game'.tr),
                ),
              ),
              SizedBox(height: 0.015 * MediaQuery.of(context).size.height),
              GridSizeMenu(
                onChanged: (newValue) {
                  setState(() {
                    _dropdownValue = newValue;
                  });
                },
              ),
              SizedBox(height: 0.1 * MediaQuery.of(context).size.height),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 0.3 * MediaQuery.of(context).size.width,
                    height: 0.05 * MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: Color(0xffB15653),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ElevatedButton(
                      onPressed: seeRules,
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        elevation: 0,
                      ),
                      child: Text('rules'.tr),
                    ),
                  ),
                  SizedBox(width: 0.001 * MediaQuery.of(context).size.width),
                  Row(children: [
                    IconButton(
                    onPressed: seeClassement,
                    icon: Icon(
                      BootstrapIcons.trophy,
                      color: Colors.white,
                      size: 0.08 * MediaQuery.of(context).size.width,
                    ),
                  ),
                  SizedBox(width: 0.02 * MediaQuery.of(context).size.width),
                    IconButton(
                    onPressed: seeSettings,
                    icon: Icon(
                      BootstrapIcons.gear,
                      color: Colors.white,
                      size: 0.08 * MediaQuery.of(context).size.width,
                    ),
                  ),
                  ],)
                  
                ],
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _controller,
            blastDirectionality: BlastDirectionality.explosive,
            emissionFrequency: 0.05,
            numberOfParticles: 50,
            shouldLoop: false,
            colors: const [
              Colors.blue,
              Colors.purple,
              Colors.pink,
              Colors.green,
              Colors.yellow,
            ],
          ),
        )
      ],
    ));
  }
}
