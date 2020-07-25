import 'package:flutter/material.dart';

import 'sunshine_logo.dart';

class SunshineLoading extends StatefulWidget {
  const SunshineLoading({this.width, this.height});

  final double width;
  final double height;

  @override
  _SunshineLoadingState createState() => _SunshineLoadingState();
}

class _SunshineLoadingState extends State<SunshineLoading>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      lowerBound: 0,
    )
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller
            ..reset()
            ..forward();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      })
      ..forward(from: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      child: SunshineLogo(
        width: widget.width,
        height: widget.height,
      ),
      turns: Tween<double>(begin: 0, end: 1).animate(_controller),
    );
  }
}
