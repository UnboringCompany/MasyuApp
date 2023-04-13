//import 'dart:html';
import 'dart:io';

import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_volume_controller/flutter_volume_controller.dart';
import 'package:masyu_app/objects/joueur.dart';
import 'package:masyu_app/widgets/core.dart';
import 'package:masyu_app/widgets/tile.dart';
import 'main.dart';
import 'LocalString.dart';
import 'package:get/get.dart';

class ClassementPage extends StatefulWidget {
  const ClassementPage({super.key});

  @override
  State<ClassementPage> createState() => _ClassementPageState();
}

class _ClassementPageState extends State<ClassementPage> {
  Joueur player = Joueur('unknown', 0, 0, 0);
  bool _initialized = false;

  @override
  void initState() {
    initializeFlutterFire();
    _getPlayer();
    super.initState();
  }

  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
    }
  }

  void seeHomePage() {
    Navigator.of(context).pushNamed('/');
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

  Future<void> _getPlayer() async {
    String? id = await _getId();
    await Firebase.initializeApp();
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await FirebaseFirestore.instance
            .collection('utilisateur')
            .doc(id)
            .get();
    setState(() {
      player = Joueur.fromJson(documentSnapshot.data());
    });
  }

  @override
  Widget build(BuildContext context) {
    return CoreWidget(
        child: Column(children: [
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
      const SizedBox(height: 50),
      Expanded(
          child: SingleChildScrollView(
              child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              BootstrapIcons.person,
                              size: 30,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              player.getPseudo(),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(
                              BootstrapIcons.trophy,
                              size: 30,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              player.getScore().toString(),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(
                              BootstrapIcons.check,
                              size: 35,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              player.getPartieGagne().toString(),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(
                              BootstrapIcons.x,
                              size: 35,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              player.getPartiePerdue().toString(),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            )
                          ],
                        ),
                      ])))),
      const Text('Classement',
          style: TextStyle(color: Colors.white, fontSize: 25)),
      const SizedBox(height: 20),
      _initialized
          ? Expanded(
              child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('utilisateur')
                  .orderBy('score', descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView(
                  children: snapshot.data!.docs.map((document) {
                    return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        width: MediaQuery.of(context).size.width / 1.2,
                        height: MediaQuery.of(context).size.height / 20,
                        child: Row(
                          children: [
                            const Icon(
                              BootstrapIcons.person,
                              size: 30,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 10),
                            Text(document["pseudo"],
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20)),
                            const SizedBox(width: 10),
                            Text(document["score"].toString(),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20)),
                          ],
                        ));
                  }).toList(),
                );
              },
            ))
          : const Text("Database error"),
    ]));
  }
}
