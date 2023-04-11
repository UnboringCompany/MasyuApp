import 'main.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_volume_controller/flutter_volume_controller.dart';
import 'package:masyu_app/widgets/core.dart';
import 'package:masyu_app/widgets/tile.dart';
import 'LocalString.dart';
import 'package:get/get.dart';

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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "goal".tr,
              textAlign: TextAlign.left,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              "goal_text".tr,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 15),
            Text(
              "white".tr,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              "white_text".tr,
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 15),
            Text(
              "black".tr,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              "black_text".tr,
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
