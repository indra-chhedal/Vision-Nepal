import 'package:flutter/material.dart';

class SocialIcons extends StatelessWidget {
  final IconData icons;
  final Color color;
  final VoidCallback onTap;
  const SocialIcons({super.key, required this.icons, required this.color,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 2,
        shape: CircleBorder(eccentricity: 0.1),
        child: Container(
          padding: EdgeInsets.all(13),
          child: Icon(icons, color: color, size: 37),
        ),
      ),
    );
  }
}
