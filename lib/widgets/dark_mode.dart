import 'package:bca_project/main.dart';
import 'package:flutter/material.dart';

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
            "Dark Mode",
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
