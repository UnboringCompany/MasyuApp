import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_volume_controller/flutter_volume_controller.dart';
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
  void seeHomePage() {
    Navigator.of(context).pushNamed('/');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return CoreWidget(
        child: Center(
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
    ])));
  }
}
