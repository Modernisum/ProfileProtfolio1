// lib/view_model/getx_controllers/project_detail_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_portfolio/model/project_model.dart';

class ProjectDetailController extends GetxController {
  final Rx<Project?> selectedProject = Rx<Project?>(null);
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  /// Fetch project details by ID
  void fetchProjectDetails(String projectId) {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      // Simulate API call delay
      Future.delayed(const Duration(milliseconds: 500), () {
        // ✅ FIXED: Use projectList from model
        final project = _getProjectById(projectId);

        if (project != null) {
          selectedProject.value = project;
        } else {
          errorMessage.value = 'Project not found (ID: $projectId)';
        }
        isLoading.value = false;
      });
    } catch (e) {
      errorMessage.value = 'Error loading project: $e';
      isLoading.value = false;
    }
  }

  /// Get project by ID from projectList
  Project? _getProjectById(String id) {
    try {
      // ✅ FIXED: Search in actual projectList (from model)
      return projectList.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Get duration in readable format
  String getDurationString() {
    if (selectedProject.value == null) return '';
    final days = selectedProject.value!.totalDays;
    final months = (days / 30).toStringAsFixed(1);
    return '$days Days (~$months months)';
  }

  /// Get color based on project level
  Color getLevelColor() {
    switch (selectedProject.value?.projectLevel) {
      case 'Beginner':
        return Colors.green;
      case 'Intermediate':
        return Colors.orange;
      case 'Advanced':
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  @override
  void onClose() {
    selectedProject.close();
    isLoading.close();
    errorMessage.close();
    super.onClose();
  }
}
