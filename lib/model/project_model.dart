class Project {
  final String name;
  final String description;
  final String image;
  final String link;
  Project(this.name, this.description, this.image, this.link);
}

List<Project> projectList = [
  Project(
    'Modernisum',
    '"Modernisum" - We empower local businesses with advanced tech, driving growth and modernization through innovative digital solutions.',
    'assets/images/image.png',
    'https://modernisum.com/',
  ),
  Project(
    'Modern School',
    'Our vision is to build a traditional school foundation and transform it into a modern, innovative institution using Flutter web and mobile apps, alongside advanced digital tools for education.',
    'assets/images/modernschool.jpg',
    'https://modernschool-e873a.web.app',
  ),
  Project(
    'Modern Chat ',
    'Modern Chat is an advanced messaging application featuring real-time chat and AI chatbot capabilities. It is developed using Flutter for UI, Firebase for backend services, and Gemini AI API for smart interactions.',
    'assets/images/icon.png',
    '',
  ),
  Project(
    'Modern Portfolio ',
    'Modern Chat is an advanced messaging application featuring real-time chat and AI chatbot capabilities. It is developed using Flutter for UI, Firebase for backend services, and Gemini AI API for smart interactions.',
    'assets/images/image1.png',
    '',
  ),
];
