import 'package:flutter/material.dart';
import 'package:flutter_portfolio/view%20model/controller.dart';
import 'package:flutter_portfolio/view%20model/responsive.dart';

class NavigationButtonList extends StatefulWidget {
  const NavigationButtonList({super.key});

  @override
  State<NavigationButtonList> createState() => _NavigationButtonListState();
}

class _NavigationButtonListState extends State<NavigationButtonList> {
  int currentPage = 0;
  int? hoveredIndex;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        controller.addListener(_onPageChanged);
        _updateCurrentPage();
      }
    });
  }

  @override
  void dispose() {
    try {
      controller.removeListener(_onPageChanged);
    } catch (_) {}
    super.dispose();
  }

  void _onPageChanged() {
    if (mounted) {
      _updateCurrentPage();
    }
  }

  void _updateCurrentPage() {
    if (!mounted) return;
    final newPage = controller.page?.round() ?? 0;
    if (currentPage != newPage) {
      setState(() {
        currentPage = newPage;
      });
    }
  }

  void _navigateToPage(int pageIndex) {
    if (controller.page?.round() != pageIndex) {
      // ✅ Update UI first
      setState(() => currentPage = pageIndex);

      // ✅ Then animate page
      try {
        controller.animateToPage(
          pageIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } catch (_) {
        controller.jumpToPage(pageIndex);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final navigationItems = [
      if (!Responsive.isLargeMobile(context)) {'index': 0, 'label': 'Home'},
      {
        'index': !Responsive.isLargeMobile(context) ? 1 : 0,
        'label': 'About us'
      },
      {
        'index': !Responsive.isLargeMobile(context) ? 2 : 1,
        'label': 'Projects'
      },
      {
        'index': !Responsive.isLargeMobile(context) ? 3 : 2,
        'label': 'Certifications'
      },
    ];

    return TweenAnimationBuilder(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 200),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(navigationItems.length, (i) {
              final item = navigationItems[i];
              final index = item['index'] as int;
              final label = item['label'] as String;
              final isActive = currentPage == index;
              final isHovered = hoveredIndex == index;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: MouseRegion(
                  onEnter: (_) => setState(() => hoveredIndex = index),
                  onExit: (_) => setState(() => hoveredIndex = null),
                  child: GestureDetector(
                    onTap: () => _navigateToPage(index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isActive
                            ? Colors.blue.withOpacity(0.2)
                            : (isHovered
                                ? Colors.blue.withOpacity(0.1)
                                : Colors.transparent),
                        borderRadius: BorderRadius.circular(8),
                        border: isActive
                            ? Border(
                                bottom: const BorderSide(
                                  color: Colors.blue,
                                  width: 3.0,
                                ),
                              )
                            : null,
                        boxShadow: isActive
                            ? [
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : [],
                      ),
                      child: Text(
                        label,
                        style: TextStyle(
                          color: isActive
                              ? Colors.blue
                              : (isHovered
                                  ? Colors.blue.withOpacity(0.8)
                                  : Colors.grey[400]),
                          fontWeight:
                              isActive ? FontWeight.w700 : FontWeight.w500,
                          fontSize: isActive ? 15 : 14,
                          letterSpacing: isActive ? 0.5 : 0,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
