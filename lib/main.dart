import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:masyu_app/widgets/citation.dart';
import 'package:masyu_app/widgets/tile.dart';
import 'package:masyu_app/widgets/core.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MASYU',
      initialRoute: '/',
      routes: {
        '/': (context) => const MenuPage(),
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

  @override
  Widget build(BuildContext context) {
    return CoreWidget(
      child: Center(child : Column(
        children: [
          const SizedBox(height: 100),
          const Text("MASYU", style: TextStyle(color: Colors.white, letterSpacing: 10, fontSize: 40, fontWeight: FontWeight.w600)),
          CitationWidget(),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Tile(icon: Icon(BootstrapIcons.play, color: Color(0xff3D4AEB), size: 100,), title: "Reprendre\n6x6 - 1min37"),
              Tile(icon: Icon(BootstrapIcons.watch, color: Color(0xff3D4AEB), size: 80), title: "Défi\nContre la montre")
          ]),
          
        ],
      ),
    ));
  }

}




