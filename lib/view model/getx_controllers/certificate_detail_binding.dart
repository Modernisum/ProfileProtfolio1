// lib/view_model/getx_controllers/project_detail_binding.dart

import 'package:get/get.dart';
import 'package:flutter_portfolio/view model/getx_controllers/certificate_detail_controller.dart';

class CertificateDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CertificateDetailController>(
      () => CertificateDetailController(),
    );
  }
}
