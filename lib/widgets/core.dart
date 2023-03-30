import 'package:flutter/material.dart';

class CoreWidget extends StatefulWidget {

  final Widget child;

  const CoreWidget({Key? key, required this.child}) : super(key: key);
  
  @override
  State<StatefulWidget> createState() => _CoreWidgetState();

}

class _CoreWidgetState extends State<CoreWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: RadialGradient(
          colors: [Color(0x663d4aeb), Color(0x000c0813)],
          center: Alignment.topLeft,
          radius: 2,)
        ),
      child:
        Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
            colors: [Color(0x663d4aeb), Color(0x000c0813)],
            center: Alignment.bottomRight,
            radius: 2.3,)
          ),
          child: Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
              colors: [Color(0x253d4aeb), Colors.transparent],
              center: Alignment.center,
              radius: 1,)
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: widget.child,
            ),
        )
        )
    );
  }

}