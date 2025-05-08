import 'package:bca_project/screens/home_screen.dart';
import 'package:bca_project/screens/login_screen.dart';
import 'package:bca_project/screens/register_screen.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(
      ThemeMode.light,
    );

    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, mode, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Dark Mode Demo',
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: mode,
          home: HomeScreen(),
        );
      },
    );
  }
}
