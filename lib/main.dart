import 'package:bca_project/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);
final ValueNotifier<Locale> localNotifier = ValueNotifier(Locale("en"));
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
        return ValueListenableBuilder<Locale>(
          valueListenable: localNotifier,
          builder: (context, locale, _) {
            return MaterialApp(
              theme: ThemeData.light(),
              darkTheme: ThemeData.dark(),
              themeMode: mode,
              home: SplashScreen(),
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              locale: locale,
            );
          },
        );
      },
    );
  }
}

//localization and internationalization /->//yasma new kura add garda khari "flutter gen-l10n" run garna parxa ani gen file ma add hunxa
//-> used to photo scan and convert into voiceover
//api.flutter.dev
//google_mlkit_text_recoginition  //change the language 
//mailar used to send mail
//changenotifier/valuelistenablebuilder 
//nepali utils for date conversion
//flutter native splash
//app icon generator is used to generate the logo of app using your figma design of logo and generate all files of logo using zif file
//flutter_bloc