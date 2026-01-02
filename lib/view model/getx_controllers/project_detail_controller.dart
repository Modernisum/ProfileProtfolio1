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
        // Get project from list (in real app, fetch from API/database)
        final project = _getProjectById(projectId);

        if (project != null) {
          selectedProject.value = project;
        } else {
          errorMessage.value = 'Project not found';
        }
        isLoading.value = false;
      });
    } catch (e) {
      errorMessage.value = 'Error loading project: $e';
      isLoading.value = false;
    }
  }

  /// Get project by ID (replace with API call)
  Project? _getProjectById(String id) {
    final projectsList = _getAllProjects();
    try {
      return projectsList.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Mock data - replace with real API
  List<Project> _getAllProjects() {
    return [
      Project(
        id: '1',
        name: 'Modern School',
        category: 'College Projects',
        idea:
            'A comprehensive school management system with attendance, grades, and communication features for teachers, students, and parents.',
        benefits:
            'Streamlines school operations, improves communication between school and parents, reduces paper work, real-time grade updates.',
        startDate: '2023-06-01',
        completeDate: '2023-09-15',
        skillsUsed: [
          'Flutter',
          'Dart',
          'GetX',
          'Provider',
          'Responsive Design'
        ],
        technologies: [
          'Firebase',
          'Firestore',
          'Cloud Functions',
          'Authentication'
        ],
        learning:
            'Learned state management with GetX, Firebase integration, real-time database operations, and complex UI patterns.',
        accessLink: 'https://github.com/yourname/modern-school',
        screenshots: [
          'https://via.placeholder.com/400x300?text=Login+Screen',
          'https://via.placeholder.com/400x300?text=Dashboard',
          'https://via.placeholder.com/400x300?text=Grades',
          'https://via.placeholder.com/400x300?text=Attendance',
        ],
        demoVideoLink: 'https://www.youtube.com/embed/dQw4w9WgXcQ',
        review:
            'A fully functional school management application with complete CRUD operations, real-time updates, and role-based access control.',
        problemsFaced:
            'Implementing real-time sync across multiple devices, optimizing Firebase queries for performance, handling offline data synchronization.',
        totalDays: 106,
        projectLevel: 'Intermediate',
        imageUrl: 'https://via.placeholder.com/300x200?text=Modern+School',
      ),
      Project(
        id: '2',
        name: 'Chat Application',
        category: 'Personal Projects',
        idea:
            'Real-time messaging application with group chat, file sharing, and WebRTC video calling capabilities.',
        benefits:
            'Enable seamless communication between users, support group conversations, file sharing for documents and media.',
        startDate: '2023-10-01',
        completeDate: '2023-12-20',
        skillsUsed: ['Flutter', 'Dart', 'GetX', 'WebRTC', 'Node.js'],
        technologies: [
          'Firebase Realtime Database',
          'Firebase Storage',
          'Socket.io',
          'WebRTC'
        ],
        learning:
            'Mastered WebRTC implementation, real-time messaging architecture, handling multimedia in Flutter.',
        accessLink: 'https://github.com/yourname/chat-app',
        screenshots: [
          'https://via.placeholder.com/400x300?text=Chat+List',
          'https://via.placeholder.com/400x300?text=Chat+Screen',
          'https://via.placeholder.com/400x300?text=Group+Chat',
          'https://via.placeholder.com/400x300?text=Video+Call',
        ],
        demoVideoLink: 'https://www.youtube.com/embed/dQw4w9WgXcQ',
        review:
            'Feature-rich chat application with one-to-one messaging, group chats, file sharing, and video calling.',
        problemsFaced:
            'Managing WebRTC connections, handling large file uploads efficiently, maintaining message sync across devices.',
        totalDays: 81,
        projectLevel: 'Advanced',
        imageUrl: 'https://via.placeholder.com/300x200?text=Chat+App',
      ),
      Project(
        id: '3',
        name: 'E-Commerce Store',
        category: 'Company Projects',
        idea:
            'Full-featured e-commerce application with product catalog, shopping cart, payment integration, and order tracking.',
        benefits:
            'Enables online selling, manages inventory, processes payments securely, tracks orders in real-time.',
        startDate: '2023-03-01',
        completeDate: '2023-07-30',
        skillsUsed: ['Flutter', 'Dart', 'GetX', 'Stripe', 'UI/UX Design'],
        technologies: [
          'Firebase',
          'Stripe Payment',
          'Node.js Backend',
          'MongoDB'
        ],
        learning:
            'Payment gateway integration, inventory management, order processing, advanced UI patterns for e-commerce.',
        accessLink: 'https://github.com/yourname/ecommerce-store',
        screenshots: [
          'https://via.placeholder.com/400x300?text=Home+Screen',
          'https://via.placeholder.com/400x300?text=Product+Details',
          'https://via.placeholder.com/400x300?text=Shopping+Cart',
          'https://via.placeholder.com/400x300?text=Checkout',
        ],
        demoVideoLink: 'https://www.youtube.com/embed/dQw4w9WgXcQ',
        review:
            'Complete e-commerce solution with product search, filtering, secure checkout, and order management system.',
        problemsFaced:
            'Integrating Stripe payment securely, handling large product catalogs with pagination, managing cart state efficiently.',
        totalDays: 121,
        projectLevel: 'Advanced',
        imageUrl: 'https://via.placeholder.com/300x200?text=E-Commerce',
      ),
    ];
  }

  /// Get duration in readable format
  String getDurationString() {
    if (selectedProject.value == null) return '';
    final days = selectedProject.value!.totalDays;
    final months = (days / 30).toStringAsFixed(1);
    return '$days Days (~$months months)';
  }

  /// Get color based on project level
  dynamic getLevelColor() {
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
