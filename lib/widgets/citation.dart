import 'package:flutter/material.dart';

class CitationWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CitationWidgetState();
}

class _CitationWidgetState extends State<CitationWidget> {
  @override
  Widget build(BuildContext context) {
    return(
      Text("Toujours pas compris les règles", style: TextStyle(color: Colors.yellow),)
    );

  }


}