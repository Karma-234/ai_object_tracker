import 'dart:async';

import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late Animation<double> _progress;
  late Animation<AlignmentGeometry> _offset;
  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _offset = Tween<AlignmentGeometry>(
            begin: const Alignment(0, 1), end: const Alignment(0, 0))
        .animate(_animationController);
    _progress = Tween<double>(begin: 0.4, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.6,
          1,
          curve: Curves.easeIn,
        ),
      ),
    );
    _animationController.forward().then((value) {
      Timer(const Duration(seconds: 1), () {
        Navigator.of(context).pushNamed("dashboard");
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: AnimatedAlign(
        duration: const Duration(
          seconds: 1,
        ),
        alignment: _offset.value,
        child: AnimatedIcon(icon: AnimatedIcons.home_menu, progress: _progress),
      ),
    );
  }
}
