import 'package:flutter/material.dart';

class CircleWidget extends StatefulWidget {

  final Offset position;
  final String couleur;
  final int size;
  const CircleWidget({super.key, required this.position, required this.couleur, required this.size});

  @override
  State<StatefulWidget> createState() => _CircleWidgetState();
}

class _CircleWidgetState extends State<CircleWidget> {

  @override
  Widget build(BuildContext context) {
    return(
      Positioned(
      left: widget.position.dx - (20  - widget.size),
      top: widget.position.dy - (20  - widget.size),
      child: Container(
        width: (20  - widget.size) * 2,
        height: (20 - widget.size) * 2,
        decoration: 
        BoxDecoration(
          color: widget.couleur == "noir" ? Color(0xff3D4AEB) : Color(0xff373855),
          shape: BoxShape.circle,
          border:  widget.couleur == "noir" ? Border.all(color: Color(0xff3D4AEB)) : Border.all(color: Colors.white, width: 3)
        ),
      ),
    )
    );

  }


}