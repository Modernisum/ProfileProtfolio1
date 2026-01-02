// lib/view_model/getx_controllers/project_detail_binding.dart

import 'package:get/get.dart';
import 'package:flutter_portfolio/view model/getx_controllers/project_detail_controller.dart';

class ProjectDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProjectDetailController>(
      () => ProjectDetailController(),
    );
  }
}
