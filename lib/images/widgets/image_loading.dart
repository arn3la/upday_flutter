import 'package:flutter/material.dart';

class ImageLoading extends StatefulWidget {
  @override
  createState() => _ImageLoadingState();
}

class _ImageLoadingState extends State<ImageLoading>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    _animationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.0, 1.0, curve: Curves.easeIn)));

    _animationController.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FadeTransition(
        opacity: _animation,
        child: Container(
          child: Image.asset(
            'assets/placeholder.png',
            fit: BoxFit.cover,
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.white, width: 4)),
        ),
      );
}
