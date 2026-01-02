import 'package:flutter/material.dart';
import 'package:flutter_portfolio/res/constants.dart';
import 'package:flutter_portfolio/view%20model/responsive.dart';

class AboutView extends StatefulWidget {
  const AboutView({super.key});

  @override
  State<AboutView> createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView> {
  int activeTab = 0;
  late ScrollController _scrollController;
  late List<GlobalKey> _sectionKeys;

  final List<Map<String, dynamic>> tabs = [
    {'title': 'Personal', 'icon': Icons.person},
    {'title': 'Academic', 'icon': Icons.school},
    {'title': 'Physical', 'icon': Icons.fitness_center},
    {'title': 'Address', 'icon': Icons.location_on},
    {'title': 'Gallery', 'icon': Icons.image},
    {'title': 'Hobbies', 'icon': Icons.sports_soccer},
    {'title': 'Achievements', 'icon': Icons.emoji_events},
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _sectionKeys = List.generate(tabs.length, (index) => GlobalKey());
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// Auto-detect which section is visible and switch left tab
  void _onScroll() {
    for (int i = 0; i < _sectionKeys.length; i++) {
      final context = _sectionKeys[i].currentContext;
      if (context == null) continue;

      try {
        final RenderBox renderBox = context.findRenderObject() as RenderBox;
        final position = renderBox.localToGlobal(Offset.zero);
        final size = renderBox.size;

        if (position.dy < 250 && position.dy + size.height > 100) {
          if (activeTab != i) {
            setState(() => activeTab = i);
          }
          break;
        }
      } catch (_) {}
    }
  }

  /// Scroll smoothly to a section when tapping sidebar tab
  void _scrollToSection(int index) {
    setState(() => activeTab = index);
    final context = _sectionKeys[index].currentContext;
    if (context != null) {
      try {
        final RenderBox renderBox = context.findRenderObject() as RenderBox;
        final position = renderBox.localToGlobal(Offset.zero).dy;
        _scrollController.animateTo(
          _scrollController.offset + position - 150,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } catch (_) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // LEFT SIDEBAR (Desktop only)
          if (!Responsive.isMobile(context))
            Container(
              width: 250,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    ...List.generate(tabs.length, (index) {
                      final tab = tabs[index];
                      final isActive = activeTab == index;
                      return GestureDetector(
                        onTap: () => _scrollToSection(index),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          margin: EdgeInsets.only(bottom: 2),
                          padding: EdgeInsets.all(defaultPadding),
                          decoration: BoxDecoration(
                            color: isActive
                                ? Colors.black.withOpacity(0.2)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            border: isActive
                                ? Border(
                                    left: BorderSide(
                                        color: Colors.blue, width: 4),
                                  )
                                : null,
                            boxShadow: isActive
                                ? [
                                    BoxShadow(
                                      color: Colors.blue.withOpacity(0.3),
                                      blurRadius: 20,
                                      spreadRadius: 0,
                                      offset: Offset(0, 4),
                                    ),
                                  ]
                                : [],
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: isActive
                                      ? Colors.blue.withOpacity(0.2)
                                      : Colors.transparent,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  tab['icon'],
                                  color:
                                      isActive ? Colors.blue : Colors.grey[400],
                                  size: 20,
                                ),
                              ),
                              SizedBox(width: 12),
                              Text(
                                tab['title'],
                                style: TextStyle(
                                  color:
                                      isActive ? Colors.blue : Colors.grey[400],
                                  fontWeight: isActive
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),

          // RIGHT CONTENT AREA
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // HEADER
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(defaultPadding),
                    padding: EdgeInsets.all(defaultPadding * 2),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.blue.shade700, Colors.blue.shade400],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.3),
                          blurRadius: 20,
                          spreadRadius: 0,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          'About Me',
                          style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 28 : 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: defaultPadding),
                        Text(
                          'Full-Stack Developer | Flutter Expert | Agra, India',
                          style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 16 : 18,
                            color: Colors.white70,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // SECTIONS
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        KeyedSubtree(
                            key: _sectionKeys[0],
                            child: _buildPersonalSection()),
                        KeyedSubtree(
                            key: _sectionKeys[1],
                            child: _buildAcademicSection()),
                        KeyedSubtree(
                            key: _sectionKeys[2],
                            child: _buildPhysicalSection()),
                        KeyedSubtree(
                            key: _sectionKeys[3],
                            child: _buildAddressSection()),
                        KeyedSubtree(
                            key: _sectionKeys[4],
                            child: _buildGallerySection()),
                        KeyedSubtree(
                            key: _sectionKeys[5],
                            child: _buildHobbiesSection()),
                        KeyedSubtree(
                            key: _sectionKeys[6],
                            child: _buildAchievementsSection()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // PERSONAL SECTION
  Widget _buildPersonalSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Personal Information',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            height: 1.2,
          ),
        ),
        SizedBox(height: defaultPadding * 2),
        ...[
          _buildInfoCard('Full Name', 'Your Full Name'),
          _buildInfoCard('Email', 'your.email@example.com'),
          _buildInfoCard('Phone', '+91 XXXXXXXXXX'),
          _buildInfoCard('Location', 'Agra, Uttar Pradesh, India'),
          _buildInfoCard('Nationality', 'Indian'),
          _buildInfoCard('Date of Birth', '01 Jan 2000'),
        ],
      ],
    );
  }

  // ACADEMIC SECTION
  Widget _buildAcademicSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Academic Information',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            height: 1.2,
          ),
        ),
        SizedBox(height: defaultPadding * 2),
        _buildEducationCard(
          'Bachelor of Technology',
          'Computer Science',
          'University Name',
          '2020 - 2024',
        ),
        _buildEducationCard(
            '12th Grade', 'Science (PCM)', 'School Name', '2018 - 2020'),
        _buildEducationCard(
            '10th Grade', 'General', 'School Name', '2016 - 2018'),
      ],
    );
  }

  // PHYSICAL SECTION
  Widget _buildPhysicalSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Physical Information',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            height: 1.2,
          ),
        ),
        SizedBox(height: defaultPadding * 2),
        ...[
          _buildInfoCard('Height', "5'10\" (178 cm)"),
          _buildInfoCard('Weight', '75 kg'),
          _buildInfoCard('Blood Type', 'O+'),
          _buildInfoCard('Gender', 'Male'),
          _buildInfoCard('Body Type', 'Athletic'),
        ],
      ],
    );
  }

  // ADDRESS SECTION
  Widget _buildAddressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Address Information',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            height: 1.2,
          ),
        ),
        SizedBox(height: defaultPadding * 2),
        ...[
          _buildInfoCard(
            'Current Address',
            'Apartment/House No, Building Name, Street, Agra, UP 282001',
          ),
          _buildInfoCard('Permanent Address', 'Same as above'),
          _buildInfoCard('Country', 'India'),
          _buildInfoCard('State', 'Uttar Pradesh'),
          _buildInfoCard('City', 'Agra'),
          _buildInfoCard('Postal Code', '282001'),
        ],
      ],
    );
  }

  // GALLERY SECTION
  Widget _buildGallerySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Photo Gallery',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            height: 1.2,
          ),
        ),
        SizedBox(height: defaultPadding * 2),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: Responsive.isMobile(context) ? 2 : 3,
            crossAxisSpacing: defaultPadding,
            mainAxisSpacing: defaultPadding,
            childAspectRatio: 1,
          ),
          itemCount: 6,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(16),
                border:
                    Border.all(color: Colors.blue.withOpacity(0.3), width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    Container(color: Colors.grey[800]),
                    Center(
                      child: Icon(
                        Icons.image,
                        color: Colors.grey[500],
                        size: 50,
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  // HOBBIES SECTION
  Widget _buildHobbiesSection() {
    final hobbies = [
      'Photography',
      'Coding',
      'Gaming',
      'Reading',
      'Traveling',
      'Sports',
      'Music',
      'Cooking',
      'Flutter',
      'Tech Research',
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hobbies & Interests',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            height: 1.2,
          ),
        ),
        SizedBox(height: defaultPadding * 2),
        Wrap(
          spacing: defaultPadding,
          runSpacing: defaultPadding,
          children: hobbies.map((hobby) {
            return Container(
              padding: EdgeInsets.symmetric(
                horizontal: defaultPadding,
                vertical: defaultPadding / 2,
              ),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.15),
                border: Border.all(color: Colors.blue.withOpacity(0.4)),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.1),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                hobby,
                style: TextStyle(
                  color: Colors.blue[300],
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // ACHIEVEMENTS SECTION
  Widget _buildAchievementsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Achievements & Awards',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            height: 1.2,
          ),
        ),
        SizedBox(height: defaultPadding * 2),
        _buildAchievementCard('Best Developer Award', 'Company Name', '2024'),
        _buildAchievementCard('Top Contributor', 'GitHub/Open Source', '2023'),
        _buildAchievementCard('Project Excellence', 'University', '2023'),
        _buildAchievementCard('Innovation Award', 'Tech Fest', '2022'),
      ],
    );
  }

  // HELPER WIDGETS
  Widget _buildInfoCard(String label, String value) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: defaultPadding),
      padding: EdgeInsets.all(defaultPadding * 1.5),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[800]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.blue[400],
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: Colors.grey[300],
                fontSize: 15,
              ),
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEducationCard(
      String degree, String field, String institution, String duration) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: defaultPadding * 1.5),
      padding: EdgeInsets.all(defaultPadding * 1.5),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(16),
        border: Border(
          left: BorderSide(
            color: Colors.blue,
            width: 5,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            degree,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 4),
          Text(
            field,
            style: TextStyle(
              color: Colors.blue[400],
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                institution,
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 14,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  duration,
                  style: TextStyle(
                    color: Colors.blue[300],
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementCard(String title, String issuer, String year) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: defaultPadding * 1.5),
      padding: EdgeInsets.all(defaultPadding * 1.5),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blue.shade900,
            Colors.blue.shade800,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.shade700, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.4),
            blurRadius: 20,
            spreadRadius: 0,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.amber.withOpacity(0.2),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.amber, width: 2),
            ),
            child: Icon(
              Icons.emoji_events,
              color: Colors.amber,
              size: 28,
            ),
          ),
          SizedBox(width: defaultPadding),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  '$issuer • $year',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
