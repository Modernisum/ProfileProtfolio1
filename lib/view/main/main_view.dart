import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_portfolio/res/constants.dart';
import 'package:flutter_portfolio/view%20model/controller.dart';
import 'package:flutter_portfolio/view/intro/components/side_menu_button.dart';
import 'package:flutter_portfolio/view/intro/introduction.dart';
import 'package:flutter_portfolio/view/main/components/connect_button.dart';
import 'package:flutter_portfolio/view/main/components/navigation_bar.dart';

import '../../view model/responsive.dart';
import 'components/drawer/drawer.dart';
import 'components/navigation_button_list.dart';

class MainView extends StatefulWidget {
  const MainView({super.key, required this.pages});
  final List<Widget> pages;

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  void _navigateToAbout() {
    if (controller.page?.toInt() != 1) {
      controller.animateToPage(
        1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isLargeMobile = Responsive.isLargeMobile(context);

    return Scaffold(
      drawer: const CustomDrawer(),
      body: Builder(
        builder: (scaffoldContext) {
          return Stack(
            children: [
              Center(
                child: Column(
                  children: [
                    if (!isMobile)
                      SizedBox(
                        height: kIsWeb && !isLargeMobile
                            ? defaultPadding * 2
                            : defaultPadding / 2,
                      ),
                    if (!isMobile)
                      const SizedBox(
                        height: 80,
                        child: TopNavigationBar(),
                      ),
                    if (isLargeMobile)
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MenuButton(
                              onTap: () =>
                                  Scaffold.of(scaffoldContext).openDrawer(),
                            ),
                            if (isMobile) SizedBox(width: defaultPadding * 3),
                            const NavigationButtonList(),
                            const SizedBox(width: 8),
                          ],
                        ),
                      ),
                    Expanded(
                      flex: 9,
                      child: PageView(
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        controller: controller,
                        children: [
                          Introduction(onNavigateToAbout: _navigateToAbout),
                          ...widget.pages.skip(1),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // ✅ FIXED: Wrap ConnectButton with Positioned here
              if (isMobile)
                const Positioned(
                  bottom: 24,
                  right: 24,
                  child: ConnectButton(),
                ),
            ],
          );
        },
      ),
    );
  }
}
