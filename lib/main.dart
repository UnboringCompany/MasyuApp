import 'package:flutter/material.dart';
import 'package:masyu_app/LocalString.dart';
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

  void seeSettings() {
    Navigator.pushReplacement<void, void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => const Settings(),
      ),
    );
  }

  void seeRules() {
    Navigator.pushReplacement<void, void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => const Rule(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    String _selectedOption = '6x6';
    List<String> _options = ['6x6', '8x8', '10x10'];

    return CoreWidget(
        child: Center(
      child: Column(
        children: [
          const SizedBox(height: 100),
          Text('title'.tr,
              style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 10,
                  fontSize: 40,
                  fontWeight: FontWeight.w600)),
          CitationWidget(),
          const SizedBox(height: 80),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Tile(
                icon: Icon(
                  BootstrapIcons.play,
                  color: Color(0xff3D4AEB),
                  size: 100,
                ),
                title: 'resume'.tr),
            Tile(
                icon: Icon(BootstrapIcons.watch,
                    color: Color(0xff3D4AEB), size: 80),
                title: 'challenge'.tr)
          ]),
          const SizedBox(height: 80),
          Container(
            width: 0.85 * size.width,
            height: 60,
            decoration: BoxDecoration(
                color: Color(0xff3D4AEB),
                borderRadius: BorderRadius.circular(10)),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/game", arguments: {'type': 'new', 'size': _dropdownValue});
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  elevation: 0,
                ),
                child: Text('new_game'.tr)),
          ),
          const SizedBox(height: 15),
          GridSizeMenu(
            onChanged: (newValue) {
              setState(() {
                _dropdownValue = newValue;
              });
            },),
          const SizedBox(height: 70),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 0.3 * size.width,
                height: 40,
                decoration: BoxDecoration(
                    color: Color(0xffB15653),
                    borderRadius: BorderRadius.circular(10)),
                child: ElevatedButton(
                    onPressed: seeRules,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      elevation: 0,
                    ),
                    child: Text('rules'.tr)),
              ),
              SizedBox(width: 0.01 * size.width),
              IconButton(
                  onPressed: seeSettings,
                  icon: const Icon(
                    BootstrapIcons.gear,
                    color: Colors.white,
                  ))
            ],
          )
        ],
      ),
    ));
  }
}
