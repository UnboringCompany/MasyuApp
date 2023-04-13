import 'dart:io';

import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_volume_controller/flutter_volume_controller.dart';
import 'package:masyu_app/appstate.dart';
import 'package:masyu_app/widgets/core.dart';
import 'package:masyu_app/widgets/tile.dart';
import 'main.dart';
import 'LocalString.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _Settings();
}

class _Settings extends State<Settings> {
  bool? sound = true;
  bool vibrate = true;
  String _selectedOption = 'Français';
  List<String> _options = ['English', 'Deutch', 'Français', 'Español', '日本'];
  String pseudo = "";
  bool newJoueur = true;

  @override
  void initState() {
    _getPseudo();
    super.initState();
    getLocal();
  }

  Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
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

  Future<void> _getPseudo() async {
    String? id = await _getId();
    await Firebase.initializeApp();
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await FirebaseFirestore.instance
            .collection('utilisateur')
            .doc(id)
            .get();
    if (documentSnapshot.exists) {
      setState(() {
        pseudo = documentSnapshot.data()?['pseudo'];
        if (pseudo != "") {
          newJoueur = false;
        }
      });
    }
  }

  void getLocal() {
    String lang = 'Français';
    Locale? actual = Get.locale;
    for (var lang in locale) {
      if (lang['locale'] == actual) {
        setState(() {
          _selectedOption = lang['name'];
        });
        return;
      }
    }
    setState(() {
      _selectedOption = lang;
    });
  }

  void seeHomePage() {
    Navigator.of(context).pushNamed('/');
  }

  final List locale = [
    {'name': 'Français', 'locale': const Locale('fr', 'FR')},
    {'name': 'English', 'locale': const Locale('en', 'US')},
    {'name': 'Deutch', 'locale': const Locale('de', 'DE')},
    {'name': 'Español', 'locale': const Locale('es', 'ES')},
    {'name': '日本', 'locale': const Locale('ja', 'JP')},
  ];

  updatelanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final appState = Provider.of<AppState>(context);

    return CoreWidget(
        child: Center(
      child: Column(
        children: [
          const SizedBox(height: 100),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            IconButton(
                onPressed: seeHomePage,
                icon: const Icon(
                  BootstrapIcons.arrow_left,
                  color: Colors.white,
                  size: 25,
                )),
            const SizedBox(width: 15),
            Text('title'.tr,
                style: const TextStyle(
                    color: Colors.white,
                    letterSpacing: 10,
                    fontSize: 40,
                    fontWeight: FontWeight.w600))
          ]),
          const SizedBox(height: 80),
          Expanded(
            child: SingleChildScrollView(
                child: Column(
              children: [
                Container(
                  width: 125,
                  height: 48,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(50, 217, 217, 217),
                      border: Border.all(
                        color: const Color.fromARGB(50, 217, 217, 217),
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        BootstrapIcons.volume_up_fill,
                        color: Colors.white,
                        size: 30,
                      ),
                      const SizedBox(width: 15),
                      Switch(
                        value: appState.isSoundEnabled,
                        onChanged: (bool value) {
                          setState(() {
                            appState.isSoundEnabled = value;
                          });
                        },
                        activeColor: Colors.white,
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  width: 125,
                  height: 48,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(50, 217, 217, 217),
                      border: Border.all(
                        color: const Color.fromARGB(50, 217, 217, 217),
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        BootstrapIcons.phone_vibrate,
                        color: Colors.white,
                        size: 30,
                      ),
                      const SizedBox(width: 15),
                      Switch(
                        value: appState.isVibrationEnabled,
                        onChanged: (bool value) {
                          // This is called when the user toggles the switch.
                          setState(() {
                            appState.isVibrationEnabled = value;
                          });
                        },
                        activeColor: Colors.white,
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                    width: 200,
                    child: TextField(
                      decoration: InputDecoration(
                        icon: const Icon(Icons.person),
                        iconColor: Colors.white,
                        fillColor: Colors.white,
                        labelText: pseudo,
                        labelStyle: TextStyle(color: Colors.white),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2.0),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                      style: TextStyle(color: Colors.white),
                      onChanged: (value) async {
                        pseudo = value;
                      },
                    )),
                ElevatedButton(
                  onPressed: () async {
                    if (pseudo != "") {
                      String? id = await _getId();
                      await Firebase.initializeApp();
                      if (newJoueur) {
                        await FirebaseFirestore.instance
                            .collection('utilisateur')
                            .doc(id)
                            .set({
                          'pseudo': pseudo,
                          'partieGagne': 0,
                          'partiePerdu': 0,
                          'score': 0
                        });
                      } else {
                        await FirebaseFirestore.instance
                            .collection('utilisateur')
                            .doc(id)
                            .update({'pseudo': pseudo});
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                                Text('Changement du nom fait avec succés')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Mettre un pseudo complet')),
                      );
                    }
                  },
                  child: const Text('Submit'),
                ),
                const SizedBox(height: 30),
                Container(
                  width: 220,
                  height: 49,
                  decoration: BoxDecoration(
                    color: const Color(0xff373855),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Theme(
                      data: ThemeData(
                        canvasColor: const Color(0xff373855),
                      ),
                      child: DropdownButton<String>(
                        underline: const SizedBox(),
                        value: _selectedOption,
                        iconEnabledColor: Colors.white,
                        style: const TextStyle(color: Colors.white),
                        onChanged: (String? value) {
                          setState(() {
                            _selectedOption = value!;
                            updatelanguage(locale[locale.indexWhere((element) =>
                                element['name'] == _selectedOption)]['locale']);
                          });
                        },
                        items: _options.map((String option) {
                          return DropdownMenuItem<String>(
                            value: option,
                            child: SizedBox(
                              width: 220 - 24,
                              child: Text(
                                option,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'credits'.tr + '\n' + 'team'.tr,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                )
              ],
            )),
          )
        ],
      ),
    ));
  }
}
