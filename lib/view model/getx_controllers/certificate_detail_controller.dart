// lib/view_model/getx_controllers/project_detail_controller.dart

import 'package:flutter/material.dart';
import 'package:flutter_portfolio/model/certificate_model.dart';
import 'package:get/get.dart';

class CertificateDetailController extends GetxController {
  final Rx<Certificate?> selectedCertificate = Rx<Certificate?>(null);
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  /// Fetch certificate details by ID
  void fetchCertificateDetails(String certificateId) {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      // Simulate API call delay
      Future.delayed(const Duration(milliseconds: 500), () {
        // ✅ FIXED: Use certificateList from model
        final certificate = _getCertificateById(certificateId);

        if (certificate != null) {
          selectedCertificate.value = certificate;
        } else {
          errorMessage.value = 'Certificate not found (ID: $certificateId)';
        }
        isLoading.value = false;
      });
    } catch (e) {
      errorMessage.value = 'Error loading certificate: $e';
      isLoading.value = false;
    }
  }

  /// Get certificate by ID from certificateList
  Certificate? _getCertificateById(String id) {
    try {
      // ✅ FIXED: Search in actual certificateList (from model)
      return certificateList.firstWhere((c) => c.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Get duration in readable format
  String getDurationString() {
    if (selectedCertificate.value == null) return '';
    final days = selectedCertificate.value!.totalDays;
    final months = (days / 30).toStringAsFixed(1);
    return '$days Days (~$months months)';
  }

  /// Get color based on certificate level
  Color getLevelColor() {
    switch (selectedCertificate.value?.certificateLevel) {
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
    selectedCertificate.close();
    isLoading.close();
    errorMessage.close();
    super.onClose();
  }
}
