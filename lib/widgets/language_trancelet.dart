import 'package:flutter/material.dart';

class LanguageTrancelet extends StatelessWidget {
  const LanguageTrancelet({
    super.key,
    required this.title,
    required this.subtitle,
    required this.ontap,
  });
  final String title;
  final String subtitle;
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      
      onTap: ontap,
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Icon(Icons.arrow_forward_ios),
    );
  }
}
