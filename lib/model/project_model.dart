class Project {
  final String id;
  final String name;
  final String category;
  final String idea;
  final String benefits;
  final String startDate;
  final String completeDate;
  final List<String> skillsUsed;
  final List<String> technologies;
  final String learning;
  final String accessLink;
  final List<String> screenshots;
  final String demoVideoLink;
  final String review;
  final String problemsFaced;
  final int totalDays;
  final String projectLevel;
  final String imageUrl;

  Project({
    this.id = '',
    this.name = '',
    this.category = '',
    this.idea = '',
    this.benefits = '',
    this.startDate = '2000-01-01', // ✅ FIXED: No const
    this.completeDate = '2000-01-01', // ✅ FIXED: No const
    this.skillsUsed = const [],
    this.technologies = const [],
    this.learning = '',
    this.accessLink = '',
    this.screenshots = const [],
    this.demoVideoLink = '',
    this.review = '',
    this.problemsFaced = '',
    this.totalDays = 0,
    this.projectLevel = '',
    this.imageUrl = '',
  });
}

var projectList = [
  Project(
    id: '1',
    name: 'Modernisum',
    category: 'Company Projects',
    idea:
        'We empower local businesses with advanced tech, driving growth and modernization through innovative digital solutions.',
    benefits:
        'Transforms traditional businesses into digital-first operations, increases online presence, streamlines operations, improves customer engagement.',
    startDate: "2023-12-01",
    completeDate: "2024-05-16",
    skillsUsed: ['Flutter', 'Dart', 'Responsive Design', 'UI/UX', 'Full-Stack'],
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
    projectLevel: 'Advanced',
    imageUrl: 'assets/images/image.png',
  ),
  Project(
    id: '2',
    name: 'Modern School',
    category: 'College Projects',
    idea:
        'Comprehensive school management system with attendance, grades, and communication features for teachers, students, and parents.',
    benefits:
        'Streamlines school operations, improves communication between school and parents, reduces paperwork, real-time grade updates, attendance tracking.',
    startDate: "2023-06-01",
    completeDate: "2023-09-15",
    skillsUsed: ['Flutter', 'Dart', 'GetX', 'Provider', 'Responsive Design'],
    technologies: [
      'Firebase',
      'Firestore',
      'Cloud Functions',
      'Authentication'
    ],
    learning:
        'State management with GetX, Firebase integration, real-time database operations, complex UI patterns, role-based access control.',
    accessLink: 'https://modernschool-e873a.web.app',
    screenshots: [
      'https://via.placeholder.com/400x300?text=School+Login',
      'https://via.placeholder.com/400x300?text=Dashboard',
      'https://via.placeholder.com/400x300?text=Grades+Report',
      'https://via.placeholder.com/400x300?text=Attendance',
    ],
    demoVideoLink: 'https://www.youtube.com/embed/modern-school-demo',
    review:
        'Fully functional school management application with complete CRUD operations, real-time updates, and role-based access control.',
    problemsFaced:
        'Implementing real-time sync across multiple devices, optimizing Firebase queries, handling offline data synchronization.',
    totalDays: 106,
    projectLevel: 'Intermediate',
    imageUrl: 'assets/images/modernschool.jpg',
  ),
  Project(
    id: '3',
    name: 'Modern Chat',
    category: 'Personal Projects',
    idea:
        'Real-time messaging application with AI chatbot, group chat, file sharing, and smart conversation features.',
    benefits:
        'Seamless real-time communication, AI-powered assistance, group conversations, multimedia sharing, intelligent responses.',
    startDate: "2024-03-10",
    completeDate: "2024-05-25",
    skillsUsed: ['Flutter', 'Dart', 'GetX', 'WebRTC', 'AI Integration'],
    technologies: [
      'Firebase',
      'Gemini AI API',
      'Realtime Database',
      'Storage',
      'Socket.io'
    ],
    learning:
        'AI API integration with Gemini, real-time messaging architecture, handling multimedia in Flutter, advanced state management.',
    accessLink: '',
    screenshots: [
      'https://via.placeholder.com/400x300?text=Chat+Home',
      'https://via.placeholder.com/400x300?text=AI+Chatbot',
      'https://via.placeholder.com/400x300?text=Group+Chat',
      'https://via.placeholder.com/400x300?text=File+Sharing',
    ],
    demoVideoLink: 'https://www.youtube.com/embed/modern-chat-demo',
    review:
        'Advanced messaging app with AI chatbot capabilities, real-time chat, file sharing, and intelligent conversation features.',
    problemsFaced:
        'Integrating Gemini AI responses in real-time, managing chat history efficiently, handling large file uploads.',
    totalDays: 76,
    projectLevel: 'Advanced',
    imageUrl: 'assets/images/icon.png',
  ),
  Project(
    id: '4',
    name: 'Modern Portfolio',
    category: 'Personal Projects',
    idea:
        'Professional portfolio website showcasing Flutter expertise, projects, skills, and technical achievements with modern UI/UX.',
    benefits:
        'Professional online presence, showcase projects effectively, attract clients/employers, highlight technical skills and experience.',
    startDate: "2024-08-01",
    completeDate: "2024-09-30",
    skillsUsed: ['Flutter', 'Dart', 'Responsive Design', 'Animations', 'GetX'],
    technologies: [
      'Flutter Web',
      'Firebase',
      'Custom Animations',
      'Responsive Layouts'
    ],
    learning:
        'Advanced Flutter web animations, complex responsive layouts, performance optimization for web, portfolio optimization strategies.',
    accessLink: '',
    screenshots: [
      'https://via.placeholder.com/400x300?text=Portfolio+Home',
      'https://via.placeholder.com/400x300?text=Projects+Section',
      'https://via.placeholder.com/400x300?text=About+Me',
      'https://via.placeholder.com/400x300?text=Contact+Form',
    ],
    demoVideoLink: 'https://www.youtube.com/embed/portfolio-demo',
    review:
        'Modern, responsive portfolio showcasing Flutter development skills with smooth animations and professional design.',
    problemsFaced:
        'Creating complex scroll animations, optimizing web performance, ensuring cross-device compatibility, SEO optimization.',
    totalDays: 60,
    projectLevel: 'Intermediate',
    imageUrl: 'assets/images/image1.png',
  ),
];
