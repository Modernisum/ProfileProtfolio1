import 'package:flutter/material.dart';
import 'package:flutter_portfolio/res/constants.dart';
import 'package:flutter_portfolio/view%20model/getx_controllers/certificate_detail_binding.dart';
import 'package:flutter_portfolio/view%20model/getx_controllers/project_detail_binding.dart';
import 'package:flutter_portfolio/view/certifications/components/certificate_page.dart';
import 'package:flutter_portfolio/view/home/home.dart';
import 'package:flutter_portfolio/view/projects/components/projects_details.dart'; // ✅ Keep
import 'package:get/get.dart'; // ✅ Simplified import
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // ✅ Modern super.key

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shivank Profile',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: bgColor,
        useMaterial3: true,
        textTheme: GoogleFonts.openSansTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white)
            .copyWith(
              bodyLarge: const TextStyle(color: bodyTextColor),
              bodyMedium: const TextStyle(color: bodyTextColor),
            ),
      ),

      // ✅ COMPLETE ROUTES
      getPages: [
        GetPage(
          name: '/',
          page: () => const HomePage(),
        ),
        GetPage(
          name: '/certificate-details',
          page: () {
            final certificateId = Get.arguments as String? ?? '';
            return CertificateDetailsView(certificateId: certificateId);
          },
          binding: CertificateDetailBinding(),
        ),
        GetPage(
          name: '/project-details',
          page: () {
            final projectId = Get.arguments as String? ?? '';
            return ProjectDetailsView(projectId: projectId);
          },
          binding: ProjectDetailBinding(),
        ),
      ],

      // ✅ Default home route
      home: const HomePage(),
      initialRoute: '/',
    );
  }
}
