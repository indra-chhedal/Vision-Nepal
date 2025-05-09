import 'package:flutter/material.dart';

class DrawerIcons extends StatelessWidget {
  const DrawerIcons({super.key, required this.icons, required this.title, required this.onTap});

  final IconData icons;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: InkWell(
          onTap: onTap,
          child: ListTile(
            leading: Icon(icons),
            title: Text(title),
            

            trailing: Icon(Icons.arrow_forward_ios),
          ),
        ),
      ),
    );
  }
}
