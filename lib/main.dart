import 'package:flutter/material.dart';
import 'package:to_do_app/routes/intro_screen.dart';
import 'package:to_do_app/routes/splash_screen.dart';

void main() {
  // TODO: Инициализация базы (создание пустой)
  runApp(
    const InitScreen(),
  );
}

class InitScreen extends StatefulWidget {
  const InitScreen({
    super.key,
  });

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (context) => const IntroScreen(),
        "/splash": (context) => const SplashScreen(),
      },
      initialRoute: "/",
    );
  }
}
