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
import 'package:masyu_app/video.dart';

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
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 0.1 * MediaQuery.of(context).size.height),
        Text(
          'title'.tr,
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 10,
            fontSize: 0.10 * MediaQuery.of(context).size.width,
            fontWeight: FontWeight.w600,
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
            ),
            Tile(
              icon: Icon(
                BootstrapIcons.watch,
                color: Color(0xff3D4AEB),
                size: 0.12 * MediaQuery.of(context).size.width,
              ),
              title: 'challenge'.tr,
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
            SizedBox(width: 0.01 * MediaQuery.of(context).size.width),
            IconButton(
              onPressed: seeSettings,
              icon: Icon(
                BootstrapIcons.gear,
                color: Colors.white,
                size: 0.08 * MediaQuery.of(context).size.width,
              ),
            ),
          ],
        ),
      ],
    ),
  ),
);

  }
}
