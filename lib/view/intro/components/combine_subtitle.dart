import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_portfolio/view/intro/components/subtitle_text.dart';

import '../../../view model/responsive.dart';

class CombineSubtitleText extends StatelessWidget {
  const CombineSubtitleText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Responsive(
          desktop: AnimatedSubtitleText(start: 30, end: 40, text: 'App '),
          largeMobile: AnimatedSubtitleText(start: 30, end: 25, text: 'App '),
          mobile: AnimatedSubtitleText(start: 25, end: 20, text: 'App'),
          tablet: AnimatedSubtitleText(start: 40, end: 30, text: 'App'),
        ),
        (kIsWeb && Responsive.isLargeMobile(context)
            ? const Responsive(
                desktop: AnimatedSubtitleText(
                    start: 30, end: 40, text: 'Developer ', gradient: true),
                largeMobile: AnimatedSubtitleText(
                    start: 30, end: 25, text: 'Developer ', gradient: true),
                mobile: AnimatedSubtitleText(
                    start: 25, end: 20, text: 'Developer ', gradient: true),
                tablet: AnimatedSubtitleText(
                    start: 40, end: 30, text: 'Developer ', gradient: true),
              )
            : ShaderMask(
                shaderCallback: (bounds) {
                  return const LinearGradient(colors: [
                    Color(0xFF36D1DC),
                    Color(0xFF5B86E5),
                  ]).createShader(bounds);
                },
                child: const Responsive(
                  desktop: AnimatedSubtitleText(
                      start: 30, end: 40, text: 'Developer ', gradient: false),
                  largeMobile: AnimatedSubtitleText(
                      start: 30, end: 25, text: 'Developer ', gradient: false),
                  mobile: AnimatedSubtitleText(
                      start: 25, end: 20, text: 'Developer ', gradient: true),
                  tablet: AnimatedSubtitleText(
                      start: 40, end: 30, text: 'Developer ', gradient: false),
                ),
              ))
      ],
    );
  }
}
