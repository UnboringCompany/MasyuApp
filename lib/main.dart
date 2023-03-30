import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:masyu_app/objects/grille.dart';
import 'widgets/core.dart';



void main() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MASYU',
      home: MenuPage(),
    );

  }
}

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {

  Grille grille = Grille(6);

  void _incrementCounter() {
    setState(() {
      grille.printGrid();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CoreWidget( child: Text("MASYU"),);
  }
}
