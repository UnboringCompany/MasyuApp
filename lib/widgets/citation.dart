import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CitationWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CitationWidgetState();
}

class _CitationWidgetState extends State<CitationWidget> {


  Future<String> lireFichier() async {
    String contenuFichier = await rootBundle.loadString('asset/Citation.txt');
    List<String> lignes = contenuFichier.split('\n');
    return lignes[Random().nextInt(lignes.length)];
  }


  String citation = 'Citation par défaut';

  @override
  initState() {
    super.initState();
    Future.microtask(() async {
      String contenuFichier = await rootBundle.loadString('asset/Citation.txt');
      List<String> lignes = contenuFichier.split('\n');

      setState(() {
              citation = lignes[Random().nextInt(lignes.length)];
      });
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return(
      Text(citation, style: const TextStyle(color: Colors.yellow, fontStyle: FontStyle.italic, fontSize: 15), textAlign: TextAlign.center)
    );

  }


}