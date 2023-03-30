import 'package:flutter/material.dart';

class CoreWidget extends StatelessWidget {

  final Widget child;

  const CoreWidget({Key? key, required this.child}) : super(key: key);
  
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
              body: child,
            ),
        )
        )
    );
  }

}