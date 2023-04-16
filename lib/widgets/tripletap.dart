import 'dart:async';
import 'package:flutter/material.dart';

class TripleTapButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;

  const TripleTapButton({Key? key, required this.onPressed, required this.child})
      : super(key: key);

  @override
  _TripleTapButtonState createState() => _TripleTapButtonState();
}

class _TripleTapButtonState extends State<TripleTapButton> {
  int _tapCount = 0;
  Timer? _timer;

  void _startTimer() {
    _timer = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _tapCount = 0;
      });
    });
  }

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _tapCount++;
    });
    if (_tapCount == 3) {
      widget.onPressed();
      _tapCount = 0;
    }
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      child: widget.child
    );
  }
}