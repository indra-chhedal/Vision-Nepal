import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialIcons extends StatelessWidget {
  final String image;

  final Uri url;
  const SocialIcons({super.key, required this.image, required this.url});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (await canLaunchUrl(url)) {
          await launchUrl(url, mode: LaunchMode.externalApplication);
        } else {
          print("Couldn't launch $url");
        }
      },
      child: Card(
        elevation: 2,
        shape: CircleBorder(eccentricity: 0.1),
        child: Container(
          padding: EdgeInsets.all(13),
          child: SvgPicture.asset(image, height: 36, width: 36),
        ),
      ),
    );
  }
}
