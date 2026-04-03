import 'package:cab_zing/pages/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(AppWindow());
}

class AppWindow extends StatelessWidget {
  const AppWindow({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: SplashScreen(),
    );
  }
}
