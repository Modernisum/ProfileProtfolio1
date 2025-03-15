import 'package:flutter/material.dart';
import 'package:flutter_portfolio/view/intro/components/social_icon.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaIconColumn extends StatelessWidget {
  const SocialMediaIconColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SocialMediaIcon(
            icon: 'assets/icons/linkedin.svg',
            onTap: () =>
                launchUrl(Uri.parse('www.linkedin.com/in/shivank--kumar'))),
        SocialMediaIcon(
          icon: 'assets/icons/github.svg',
          onTap: () => launchUrl(Uri.parse('https://github.com/SHIVANK47')),
        ),
        SocialMediaIcon(
          icon: 'assets/icons/dribble.svg',
          onTap: () => launchUrl(Uri.parse('wwww.modernisum.com')),
        ),
        //const SocialMediaIcon(icon: 'assets/icons/twitter.svg'),
      ],
    );
  }
}
