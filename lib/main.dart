import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:masyu_app/LocalString.dart';
import 'package:masyu_app/appstate.dart';
import 'package:masyu_app/classement.dart';
import 'package:masyu_app/objects/grille.dart';
import 'package:masyu_app/objects/cell.dart';
import 'package:masyu_app/objects/trait.dart';
import 'package:flutter/services.dart';
import 'package:masyu_app/rule.dart';
import 'package:masyu_app/setings.dart' as setting;
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
import 'package:provider/provider.dart';

import 'game.dart';
import 'objects/partie.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => AppState(), child: const MyApp()),
  );
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
        '/settings': (context) => setting.Settings(),
        '/rules': (context) => Rule(),
        '/classement': (context) => ClassementPage(),
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
  String _titleSave = 'resume'.tr + '\n' + 'Aucune Sauvegarde';
  late ConfettiController _controller;
  Partie? _save = null;

  @override
  void initState() {
    super.initState();
    _controller = ConfettiController(duration: const Duration(seconds: 2));
    fetchSave();
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

  void losePopup(BuildContext context, int nbPoints) {
    nbPoints = -nbPoints;
    String points = nbPoints.toString();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('game_over'.tr,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white)),
          backgroundColor: Colors.transparent,
          content: Text('game_over_text'.trParams({'points': points}),
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white)),
          actions: <Widget>[
            Container(
                alignment: Alignment.bottomCenter,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0x7F373855),
                ),
                child: IconButton(
                  icon: const Icon(BootstrapIcons.x),
                  color: Colors.red,
                  onPressed: () {},
                )),
          ],
        );
      },
    );
  }

  void abandon2Popup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'abandon'.tr,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.transparent,
          content: Text(
              'game_over_text'
                  .trParams({'points': _save!.scorePartie.toString()}),
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white)),
          actions: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                  alignment: Alignment.bottomCenter,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0x7F373855),
                  ),
                  child: IconButton(
                    icon: const Icon(BootstrapIcons.check),
                    onPressed: () async {
                      String? id = await _getId();
                      await Firebase.initializeApp();
                      final docRef = FirebaseFirestore.instance
                          .collection('grilles')
                          .doc(id);
                      final docSnapshot = await docRef.get();
                      docRef
                          .delete()
                          .then((value) => print('Document supprimé'))
                          .catchError((error) => print(
                              'Erreur lors de la suppression du document : $error'));
                      setState(() {
                        _titleSave = 'resume'.tr + '\n' + 'Aucune Sauvegarde';
                      });
                      Navigator.pop(context);
                    },
                    color: Colors.white,
                  )),
              const SizedBox(width: 50),
              Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0x7F373855),
                  ),
                  child: IconButton(
                    icon: const Icon(BootstrapIcons.x),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: Colors.red,
                  ))
            ]),
          ],
        );
      },
    );
  }

  Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
      var data = await deviceInfoPlugin.iosInfo;
      var identifier = data.identifierForVendor;
      return identifier;
    } else if (Platform.isAndroid) {
      final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo;
      try {
        androidInfo = await deviceInfo.androidInfo;
        return androidInfo.id;
      } catch (e) {
        print('Error: $e');
      }
    }
    return null;
  }

  Future<Partie?> getSave() async {
    String? id = await _getId();
    await Firebase.initializeApp();
    final docRef = FirebaseFirestore.instance.collection('grilles').doc(id);
    final docSnapshot = await docRef.get();
    final data = docSnapshot.data();
    final joueurData = await FirebaseFirestore.instance
        .collection('utilisateur')
        .doc(id)
        .get();
    final joueur = joueurData.data();
    if (data != null && joueur != null) {
      return Partie.fromJson(data, joueur);
    }
    return null;
  }

  Future<void> fetchSave() async {
    final result = await getSave();
    setState(() {
      if (result != null) {
        _save = result;
        setState(() {
          _titleSave = 'resume'.tr +
              '\n' +
              _save!.grille.getSize().toString() +
              'x' +
              _save!.grille.getSize().toString() +
              ' - ' +
              _save!.chrono.toString();
        });
      } else {
        _save = null;
      }
    });
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
                      size: 0.20 * MediaQuery.of(context).size.width,
                    ),
                    title: _titleSave,
                    onPressed: () async {
                      Partie? partie = await getSave();
                      Navigator.pushNamed(context, '/game', arguments: {
                        'type': 'fromSave',
                        'size': partie!.grille.getSize(),
                        'partie': partie
                      });
                    },
                  ),
                  Tile(
                    icon: Icon(
                      BootstrapIcons.watch,
                      color: Color(0xff3D4AEB),
                      size: 0.16 * MediaQuery.of(context).size.width,
                    ),
                    title: 'challenge'.tr,
                    onPressed: () {},
                  )
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
                  onPressed: () async {
                    print('j ai cliqué');
                    String? id = await _getId();
                    await Firebase.initializeApp();
                    final docRef = FirebaseFirestore.instance
                        .collection('grilles')
                        .doc(id);
                    final docSnapshot = await docRef.get();
                    if (docSnapshot.exists) {
                      print('Le document existe');
                      abandon2Popup(context);
                    } else {
                      Navigator.pushNamed(
                        context,
                        "/game",
                        arguments: {'type': 'new', 'size': _dropdownValue},
                      );
                    }
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
                  Row(
                    children: [
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
                    ],
                  )
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
