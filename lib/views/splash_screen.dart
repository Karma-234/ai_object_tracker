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
  AlignmentGeometry _offset = const Alignment(0, 1);
  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _progress = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.6,
          1,
          curve: Curves.easeIn,
        ),
      ),
    );
    Future.delayed(
      const Duration(seconds: 1),
      () {
        setState(() {
          _offset = const Alignment(0, 0);
        });
      },
    ).then((_) {
      _animationController.forward().then((_) {
        Timer(const Duration(seconds: 2), () {
          Navigator.of(context).pushNamed("dashboard");
        });
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
          milliseconds: 900,
        ),
        alignment: _offset,
        child: AnimatedIcon(
            icon: AnimatedIcons.home_menu, progress: _progress, size: 34),
      ),
    );
  }
}
