import 'package:bca_project/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DarkMode extends StatelessWidget {
  const DarkMode({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = themeNotifier.value == ThemeMode.dark;
    return Card(
      color: Colors.white,
      elevation: 2,
      child: InkWell(
        child: ListTile(
          leading: Text(
            AppLocalizations.of(context)!.darkMode,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          trailing: Switch(
            value: isDark,
            onChanged: (value) {
              themeNotifier.value = value ? ThemeMode.dark : ThemeMode.light;
            },
          ),
        ),
      ),
    );
  }
}
