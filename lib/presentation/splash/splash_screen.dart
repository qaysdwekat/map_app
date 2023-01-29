import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/routes/oot_navigate.dart';
import '../../core/routes/route.dart';

import '../common/ott_image.dart';

class SplashScreen extends StatelessWidget {
  final int duration = 2000;
  bool animationCompleted = false;
  SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const size = Size(100, 50);

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: _AnimatedSplashChild(
          next: () {
            navigateToNextScreen();
            animationCompleted = true;
          },
          imagePath: 'assets/images/oot_logo.svg',
          duration: duration,
        ),
      ),
    );
  }

  void navigateToNextScreen() {
    OOTNavigate.pushReplacementNamed(RouteList.home, forceRootNavigator: true);
  }
}

class _AnimatedSplashChild extends StatefulWidget {
  final Function? next;
  final String imagePath;
  final int duration;
  final BoxFit boxFit;
  final Size? size;

  const _AnimatedSplashChild({
    required this.next,
    required this.imagePath,
    this.duration = 1000,
    this.boxFit = BoxFit.contain,
    this.size,
  });

  @override
  __AnimatedSplashStateChild createState() => __AnimatedSplashStateChild();
}

class __AnimatedSplashStateChild extends State<_AnimatedSplashChild> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _animationController.reset();
    _animationController.forward();
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration),
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInCubic,
    ));
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 1500)).then(
          (value) {
            widget.next?.call();
          },
        );
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.reset();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final size = widget.size ?? Size(screenSize.width / 1.5, screenSize.height);
    return FadeTransition(
      opacity: _animation,
      child: Center(
        child: OOTImage(
          imageUrl: widget.imagePath,
          fit: widget.boxFit,
          height: size.height,
          width: size.width,
        ),
      ),
    );
  }
}
