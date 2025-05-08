import 'package:flutter/material.dart';

class Dark_Mode extends StatelessWidget {
  final ValueNotifier<ThemeMode> themeNotifier;
  const Dark_Mode({super.key, required this.themeNotifier});

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
