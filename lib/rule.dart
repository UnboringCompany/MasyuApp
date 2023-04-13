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
    Navigator.of(context).pushNamed('/');
  }

  List<String> images = [
    "assets/Tuto/Jeu.png",
    "assets/Tuto/Jeu1.png",
    "assets/Tuto/Jeu2.png",
    "assets/Tuto/Jeu3.png",
    "assets/Tuto/Jeu4.png",
    "assets/Tuto/Jeu5.png",
    "assets/Tuto/Jeu6.png",
    "assets/Tuto/Jeu7.png",
    "assets/Tuto/Jeu8.png",
    "assets/Tuto/Jeu9.png",
    "assets/Tuto/Jeu10.png",
  ];

  void buildImageList(List<String> images) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CoreWidget(
          child: Container(
            child: Stack(
              children: [
                ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: images.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(images[index]),
                        ),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        Navigator.pop(context, "/game");
                      });
                    },
                    backgroundColor: Color(0x7F373855),
                    child: const Icon(BootstrapIcons.x),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CoreWidget(
      child: Column(
        children: [
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: seeHomePage,
                icon: const Icon(
                  BootstrapIcons.arrow_left,
                  color: Colors.white,
                  size: 25,
                ),
              ),
              const SizedBox(width: 15),
              const Text(
                "MASYU",
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 10,
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Image.asset(
                      'assets/images/rule1.png',
                      width: double.infinity,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Image.asset(
                      'assets/images/rule2.png',
                      width: double.infinity,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Image.asset(
                      'assets/images/rule3.png',
                      width: double.infinity,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Image.asset(
                      'assets/images/rule4.png',
                      width: double.infinity,
                    ),
                  ),
                ],
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              buildImageList(images);
            },
            child: Text('Tutoriel'),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    Text(
                      "goal".tr,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "goal_text".tr,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "white".tr,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "white_text".tr,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "black".tr,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "black_text".tr,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
