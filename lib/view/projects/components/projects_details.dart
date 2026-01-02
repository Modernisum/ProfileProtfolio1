// lib/view/projects/project_details_view.dart

import 'package:flutter/material.dart';
import 'package:flutter_portfolio/res/constants.dart';
import 'package:flutter_portfolio/view model/getx_controllers/project_detail_controller.dart';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ProjectDetailsView extends StatefulWidget {
  final String projectId;

  const ProjectDetailsView({
    super.key,
    required this.projectId,
  });

  @override
  State<ProjectDetailsView> createState() => _ProjectDetailsViewState();
}

class _ProjectDetailsViewState extends State<ProjectDetailsView> {
  late YoutubePlayerController _youtubeController;
  final controller = Get.put(ProjectDetailController());

  @override
  void initState() {
    super.initState();
    controller.fetchProjectDetails(widget.projectId);
    _youtubeController = YoutubePlayerController(
      initialVideoId: _getYoutubeVideoId(''),
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  String _getYoutubeVideoId(String url) {
    if (url.contains('youtube.com/embed/')) {
      return url.split('/embed/').last;
    }
    return '';
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not launch URL')),
      );
    }
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Details'),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      backgroundColor: Colors.grey[950],
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.blue),
          );
        }

        if (controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Text(
              controller.errorMessage.value,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        final project = controller.selectedProject.value;
        if (project == null) {
          return const Center(
            child: Text(
              'Project not found',
              style: TextStyle(color: Colors.white),
            ),
          );
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with Image
              Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade700, Colors.blue.shade400],
                  ),
                ),
                child: Image.network(
                  project.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.blue.shade700,
                      child: const Center(
                        child:
                            Icon(Icons.image, size: 80, color: Colors.white30),
                      ),
                    );
                  },
                ),
              ),

              Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Project Name & Category
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                project.name,
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: defaultPadding / 2),
                              Text(
                                project.category,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.blue[300],
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Project Level Badge
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: defaultPadding,
                            vertical: defaultPadding / 2,
                          ),
                          decoration: BoxDecoration(
                            color: controller.getLevelColor().withOpacity(0.2),
                            border: Border.all(
                              color: controller.getLevelColor(),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            project.projectLevel,
                            style: TextStyle(
                              color: controller.getLevelColor(),
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: defaultPadding * 1.5),

                    // Quick Stats
                    Row(
                      children: [
                        _buildStatCard(
                          icon: Icons.calendar_today,
                          label: 'Duration',
                          value: controller.getDurationString(),
                        ),
                        SizedBox(width: defaultPadding),
                        _buildStatCard(
                          icon: Icons.apps,
                          label: 'Technologies',
                          value: '${project.technologies.length} Tech',
                        ),
                        SizedBox(width: defaultPadding),
                        _buildStatCard(
                          icon: Icons.build,
                          label: 'Skills',
                          value: '${project.skillsUsed.length} Skills',
                        ),
                      ],
                    ),

                    SizedBox(height: defaultPadding * 2),

                    // Project Idea
                    _buildSection(
                      'Project Idea',
                      Icons.lightbulb,
                      project.idea,
                    ),

                    SizedBox(height: defaultPadding * 1.5),

                    // Benefits
                    _buildSection(
                      'Key Benefits',
                      Icons.star,
                      project.benefits,
                    ),

                    SizedBox(height: defaultPadding * 1.5),

                    // Timeline
                    Container(
                      padding: EdgeInsets.all(defaultPadding),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[800]!),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.schedule,
                                  color: Colors.blue, size: 22),
                              SizedBox(width: defaultPadding / 2),
                              const Text(
                                'Timeline',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: defaultPadding),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Start Date',
                                    style: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    project.startDate,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                width: 40,
                                height: 2,
                                color: Colors.blue.withOpacity(0.3),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'Completed',
                                    style: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    project.completeDate,
                                    style: const TextStyle(
                                      color: Colors.green,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: defaultPadding * 1.5),

                    // Skills Used
                    _buildChipsSection(
                        'Skills Used', project.skillsUsed, Colors.blue),

                    SizedBox(height: defaultPadding * 1.5),

                    // Technologies
                    _buildChipsSection(
                        'Technologies', project.technologies, Colors.purple),

                    SizedBox(height: defaultPadding * 1.5),

                    // Learning
                    _buildSection(
                      'What I Learned',
                      Icons.school,
                      project.learning,
                    ),

                    SizedBox(height: defaultPadding * 1.5),

                    // Problems Faced
                    _buildSection(
                      'Challenges & Solutions',
                      Icons.warning,
                      project.problemsFaced,
                    ),

                    SizedBox(height: defaultPadding * 1.5),

                    // Review/Description
                    _buildSection(
                      'Project Review',
                      Icons.rate_review,
                      project.review,
                    ),

                    SizedBox(height: defaultPadding * 1.5),

                    // Screenshots
                    if (project.screenshots.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.photo_library,
                                  color: Colors.blue, size: 22),
                              SizedBox(width: defaultPadding / 2),
                              const Text(
                                'Screenshots',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: defaultPadding),
                          SizedBox(
                            height: 200,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: project.screenshots.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin:
                                      EdgeInsets.only(right: defaultPadding),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Colors.blue.withOpacity(0.5),
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      project.screenshots[index],
                                      fit: BoxFit.cover,
                                      width: 150,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Container(
                                          width: 150,
                                          color: Colors.grey[800],
                                          child: const Center(
                                            child: Icon(
                                              Icons.image,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: defaultPadding * 1.5),
                        ],
                      ),

                    // Demo Video
                    if (project.demoVideoLink.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.play_circle,
                                  color: Colors.red, size: 22),
                              SizedBox(width: defaultPadding / 2),
                              const Text(
                                'Demo Video',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: defaultPadding),
                          YoutubePlayer(
                            controller: YoutubePlayerController(
                              initialVideoId:
                                  _getYoutubeVideoId(project.demoVideoLink),
                              flags: const YoutubePlayerFlags(
                                autoPlay: false,
                                mute: false,
                              ),
                            ),
                            showVideoProgressIndicator: true,
                            progressIndicatorColor: Colors.blue,
                            progressColors: const ProgressBarColors(
                              playedColor: Colors.blue,
                              handleColor: Colors.blueAccent,
                            ),
                          ),
                          SizedBox(height: defaultPadding * 1.5),
                        ],
                      ),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => _launchUrl(project.accessLink),
                            icon: const Icon(Icons.code),
                            label: const Text('View Code'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: EdgeInsets.symmetric(
                                  vertical: defaultPadding),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: defaultPadding),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => _launchUrl(project.demoVideoLink),
                            icon: const Icon(Icons.play_arrow),
                            label: const Text('Watch Demo'),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.blue),
                              padding: EdgeInsets.symmetric(
                                  vertical: defaultPadding),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: defaultPadding * 2),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[800]!),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.blue, size: 20),
            SizedBox(height: defaultPadding / 2),
            Text(
              label,
              style: TextStyle(color: Colors.grey[400], fontSize: 12),
            ),
            SizedBox(height: defaultPadding / 2),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, IconData icon, String content) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[800]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.blue, size: 22),
              SizedBox(width: defaultPadding / 2),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: defaultPadding),
          Text(
            content,
            style: TextStyle(
              color: Colors.grey[300],
              fontSize: 14,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChipsSection(String title, List<String> items, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.local_fire_department, color: color, size: 22),
            SizedBox(width: defaultPadding / 2),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: defaultPadding),
        Wrap(
          spacing: defaultPadding / 2,
          runSpacing: defaultPadding / 2,
          children: items.map((item) {
            return Container(
              padding: EdgeInsets.symmetric(
                horizontal: defaultPadding / 2,
                vertical: defaultPadding / 3,
              ),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                border: Border.all(color: color.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                item,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
