import 'dart:math';

import 'package:flutter/material.dart';

class ImageLoader extends StatefulWidget {
  @override
  _ImageLoaderState createState() => _ImageLoaderState();
}

class _ImageLoaderState extends State<ImageLoader>
    with SingleTickerProviderStateMixin {
  Animation<double> animationRotation;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        lowerBound: 0.0,
        upperBound: 1.0,
        duration: const Duration(seconds: 3),
        vsync: this);

    animationRotation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0.0, 1.0, curve: Curves.linear),
      ),
    );

    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
        width: 100,
        height: 100,
        child: RotationTransition(
          turns: animationRotation,
          child: Stack(
            children: _buildDots(),
          ),
        ),
      );

  List<Widget> _buildDots() {
    final List<Transform> dots = [];
    dots.add(Transform.translate(
      offset: Offset(0.0, 0.0),
      child: _buildDot(
        radius: 25,
        color: Colors.grey[200],
      ),
    ));
    dots.add(Transform.translate(
      child: _buildDot(
        color: Colors.deepOrange,
      ),
      offset: Offset(
        30 * cos(0.0),
        30 * sin(0.0),
      ),
    ));
    for (int i = 1; i < 8; i++) {
      dots.add(Transform.translate(
        child: _buildDot(
          color: Colors.deepOrange[(i + 1) * 100],
        ),
        offset: Offset(
          30 * cos(0.0 + i * pi / 4),
          30 * sin(0.0 + i * pi / 4),
        ),
      ));
    }

    return dots;
  }

  _buildDot({double radius = 5, Color color}) => Center(
        child: Container(
          height: radius,
          width: radius,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
      );
}
