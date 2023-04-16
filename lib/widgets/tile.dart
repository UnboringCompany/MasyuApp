import 'package:flutter/material.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';


class Tile extends StatefulWidget {

  final String title;
  final Icon icon;
  final VoidCallback onPressed;

  const Tile({Key? key, required this.title, required this.icon, required this.onPressed}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TileState();
}

class _TileState extends State<Tile> {

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return 
    InkWell(
      onTap: widget.onPressed,
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      child: Container(
        width: size.width * 0.4, // 80% de la largeur de l'écran
        height: size.height * 0.25, // 40% de la hauteur de l'écran
        decoration: BoxDecoration(
          color: Color(0xB30C0813),
          borderRadius: BorderRadius.circular(10)
          ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            widget.icon,
            Text(widget.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700), textAlign: TextAlign.center,)
        ]),
      )
    );
    
    

  }


}