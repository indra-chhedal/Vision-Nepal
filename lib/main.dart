import 'package:bca_project/screens/home_screen.dart';

import 'package:flutter/material.dart';

final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);
void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>( 
      valueListenable: themeNotifier,
      builder: (context, mode, _) {
        return MaterialApp(
          
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: mode,
          home: HomeScreen(),
        );
      },
    );
  }
}
