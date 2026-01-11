import 'package:flutter/material.dart';
import 'package:flutter_portfolio/view%20model/responsive.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../res/constants.dart';

class ConnectButton extends StatelessWidget {
  const ConnectButton({super.key});

  void _launchWhatsApp() {
    launchUrl(Uri.parse('https://wa.me/+919368671007'));
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    // ✅ FIXED: Return widget WITHOUT Positioned
    return GestureDetector(
      onTap: _launchWhatsApp,
      child: Container(
        height: 50,
        width: isMobile ? 50 : 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultPadding),
          gradient: const LinearGradient(
            colors: [
              Color(0xFF36D1DC),
              Color(0xFF5B86E5),
            ],
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.blue,
              offset: Offset(0, -1),
              blurRadius: defaultPadding / 4,
            ),
            BoxShadow(
              color: Colors.red,
              offset: Offset(0, 1),
              blurRadius: defaultPadding / 4,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              FontAwesomeIcons.whatsapp,
              color: Colors.greenAccent,
              size: 15,
            ),
            if (!isMobile) ...[
              const SizedBox(width: defaultPadding / 4),
              Text(
                'WhatsApp',
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: Colors.white,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
