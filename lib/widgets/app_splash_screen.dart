import 'package:flutter/material.dart';

class AppSplashScreen extends StatelessWidget {
  const AppSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppSplashView.backgroundColor,
      body: AppSplashView(),
    );
  }
}

class AppSplashView extends StatelessWidget {
  static const Color backgroundColor = Color(0xFF053791);
  static const String assetPath = 'assets/images/splash.png';

  const AppSplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: backgroundColor,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: Image.asset(
              assetPath,
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              fit: BoxFit.contain,
            ),
          );
        },
      ),
    );
  }
}
