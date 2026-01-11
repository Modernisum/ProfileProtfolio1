import 'package:flutter/material.dart';
import '../../../model/project_model.dart'; // ✅ Ensure this imports projectList
import '../../../res/constants.dart';
import '../../../view model/responsive.dart';

class ProjectDetail extends StatelessWidget {
  final int index;
  const ProjectDetail({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    // ✅ Safety check
    if (index < 0 || index >= projectList.length) {
      return const Center(
        child: Text(
          'Project not found',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    final project = projectList[index];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Align(
          alignment: Alignment.topCenter,
          child: Text(
            project.name,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),

        // Spacing
        SizedBox(
          height: Responsive.isMobile(context)
              ? defaultPadding / 2
              : defaultPadding,
        ),

        // Description (using idea field)
        Text(
          project.idea, // ✅ Use 'idea' (matches your model)
          style: const TextStyle(
            color: Colors.grey,
            height: 1.5,
          ),
          maxLines: _getMaxLines(size.width), // ✅ Clean helper method
          overflow: TextOverflow.ellipsis,
        ),

        // Links
      ],
    );
  }

  // ✅ Clean maxLines logic
  int _getMaxLines(double width) {
    if (width > 900 && width < 1060) return 6;
    if (width > 700 && width < 750) return 3;
    if (width > 600 && width < 700) return 6;
    if (width < 470) return 2;
    return 4; // Default
  }
}
