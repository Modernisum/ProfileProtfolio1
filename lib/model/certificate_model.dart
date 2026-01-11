class Certificate {
  final String id;
  final String name;
  final String organization;
  final List<String> skillsUsed;
  final String benefits;
  final String startDate;
  final String completeDate;
  final List<String> technologies;
  final String learning;
  final String accessLink;
  final List<String> screenshots;
  final String demoVideoLink;
  final String review;
  final String problemsFaced;
  final int totalDays;
  final String certificateLevel;
  final String imageUrl;

  Certificate({
    this.id = '',
    this.name = '',
    this.organization = '',
    this.skillsUsed = const [],
    this.benefits = '',
    this.startDate = '2000-01-01', // ✅ FIXED: No const
    this.completeDate = '2000-01-01', // ✅ FIXED: No const
    this.technologies = const [],
    this.learning = '',
    this.accessLink = '',
    this.screenshots = const [],
    this.demoVideoLink = '',
    this.review = '',
    this.problemsFaced = '',
    this.totalDays = 0,
    this.certificateLevel = '',
    this.imageUrl = '',
  });
}

var certificateList = [
  Certificate(
    id: '1',
    name: 'Modernisum',
    organization: 'Modernisum Pvt Ltd',
    skillsUsed: ['DART'],
    benefits:
        'Transforms traditional businesses into digital-first operations, increases online presence, streamlines operations, improves customer engagement.',
    startDate: "2023-12-01",
    completeDate: "2024-05-16",
    technologies: ['Flutter Web', 'Node.js', 'MongoDB', 'Firebase', 'AWS'],
    learning:
        'Full-stack development with Flutter web, scalable backend architecture, business transformation strategies, client management.',
    accessLink: 'https://modernisum.com/',
    screenshots: [
      'https://via.placeholder.com/400x300?text=Modernisum+Dashboard',
      'https://via.placeholder.com/400x300?text=Business+Analytics',
      'https://via.placeholder.com/400x300?text=Customer+Portal',
      'https://via.placeholder.com/400x300?text=Admin+Panel',
    ],
    demoVideoLink: 'https://www.youtube.com/embed/demo-modernisum',
    review:
        'Comprehensive business modernization platform with analytics, customer management, and digital transformation tools.',
    problemsFaced:
        'Integrating multiple business APIs, handling diverse business requirements, ensuring cross-browser compatibility.',
    totalDays: 167,
    certificateLevel: 'Advanced',
    imageUrl: 'assets/images/image.png',
  ),
  Certificate(
    id: '2',
    name: 'Modernisum',
    organization: 'Modernisum Pvt Ltd',
    skillsUsed: ['DART'],
    benefits:
        'Transforms traditional businesses into digital-first operations, increases online presence, streamlines operations, improves customer engagement.',
    startDate: "2023-12-01",
    completeDate: "2024-05-16",
    technologies: ['Flutter Web', 'Node.js', 'MongoDB', 'Firebase', 'AWS'],
    learning:
        'Full-stack development with Flutter web, scalable backend architecture, business transformation strategies, client management.',
    accessLink: 'https://modernisum.com/',
    screenshots: [
      'https://via.placeholder.com/400x300?text=Modernisum+Dashboard',
      'https://via.placeholder.com/400x300?text=Business+Analytics',
      'https://via.placeholder.com/400x300?text=Customer+Portal',
      'https://via.placeholder.com/400x300?text=Admin+Panel',
    ],
    demoVideoLink: 'https://www.youtube.com/embed/demo-modernisum',
    review:
        'Comprehensive business modernization platform with analytics, customer management, and digital transformation tools.',
    problemsFaced:
        'Integrating multiple business APIs, handling diverse business requirements, ensuring cross-browser compatibility.',
    totalDays: 167,
    certificateLevel: 'Advanced',
    imageUrl: 'assets/images/image.png',
  ),
  Certificate(
    id: '3',
    name: 'Modernisum',
    organization: 'Modernisum Pvt Ltd',
    skillsUsed: ['DART'],
    benefits:
        'Transforms traditional businesses into digital-first operations, increases online presence, streamlines operations, improves customer engagement.',
    startDate: "2023-12-01",
    completeDate: "2024-05-16",
    technologies: ['Flutter Web', 'Node.js', 'MongoDB', 'Firebase', 'AWS'],
    learning:
        'Full-stack development with Flutter web, scalable backend architecture, business transformation strategies, client management.',
    accessLink: 'https://modernisum.com/',
    screenshots: [
      'https://via.placeholder.com/400x300?text=Modernisum+Dashboard',
      'https://via.placeholder.com/400x300?text=Business+Analytics',
      'https://via.placeholder.com/400x300?text=Customer+Portal',
      'https://via.placeholder.com/400x300?text=Admin+Panel',
    ],
    demoVideoLink: 'https://www.youtube.com/embed/demo-modernisum',
    review:
        'Comprehensive business modernization platform with analytics, customer management, and digital transformation tools.',
    problemsFaced:
        'Integrating multiple business APIs, handling diverse business requirements, ensuring cross-browser compatibility.',
    totalDays: 167,
    certificateLevel: 'Advanced',
    imageUrl: 'assets/images/image.png',
  ),
];
