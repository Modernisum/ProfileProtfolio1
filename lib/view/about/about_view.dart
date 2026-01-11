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
    {'title': 'About', 'icon': Icons.person},
    {'title': 'My Journey', 'icon': Icons.timeline},
    {'title': 'Academic', 'icon': Icons.school},
    {'title': 'Skills', 'icon': Icons.code},
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

  void _onScroll() {
    for (int i = 0; i < _sectionKeys.length; i++) {
      final context = _sectionKeys[i].currentContext;
      if (context == null) continue;

      try {
        final RenderBox renderBox = context.findRenderObject() as RenderBox;
        final position = renderBox.localToGlobal(Offset.zero);
        final size = renderBox.size;

        if (position.dy <= 150 && position.dy + size.height > 150) {
          if (activeTab != i) {
            setState(() => activeTab = i);
          }
          break;
        }
      } catch (_) {}
    }
  }

  void _scrollToSection(int index) {
    final context = _sectionKeys[index].currentContext;
    if (context != null) {
      try {
        final RenderBox renderBox = context.findRenderObject() as RenderBox;
        final position = renderBox.localToGlobal(Offset.zero).dy;

        _scrollController.removeListener(_onScroll);

        _scrollController
            .animateTo(
          _scrollController.offset + position - 150,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        )
            .then((_) {
          _scrollController.addListener(_onScroll);
          setState(() => activeTab = index);
        });
      } catch (_) {
        _scrollController.addListener(_onScroll);
      }
    } else {
      setState(() => activeTab = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isLargeMobile = Responsive.isLargeMobile(context);
    final isTablet = Responsive.isTablet(context);
    final isDesktop = Responsive.isDesktop(context);
    final isExtraLarge = Responsive.isExtraLargeScreen(context);

    double sidebarWidth = 250;
    if (isExtraLarge) sidebarWidth = 280;
    if (isTablet && !isDesktop) sidebarWidth = 80;

    return Scaffold(
      backgroundColor: Colors.grey[950],
      body: Row(
        children: [
          // ✅ LEFT SIDEBAR - Desktop & Tablet ONLY
          if (!isMobile)
            Container(
              width: sidebarWidth,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: isTablet ? 40 : 50),
                    ...List.generate(tabs.length, (index) {
                      final tab = tabs[index];
                      final isActive = activeTab == index;
                      return GestureDetector(
                        onTap: () => _scrollToSection(index),
                        child: Tooltip(
                          message: isTablet ? tab['title'] : '',
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: EdgeInsets.only(bottom: 2),
                            padding: EdgeInsets.all(
                              isTablet ? defaultPadding / 1.5 : defaultPadding,
                            ),
                            decoration: BoxDecoration(
                              color: isActive
                                  ? Colors.black.withOpacity(0.2)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: isActive
                                  ? [
                                      BoxShadow(
                                        color: Colors.blue.withOpacity(0.3),
                                        blurRadius: 20,
                                        spreadRadius: 0,
                                        offset: const Offset(0, 4),
                                      ),
                                    ]
                                  : [],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
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
                                    color: isActive
                                        ? Colors.blue
                                        : Colors.grey[400],
                                    size: isTablet ? 18 : 20,
                                  ),
                                ),
                                if (!isTablet) ...[
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      tab['title'],
                                      style: TextStyle(
                                        color: isActive
                                            ? Colors.blue
                                            : Colors.grey[400],
                                        fontWeight: isActive
                                            ? FontWeight.w600
                                            : FontWeight.normal,
                                        fontSize: 14,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          // ✅ RIGHT CONTENT AREA
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(
                      isMobile
                          ? defaultPadding * 0.75
                          : isLargeMobile
                              ? defaultPadding
                              : defaultPadding * 1.5,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        KeyedSubtree(
                            key: _sectionKeys[0], child: _buildAboutSection()),
                        KeyedSubtree(
                            key: _sectionKeys[1],
                            child: _buildJourneySection()),
                        KeyedSubtree(
                            key: _sectionKeys[2],
                            child: _buildAcademicSection()),
                        KeyedSubtree(
                            key: _sectionKeys[3], child: _buildSkillsSection()),
                        KeyedSubtree(
                            key: _sectionKeys[4],
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

  // ✅ ABOUT SECTION - UPDATED WITH PERSONAL INFO
  Widget _buildAboutSection() {
    final isMobile = Responsive.isMobile(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('About Me'),
        SizedBox(height: defaultPadding * 2),

        // ✅ VISION QUOTE CARD
        Container(
          padding:
              EdgeInsets.all(isMobile ? defaultPadding : defaultPadding * 1.5),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[800]!),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '🚀 Vision',
                style: TextStyle(
                  color: Colors.blue[300],
                  fontSize: isMobile ? 13 : 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: defaultPadding / 3),
              Text(
                '"Everything is possible through engineering"',
                style: TextStyle(
                  color: Colors.blue[200],
                  fontSize: isMobile ? 14 : 16,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w600,
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: defaultPadding * 2),

        SizedBox(height: defaultPadding * 2),

        // ✅ PERSONAL INFORMATION SECTION
        _buildPersonalInformationCards(),
        SizedBox(height: defaultPadding * 2),
      ],
    );
  }

  // ✅ PERSONAL INFORMATION CARDS - ALL DETAILS
  Widget _buildPersonalInformationCards() {
    final isMobile = Responsive.isMobile(context);
    final isLargeMobile = Responsive.isLargeMobile(context);

    if (isMobile) {
      return Column(
        children: [
          _buildPersonalDetailCard('👤 Name', 'Shivank Bhati'),
          SizedBox(height: defaultPadding / 2),
          _buildPersonalDetailCard('👨‍💼 Father', 'Bablu Bhati (Farmer)'),
          SizedBox(height: defaultPadding / 2),
          _buildPersonalDetailCard('👩‍🏫 Mother', 'Bimlesh (Teacher)'),
          SizedBox(height: defaultPadding / 2),
          _buildPersonalDetailCard('💼 Profession', 'Software Engineer'),
          SizedBox(height: defaultPadding / 2),
          _buildPersonalDetailCard('📅 Age', '23 Years'),
          SizedBox(height: defaultPadding / 2),
          _buildPersonalDetailCard('👰 Marital Status', 'Married'),
          SizedBox(height: defaultPadding / 2),
          _buildPersonalDetailCard('🎓 Qualification', 'BSc Computer Science'),
          SizedBox(height: defaultPadding / 2),
          _buildPersonalDetailCard(
              '🏫 University', 'Chudhary Charan Singh University'),
          SizedBox(height: defaultPadding / 2),
          _buildPersonalDetailCard('🏢 Current Company', 'W2S Infotech Meerut'),
          SizedBox(height: defaultPadding / 2),
          _buildPersonalDetailCard('⭐ Position', 'Senior Software Developer'),
        ],
      );
    } else if (isLargeMobile) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildPersonalDetailCard('👤 Name', 'Shivank Bhati'),
              ),
              SizedBox(width: defaultPadding / 2),
              Expanded(
                child: _buildPersonalDetailCard(
                    '💼 Profession', 'Software Engineer'),
              ),
            ],
          ),
          SizedBox(height: defaultPadding / 2),
          Row(
            children: [
              Expanded(
                child: _buildPersonalDetailCard('📅 Age', '23 Years'),
              ),
              SizedBox(width: defaultPadding / 2),
              Expanded(
                child: _buildPersonalDetailCard('👰 Status', 'Married'),
              ),
            ],
          ),
          SizedBox(height: defaultPadding / 2),
          Row(
            children: [
              Expanded(
                child: _buildPersonalDetailCard('🎓 Qualification', 'BSc CS'),
              ),
              SizedBox(width: defaultPadding / 2),
              Expanded(
                child:
                    _buildPersonalDetailCard('🏫 University', 'CCS University'),
              ),
            ],
          ),
          SizedBox(height: defaultPadding / 2),
          Row(
            children: [
              Expanded(
                child: _buildPersonalDetailCard('🏢 Company', 'W2S Infotech'),
              ),
              SizedBox(width: defaultPadding / 2),
              Expanded(
                child: _buildPersonalDetailCard('⭐ Position', 'Sr. Developer'),
              ),
            ],
          ),
          SizedBox(height: defaultPadding / 2),
          Row(
            children: [
              Expanded(
                child: _buildPersonalDetailCard('👨‍💼 Father', 'Bablu Bhati'),
              ),
              SizedBox(width: defaultPadding / 2),
              Expanded(
                child: _buildPersonalDetailCard('👩‍🏫 Mother', 'Bimlesh'),
              ),
            ],
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child:
                    _buildPersonalDetailCard('👤 Full Name', 'Shivank Bhati'),
              ),
              SizedBox(width: defaultPadding),
              Expanded(
                child: _buildPersonalDetailCard(
                    '💼 Profession', 'Software Engineer'),
              ),
              SizedBox(width: defaultPadding),
              Expanded(
                child: _buildPersonalDetailCard('📅 Age', '23 Years'),
              ),
            ],
          ),
          SizedBox(height: defaultPadding),
          Row(
            children: [
              Expanded(
                child: _buildPersonalDetailCard('👰 Marital Status', 'Married'),
              ),
              SizedBox(width: defaultPadding),
              Expanded(
                child: _buildPersonalDetailCard(
                    '🎓 Qualification', 'BSc Computer Science'),
              ),
              SizedBox(width: defaultPadding),
              Expanded(
                child: _buildPersonalDetailCard(
                    '🏫 University', 'Chudhary Charan Singh'),
              ),
            ],
          ),
          SizedBox(height: defaultPadding),
          Row(
            children: [
              Expanded(
                child: _buildPersonalDetailCard(
                    '🏢 Current Company', 'W2S Infotech Meerut'),
              ),
              SizedBox(width: defaultPadding),
              Expanded(
                child: _buildPersonalDetailCard(
                    '⭐ Position', 'Senior Software Developer'),
              ),
              SizedBox(width: defaultPadding),
              Expanded(
                child: _buildPersonalDetailCard(
                    '👨‍💼 Father', 'Bablu Bhati (Farmer)'),
              ),
            ],
          ),
          SizedBox(height: defaultPadding),
          Row(
            children: [
              Expanded(
                child: _buildPersonalDetailCard(
                    '👩‍🏫 Mother', 'Bimlesh (Teacher)'),
              ),
              SizedBox(width: defaultPadding),
              Expanded(
                child: SizedBox(),
              ),
              SizedBox(width: defaultPadding),
              Expanded(
                child: SizedBox(),
              ),
            ],
          ),
        ],
      );
    }
  }

  // ✅ PERSONAL DETAIL CARD WIDGET
  Widget _buildPersonalDetailCard(String label, String value) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
          isMobile ? defaultPadding * 0.6 : defaultPadding * 0.8),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[800]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.blue[400],
              fontWeight: FontWeight.w600,
              fontSize: isMobile ? 25 : 12,
            ),
          ),
          SizedBox(height: defaultPadding / 3),
          Text(
            value,
            style: TextStyle(
              color: Colors.grey[300],
              fontSize: isMobile ? 25 : 13,
              fontWeight: FontWeight.w500,
              height: 1.3,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // ✅ ENHANCED JOURNEY SECTION WITH YEAR SELECTOR
  Widget _buildJourneySection() {
    return _JourneySectionWidget();
  }

  // ✅ ACADEMIC SECTION
  Widget _buildAcademicSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: defaultPadding * 3),
        _buildSectionTitle('Academic Background'),
        SizedBox(height: defaultPadding * 2),
        _buildEducationCard(
          'Bachelor of Science',
          'Computer Science',
          'Chudhary Charan Singh University Meerut',
          '2020 - 2023',
          details: [
            'Self-taught all programming concepts',
            'Mobile development and full-stack focus',
          ],
        ),
        _buildEducationCard(
          '12th Grade',
          'Science (PCM)',
          'Mulana Azad Inter College Lalyana Meerut',
          '2016 - 2018',
          details: [
            'Motivation for engineering',
            'Strong commitment made',
          ],
        ),
        _buildEducationCard(
          '10th Grade',
          'Mathematics & Science',
          'Vandana inter College Narangpur Meerut',
          '2014 - 2016',
          details: [
            'Passout: May 3, 2016',
            'Strong foundation built',
          ],
        ),
        SizedBox(height: defaultPadding * 3),
      ],
    );
  }

  // ✅ SKILLS SECTION
  Widget _buildSkillsSection() {
    final isMobile = Responsive.isMobile(context);
    final skills = {
      '📱 Mobile': ['Flutter', 'Android (Java/Kotlin)', 'Native', 'UI/UX'],
      '🔧 Backend': ['Node.js', 'MongoDB', 'REST APIs', 'JWT Auth'],
      '💻 Languages': ['Java', 'Dart', 'JavaScript', 'C++', 'C', 'SQL'],
      '🛠️ Tools': ['Git/GitHub', 'VS Code', 'Android Studio', 'Firebase'],
      '🧠 Soft Skills': [
        'Problem Solving',
        'Leadership',
        'Communication',
        'Mentoring'
      ],
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: defaultPadding * 3),
        _buildSectionTitle('Technical Skills'),
        SizedBox(height: defaultPadding * 2),
        ...skills.entries.map((entry) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                entry.key,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.blue,
                  fontSize: isMobile ? 14 : 15,
                ),
              ),
              SizedBox(height: defaultPadding / 2),
              Wrap(
                spacing: isMobile ? defaultPadding / 3 : defaultPadding / 2,
                runSpacing: isMobile ? defaultPadding / 3 : defaultPadding / 2,
                children: entry.value.map((skill) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                      horizontal:
                          isMobile ? defaultPadding / 2 : defaultPadding / 1.5,
                      vertical:
                          isMobile ? defaultPadding / 4 : defaultPadding / 3,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.15),
                      border: Border.all(color: Colors.blue.withOpacity(0.4)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      skill,
                      style: TextStyle(
                        color: Colors.blue[300],
                        fontWeight: FontWeight.w500,
                        fontSize: isMobile ? 12 : 13,
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: defaultPadding),
            ],
          );
        }).toList(),
        SizedBox(height: defaultPadding * 3),
      ],
    );
  }

  // ✅ ACHIEVEMENTS SECTION
  Widget _buildAchievementsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Achievements'),
        SizedBox(height: defaultPadding * 2),
        _buildAchievementCard('2025', '🏆 Senior Software Developer',
            'W2S Infotech Meerut', 'Leading fintech projects with excellence'),
        _buildAchievementCard('2024', '🚀 Full-Stack Developer',
            'BitNBytes & Loginex', 'E-learning & E-commerce platforms'),
        _buildAchievementCard('2023', '⭐ Professional Career Launch',
            'W2S Company', 'Transitioned into tech industry'),
        _buildAchievementCard('2022', '🎯 Weather Forecasting App',
            'Class Best Project', 'First production Android application'),
        SizedBox(height: defaultPadding * 3),
      ],
    );
  }

  // ✅ HELPER WIDGETS
  Widget _buildSectionTitle(String title) {
    final isMobile = Responsive.isMobile(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isMobile ? 22 : 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: defaultPadding / 2),
        Container(
          height: 4,
          width: 80,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF36D1DC), Color(0xFF5B86E5)],
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }

  Widget _buildEducationCard(
    String degree,
    String field,
    String institution,
    String duration, {
    List<String>? details,
  }) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: defaultPadding),
      padding: EdgeInsets.all(isMobile ? defaultPadding : defaultPadding * 1.5),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
        border: Border(left: BorderSide(color: Colors.blue, width: 4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      degree,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: isMobile ? 14 : 16,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      field,
                      style: TextStyle(
                        color: Colors.blue[400],
                        fontSize: isMobile ? 12 : 14,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: defaultPadding / 2),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 8 : 12,
                  vertical: isMobile ? 4 : 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  duration,
                  style: TextStyle(
                    color: Colors.blue[300],
                    fontSize: isMobile ? 11 : 12,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: defaultPadding / 2),
          Text(
            institution,
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: isMobile ? 11 : 13,
            ),
          ),
          if (details != null && details.isNotEmpty) ...[
            SizedBox(height: defaultPadding / 2),
            ...details.map((detail) => Padding(
                  padding: EdgeInsets.only(bottom: defaultPadding / 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: defaultPadding / 4),
                        width: 3,
                        height: 3,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: defaultPadding / 3),
                      Expanded(
                        child: Text(
                          detail,
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: isMobile ? 11 : 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ],
      ),
    );
  }

  Widget _buildAchievementCard(
    String year,
    String title,
    String location,
    String description,
  ) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: defaultPadding),
      padding: EdgeInsets.all(isMobile ? defaultPadding : defaultPadding * 1.5),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade900, Colors.blue.shade800],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade700),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: isMobile ? 14 : 16,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      location,
                      style: TextStyle(
                        color: Colors.blue[200],
                        fontSize: isMobile ? 11 : 12,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: defaultPadding / 2),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 8 : 12,
                  vertical: isMobile ? 4 : 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.amber),
                ),
                child: Text(
                  year,
                  style: TextStyle(
                    color: Colors.amber,
                    fontWeight: FontWeight.bold,
                    fontSize: isMobile ? 11 : 12,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: defaultPadding / 2),
          Text(
            description,
            style: TextStyle(
              color: Colors.white70,
              fontSize: isMobile ? 12 : 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ✅ ENHANCED JOURNEY SECTION WIDGET
class _JourneySectionWidget extends StatefulWidget {
  const _JourneySectionWidget();

  @override
  State<_JourneySectionWidget> createState() => _JourneySectionWidgetState();
}

class _JourneySectionWidgetState extends State<_JourneySectionWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  int selectedYear = 2002;

  // ✅ JOURNEY DATA - Organized by Year with Months
  final Map<int, List<Map<String, dynamic>>> journeyByYear = {
    2002: [
      {
        'month': 'March 19',
        'title': 'Birth & Beginning',
        'desc':
            'Born in Dayalpur Village, Meerut District. A small rural village where technology was scarce but dreams were unlimited.',
        'icon': Icons.cake,
        'color': Colors.red,
      },
    ],
    2005: [
      {
        'month': 'March',
        'title': 'Primary Education Begins',
        'desc':
            'Joined Village Government Hindi Medium School. Foundation of formal learning in a resource-limited environment.',
        'icon': Icons.school,
        'color': Colors.blue,
      },
    ],
    2010: [
      {
        'month': 'Throughout Year',
        'title': 'First Technology Interest',
        'desc':
            'Developed passion for building machines and electrical gadgets. Father couldn\'t support due to financial constraints, but curiosity was born.',
        'icon': Icons.electrical_services,
        'color': Colors.yellow,
      },
    ],
    2011: [
      {
        'month': 'March',
        'title': 'School Change & "Engineer" Title',
        'desc':
            'Switched to K.A. Public School (English Medium). Saw first computer - life-changing moment. Friends called me "Engineer" due to technical skills.',
        'icon': Icons.computer,
        'color': Colors.purple,
      },
    ],
    2014: [
      {
        'month': 'March',
        'title': 'School Migration',
        'desc':
            'Changed school again due to administrative closure. Started learning more systematically.',
        'icon': Icons.directions,
        'color': Colors.teal,
      },
      {
        'month': 'October',
        'title': 'First Personal Computer',
        'desc':
            'Got first PC with 1GB RAM. Conducted hardware experiments, learned repair, saved father\'s money. Converted tractor to electric tractor.',
        'icon': Icons.devices,
        'color': Colors.green,
      },
    ],
    2015: [
      {
        'month': 'April',
        'title': 'YouTube Channel Launch',
        'desc':
            'Purchased first touchscreen phone. Started YouTube channel "SB Technology" with custom-designed logo.',
        'icon': Icons.video_camera_front,
        'color': Colors.red,
      },
      {
        'month': 'June',
        'title': 'First Channel Blocked',
        'desc':
            'Channel blocked due to copyright strikes. Learned about content creation and intellectual property.',
        'icon': Icons.block,
        'color': Colors.orange,
      },
    ],
    2016: [
      {
        'month': 'September',
        'title': 'Coding Journey Begins',
        'desc':
            'Got Jio SIM and 4G phone. Watched first coding tutorial on YouTube. Life-changing moment discovering programming possibilities.',
        'icon': Icons.code,
        'color': Colors.blue,
      },
      {
        'month': 'December',
        'title': 'First UI Application',
        'desc':
            'Created first Native Window UI application. Followed video tutorials, learned fundamentals of GUI development.',
        'icon': Icons.app_shortcut,
        'color': Colors.cyan,
      },
      {
        'month': 'May 3',
        'title': 'High School Passout',
        'desc':
            'Successfully completed high school. Marked end of formal school education and start of focused tech journey.',
        'icon': Icons.school,
        'color': Colors.green,
      },
    ],
    2017: [
      {
        'month': 'January - October',
        'title': '11th Class Academics',
        'desc':
            'Improved performance in Mathematics, Physics, and Chemistry. Developed strong foundation in core subjects.',
        'icon': Icons.book,
        'color': Colors.indigo,
      },
      {
        'month': 'November',
        'title': 'Electronics & EdTech Discovery',
        'desc':
            'Started watching educational technology YouTube channels. Discovered passion for electronics and embedded systems.',
        'icon': Icons.science,
        'color': Colors.yellow,
      },
    ],
    2018: [
      {
        'month': 'January - April',
        'title': '12th Class Preparation',
        'desc':
            'Focused on board exam preparation while maintaining interest in electronics.',
        'icon': Icons.edit,
        'color': Colors.lightBlue,
      },
      {
        'month': 'May',
        'title': 'Board Exam Results',
        'desc':
            'Results were disappointing. Family disappointed but dream of becoming engineer remained strong.',
        'icon': Icons.trending_down,
        'color': Colors.red,
      },
      {
        'month': 'June',
        'title': 'Robotics Research Phase',
        'desc':
            'Started researching how to learn robotics through YouTube. Discovered importance of English language skills.',
        'icon': Icons.psychology,
        'color': Colors.purple,
      },
      {
        'month': 'July',
        'title': 'Decision: One Year Drop',
        'desc':
            'Made crucial decision to take one-year drop for focused preparation. Joined IIT coaching center.',
        'icon': Icons.trending_up,
        'color': Colors.green,
      },
      {
        'month': 'September - December',
        'title': 'Coaching & Language Transition',
        'desc':
            'Joined coaching for JEE. Transitioned from Hindi to English medium education. Faced challenges with language barrier.',
        'icon': Icons.school,
        'color': Colors.blue,
      },
    ],
    2019: [
      {
        'month': 'April',
        'title': 'JEE Mains Exam',
        'desc':
            'Appeared for JEE Mains examination. Scored 82 Percentile. Could not secure admission in top colleges.',
        'icon': Icons.assessment,
        'color': Colors.orange,
      },
      {
        'month': 'June',
        'title': 'BSc Mathematics Admission',
        'desc':
            'Admitted to BSc Mathematics program. Struggled due to lack of focus and college infrastructure.',
        'icon': Icons.school,
        'color': Colors.teal,
      },
      {
        'month': 'December',
        'title': 'Failed First Year',
        'desc':
            'Failed first year BSc Mathematics. Decision point: Continue or change stream.',
        'icon': Icons.info,
        'color': Colors.red,
      },
    ],
    2020: [
      {
        'month': 'April',
        'title': 'BSc Computer Science Admission',
        'desc':
            'Changed to BSc Computer Science program. Decided to take control of learning independently.',
        'icon': Icons.computer,
        'color': Colors.blue,
      },
      {
        'month': 'January',
        'title': 'C Language Learning',
        'desc':
            'Started learning C programming from CodeWithHarry YouTube channel. Used VS Code and Android Studio.',
        'icon': Icons.code,
        'color': Colors.cyan,
      },
      {
        'month': 'February',
        'title': 'GitHub Profile Created',
        'desc':
            'Created GitHub account (shivank47). Started version control and open-source journey.',
        'icon': Icons.computer,
        'color': Colors.purple,
      },
      {
        'month': 'June',
        'title': 'C++ Language & Competitive Programming',
        'desc':
            'Learned C++ from college curriculum. Started competitive programming on LeetCode for daily practice.',
        'icon': Icons.trending_up,
        'color': Colors.green,
      },
      {
        'month': 'August',
        'title': 'Android Development Deep Dive',
        'desc':
            'Focused on Android development. Realized importance of Android for robotics and IoT projects.',
        'icon': Icons.android,
        'color': Colors.lightGreen,
      },
    ],
    2021: [
      {
        'month': 'August',
        'title': 'First Professional Job',
        'desc':
            'Joined Honda Service Center, Greater Noida as Billing Operator and Store In-Charge. First real-world work experience.',
        'icon': Icons.work,
        'color': Colors.blue,
      },
      {
        'month': 'December 2',
        'title': 'Marriage Milestone',
        'desc':
            'Got married on December 2, 2021. Major life event while building career.',
        'icon': Icons.favorite,
        'color': Colors.pink,
      },
    ],
    2022: [
      {
        'month': 'January',
        'title': 'Job Exit & Focus Shift',
        'desc':
            'Left job after 4 months to focus on education and skill development. Prioritized learning over immediate income.',
        'icon': Icons.exit_to_app,
        'color': Colors.amber,
      },
      {
        'month': 'January 28',
        'title': 'Teaching Career Begins',
        'desc':
            'Started as Science Teacher. Taught Mathematics, Physics, and Science to intermediate students.',
        'icon': Icons.book,
        'color': Colors.indigo,
      },
      {
        'month': 'June',
        'title': 'Java & Android Development',
        'desc':
            'Learned Java language. Started native Android development. Created multiple projects for portfolio.',
        'icon': Icons.android,
        'color': Colors.lightGreen,
      },
      {
        'month': 'December',
        'title': 'Weather App Project',
        'desc':
            'Created Java-based Weather Forecasting Native Android App. Won "Best Project" award in college.',
        'icon': Icons.cloud,
        'color': Colors.blue,
      },
    ],
    2023: [
      {
        'month': 'January',
        'title': 'Teaching Exit',
        'desc':
            'Left teaching position. Decided to focus full-time on technology career.',
        'icon': Icons.exit_to_app,
        'color': Colors.orange,
      },
      {
        'month': 'January - June',
        'title': 'Job Fair & Networking',
        'desc':
            'Participated in government-organized job fairs. Started building professional network.',
        'icon': Icons.people,
        'color': Colors.purple,
      },
      {
        'month': 'July',
        'title': 'W2S Company Approach',
        'desc':
            'Recruited by W2S Company through job fair. Started as full-time mobile developer.',
        'icon': Icons.trending_up,
        'color': Colors.green,
      },
      {
        'month': 'Throughout Year',
        'title': 'Freelancing Started',
        'desc':
            'Started freelancing with Modernisum.com. Worked on contract-based projects. Gained diverse client experience.',
        'icon': Icons.computer,
        'color': Colors.cyan,
      },
    ],
    2024: [
      {
        'month': 'January 25',
        'title': 'Dream Project: School Management System',
        'desc':
            'Started dream project - School Management System. Complete full-stack development with database design.',
        'icon': Icons.assignment,
        'color': Colors.blue,
      },
      {
        'month': 'June',
        'title': 'E-Learning App Development',
        'desc':
            'Built comprehensive e-learning application for BitNBytes. Implemented modern UI/UX patterns.',
        'icon': Icons.school,
        'color': Colors.lightBlue,
      },
      {
        'month': 'June',
        'title': 'E-Commerce Platform',
        'desc':
            'Developed e-commerce platform for Loginex. Implemented shopping cart, payments, and inventory management.',
        'icon': Icons.shopping_cart,
        'color': Colors.green,
      },
      {
        'month': 'Throughout Year',
        'title': 'Full-Stack Technology Learning',
        'desc':
            'Learned Node.js backend development. Mastered MongoDB database. Expanded Flutter knowledge. Became true full-stack developer.',
        'icon': Icons.layers,
        'color': Colors.purple,
      },
    ],
    2025: [
      {
        'month': 'February',
        'title': 'Senior Developer Promotion',
        'desc':
            'Promoted to Senior Mobile Developer position. Now leading multiple projects and mentoring junior developers.',
        'icon': Icons.trending_up,
        'color': Colors.green,
      },
      {
        'month': 'Throughout Year',
        'title': 'Senimi Fintech App',
        'desc':
            'Solo developed Senimi - a major fintech application. Implemented complete financial features, security, and UI.',
        'icon': Icons.payment,
        'color': Colors.blue,
      },
      {
        'month': 'Ongoing',
        'title': 'Leadership & Mentorship',
        'desc':
            'Leading multiple projects. Mentoring junior developers. Continuous growth and knowledge sharing.',
        'icon': Icons.star,
        'color': Colors.amber,
      },
    ],
  };

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final years = journeyByYear.keys.toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: defaultPadding * 3),
        _buildSectionTitle('My Professional Journey'),
        SizedBox(height: defaultPadding * 2),

        // ✅ YEAR SELECTOR
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: isMobile ? defaultPadding / 2 : defaultPadding),
            child: Column(
              children: List.generate(years.length, (index) {
                final year = years[index];
                final isSelected = selectedYear == year;

                return Padding(
                  padding: EdgeInsets.only(right: defaultPadding / 2),
                  child: GestureDetector(
                    onTap: () {
                      setState(() => selectedYear = year);
                      _animationController.forward(from: 0.0);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: EdgeInsets.symmetric(
                        horizontal: defaultPadding / 1.5,
                        vertical: defaultPadding / 2,
                      ),
                      decoration: BoxDecoration(
                        gradient: isSelected
                            ? const LinearGradient(
                                colors: [Color(0xFF36D1DC), Color(0xFF5B86E5)],
                              )
                            : null,
                        color: isSelected ? null : Colors.grey[900],
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected
                              ? Colors.transparent
                              : Colors.grey[800]!,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color:
                                      const Color(0xFF5B86E5).withOpacity(0.5),
                                  blurRadius: 15,
                                  offset: const Offset(0, 4),
                                ),
                              ]
                            : [],
                      ),
                      child: Text(
                        year.toString(),
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.grey[400],
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.w500,
                          fontSize: isMobile ? 12 : 13,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
        SizedBox(height: defaultPadding * 2),

        // ✅ TIMELINE FOR SELECTED YEAR
        Column(
          children: List.generate(
            (journeyByYear[selectedYear] ?? []).length,
            (index) {
              final event = journeyByYear[selectedYear]![index];
              final isLast =
                  index == (journeyByYear[selectedYear] ?? []).length - 1;

              return ScaleTransition(
                scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                  CurvedAnimation(
                      parent: _animationController, curve: Curves.easeOut),
                ),
                child: FadeTransition(
                  opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                        parent: _animationController, curve: Curves.easeOut),
                  ),
                  child: _buildTimelineItem(
                    month: event['month'] as String,
                    title: event['title'] as String,
                    description: event['desc'] as String,
                    icon: event['icon'] as IconData,
                    color: event['color'] as Color,
                    isLast: isLast,
                    isMobile: isMobile,
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: defaultPadding * 3),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    final isMobile = Responsive.isMobile(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isMobile ? 22 : 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: defaultPadding / 2),
        Container(
          height: 4,
          width: 80,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF36D1DC), Color(0xFF5B86E5)],
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineItem({
    required String month,
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required bool isLast,
    required bool isMobile,
  }) {
    final iconSize = isMobile ? 40.0 : 50.0;
    final lineHeight = isMobile ? 100.0 : 150.0;

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: iconSize,
                  height: iconSize,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [color, color.withOpacity(0.7)],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: color.withOpacity(0.5),
                        blurRadius: 15,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      icon,
                      color: Colors.white,
                      size: isMobile ? 20 : 24,
                    ),
                  ),
                ),
                if (!isLast)
                  Container(
                    width: 3,
                    height: lineHeight,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [color, color.withOpacity(0.2)],
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(width: defaultPadding),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: defaultPadding / 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: defaultPadding / 2,
                        vertical: defaultPadding / 4,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [color, color.withOpacity(0.8)],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        month,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: isMobile ? 10 : 11,
                        ),
                      ),
                    ),
                    SizedBox(height: defaultPadding / 2),
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: color,
                        fontSize: isMobile ? 14 : 16,
                      ),
                    ),
                    SizedBox(height: defaultPadding / 3),
                    Container(
                      padding: EdgeInsets.all(defaultPadding),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        border: Border(
                          left: BorderSide(color: color, width: 4),
                        ),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: color.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        description,
                        style: TextStyle(
                          color: Colors.grey[300],
                          height: 1.6,
                          fontSize: isMobile ? 12 : 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        if (!isLast) SizedBox(height: defaultPadding * 1.5),
      ],
    );
  }
}
