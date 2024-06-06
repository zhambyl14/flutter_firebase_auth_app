import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'widget_tree.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/home_page.dart';
import 'pages/forgot_password.dart';
import 'pages/top_page.dart';
import 'pages/game_page.dart';
import 'pages/settings_page.dart';
import 'pages/map_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: Utils.messengerKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const WidgetTree(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) =>  RegisterPage(),
        '/home': (context) =>  HomePage(),
        '/forgot_password': (context) => const ForgotPasswordPage(),
        '/top': (context) => const TopPage(),
        '/game': (context) => const GamePage(),
        '/settings': (context) => const SettingsPage(),
        '/map': (context) => const MapPage(),
      },
    );
  }
}
