import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyPortfolio',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: PiratePalette.oceanBlue,
          primary: PiratePalette.deepNavy,
          secondary: PiratePalette.treasureGold,
          surface: PiratePalette.softPaper,
          onSurface: PiratePalette.deepNavy,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: PiratePalette.deepNavy,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        scaffoldBackgroundColor: PiratePalette.parchment,
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}
