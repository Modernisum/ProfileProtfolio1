import 'package:flutter/material.dart';

import '../../../res/constants.dart';

class MenuButton extends StatelessWidget {
  final VoidCallback? onTap;
  const MenuButton({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        TweenAnimationBuilder(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 200),
          builder: (context, double value, Widget? child) {
            return InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(
                  10), // Match the container's borderRadius
              child: Container(
                height: defaultPadding * 2.0 * value,
                width: defaultPadding * 2.0 * value,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF5B86E5).withOpacity(0.5),
                      offset: const Offset(-1, -1),
                      blurRadius: 5, // Add a blurRadius for a softer shadow
                    ),
                  ],
                  gradient: const LinearGradient(
                    // Add the gradient to the container
                    colors: [
                      Color(0xFF36D1DC),
                      Color(0xFF5B86E5),
                    ],
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.menu,
                    color: Colors.white,
                    size: defaultPadding * 1.2 * value,
                  ),
                ),
              ),
            );
          },
        ),
        const Spacer(
          flex: 5,
        ),
      ],
    );
  }
}
