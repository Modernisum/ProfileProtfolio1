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
    'SchoolManagement Apllication',
    'Our vision is to build a traditional school foundation and transform it into a modern, innovative institution using Flutter web and mobile apps, alongside advanced digital tools for education.',
    'assets/images/car.png',
    'sample-firebase-ai-app-200a6.web.app',
  ),
];
