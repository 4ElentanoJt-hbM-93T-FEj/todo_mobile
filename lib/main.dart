import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_app/db_core.dart';
import 'package:to_do_app/routes/intro_screen.dart';
import 'package:to_do_app/routes/main_page.dart';
import 'package:to_do_app/routes/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle().copyWith(
      statusBarColor: const Color.fromARGB(255, 42, 42, 46),
      systemNavigationBarColor: Colors.black,
    ),
  );
  runApp(
    const ProviderScope(
      child: InitScreen(),
    ),
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
  void initState() {
    // init();
    super.initState();
  }

  // void init() async {
  //   var db = DatabaseCore.instance;
  //   await db.initDatabase();
  //   debugPrint(db.database.toString());
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (context) => const IntroScreen(),
        "/splash": (context) => const SplashScreen(),
        "/main_page": (context) => const MainPage(),
      },
      initialRoute: "/",
      debugShowCheckedModeBanner: false,
    );
  }
}
