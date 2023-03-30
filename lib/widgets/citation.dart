import 'dart:math';

import 'package:flutter/material.dart';

class CitationWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CitationWidgetState();
}

class _CitationWidgetState extends State<CitationWidget> {

  String citation = 'Citation par défaut';

  @override
  void initState() {
    super.initState();
    //TODO: Lier le nombre aléatoire aux citations
    citation = Random().nextInt(100).toString();
  }

  @override
  Widget build(BuildContext context) {
    return(
      Text(citation, style: const TextStyle(color: Colors.yellow, fontStyle: FontStyle.italic, fontSize: 15))
    );

  }


}