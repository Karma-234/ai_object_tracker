import 'package:ai_object_tracker/views/index_view.dart';
import 'package:ai_object_tracker/views/splash_screen.dart';
import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "home": (context) => const SplashView(),
        "dashboard": (context) => const IndexView()
      },
      title: 'Object Detection',
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return const SplashView();
          },
        );
      },
    );
  }
}
