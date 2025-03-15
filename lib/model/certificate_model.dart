class CertificateModel {
  final String name;
  final String organization;
  final String date;
  final String skills;
  final String credential;

  CertificateModel({
    required this.name,
    required this.organization,
    required this.date,
    required this.skills,
    required this.credential,
  });
}

List<CertificateModel> certificateList = [
  CertificateModel(
    name: 'Dart Programing',
    organization: 'Infoys',
    date: 'Mar 2025',
    skills: 'Flutter . Dart',
    credential:
        'https://infyspringboard.onwingspan.com/public-assets/infosysheadstart/cert/lex_auth_0130086701657047041342_shared/1-e4a500b0-d2bc-4512-b099-765944f001b7.pdf',
  ),
  CertificateModel(
    name: 'Flutter and Backends: Integrating Flutter with Google Firebase',
    organization: 'Skilsoft',
    date: 'Mar 2025',
    skills: 'Flutter . iOS Development . Android Development',
    credential:
        'https://skillsoft.digitalbadges.skillsoft.com/a7a0e15e-cac2-4143-bd24-c3a77d302858#acc.8uATP7gz',
  ),
  CertificateModel(
    name: 'Ace Bages',
    organization: 'Infosys',
    date: 'Mar 2025',
    skills: 'Flutter . Dart . Programming',
    credential:
        'https://gameconfig.onwingspan.com/Gamification/GetBadgeImage/?AppId=53243&TokenNo=O55WBL7J2F&BadgeCode=5W5G76DYM6',
  ),
];
