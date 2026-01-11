import 'package:flutter/material.dart';
import 'package:flutter_portfolio/view%20model/responsive.dart';
import 'package:flutter_portfolio/view/intro/components/intro_body.dart';
import 'package:flutter_portfolio/view/intro/components/side_menu_button.dart';
import 'package:flutter_portfolio/view/intro/components/social_media_list.dart';

class Introduction extends StatefulWidget {
  const Introduction({super.key, this.onNavigateToAbout});

  // ✅ NEW: Callback to navigate to About page
  final VoidCallback? onNavigateToAbout;

  @override
  State<Introduction> createState() => _IntroductionState();
}

class _IntroductionState extends State<Introduction> {
  // ✅ NEW: Track drag direction

  // ✅ NEW: Handle vertical drag
  void _handleVerticalDrag(DragUpdateDetails details) {
    // Negative dy = scrolling UP
    if (details.delta.dy < -15) {
      // ✅ Swiped UP → Navigate to About
      widget.onNavigateToAbout?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        // ✅ NEW: Detect vertical drag gestures
        onVerticalDragUpdate: _handleVerticalDrag,
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.01,
            ),
            if (!Responsive.isLargeMobile(context))
              MenuButton(
                onTap: () => Scaffold.of(context).openDrawer(),
              ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.02,
            ),
            if (!Responsive.isLargeMobile(context)) const SocialMediaIconList(),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.07,
            ),
            const Expanded(
              child: IntroBody(),
            ),
          ],
        ),
      ),
    );
  }
}
