import 'package:flutter/material.dart';
import 'package:flutter_portfolio/view%20model/responsive.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../res/constants.dart';

class DownloadButton extends StatelessWidget {
  const DownloadButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        launchUrl(Uri.parse(
            'https://drive.google.com/file/d/1dXZ-miu9VTQtsZsgcikumMU1lheNyTdt/view?usp=sharing'));
      },
      child: Container(
        alignment: Alignment.center,
        // ✅ FIXED: Responsive padding
        padding: EdgeInsets.symmetric(
          vertical: defaultPadding / 1.5,
          horizontal: Responsive.isMobile(context)
              ? defaultPadding * 1.2
              : defaultPadding * 2,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(color: Colors.blue, offset: Offset(0, -1), blurRadius: 5),
            BoxShadow(color: Colors.red, offset: Offset(0, 1), blurRadius: 5),
          ],
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF36D1DC),
              Color(0xFF5B86E5),
            ],
          ),
        ),
        child: Row(
          // ✅ FIXED: Shrink to content size
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ✅ FIXED: Responsive text
            Flexible(
              child: Text(
                'Download Resume',
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: Colors.white,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.bold,
                      // ✅ FIXED: Smaller font on mobile
                      fontSize: Responsive.isMobile(context) ? 13 : 15,
                    ),
                overflow: TextOverflow.ellipsis, // ✅ Clip if needed
                maxLines: 1,
              ),
            ),
            const SizedBox(width: 8), // ✅ Smaller gap
            const Icon(
              FontAwesomeIcons.download,
              color: Colors.white70,
              size: 15,
            ),
          ],
        ),
      ),
    );
  }
}
