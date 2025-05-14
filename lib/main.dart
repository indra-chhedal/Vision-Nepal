import 'package:bca_project/screens/splash_screen.dart';

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
          home: SplashScreen(),
        );
      },
    );
  }
}

//localization and internationalization -> used to photo scan and convert into voiceover
//api.flutter.dev
//google_mlkit_text_recoginition  //change the language 
//mailar used to send mail
//changenotifier/valuelistenablebuilder