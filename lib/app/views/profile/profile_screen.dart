import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica_app/app/routes/app_pages.dart';
import 'package:medica_app/app/utils/colors.dart';
import 'package:medica_app/app/utils/image_path.dart';
import 'package:medica_app/app/views/profile/profile_controller.dart';
import 'package:medica_app/app/views/profile/widgets/reel_widget.dart';
import 'package:medica_app/app/views/reels/reel_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final reelController = Get.find<ReelController>();
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) {
        return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: AppColors.black),
                onPressed: () {
                  Get.back(); // Navigate back
                },
              ),
              title: const Text(
                'Profile',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: controller.isLoading
                ? const Center(child: CircularProgressIndicator())
                : controller.userData!.isAdmin
                    ? Column(
                        children: [
                          Text(
                            'Admin',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildMenuOption(Icons.history, 'Manage Appointments',
                              () => Get.toNamed(Routes.manageAppointments)),
                          _buildMenuOption(Icons.history, 'Manage Doctors',
                              () => Get.toNamed(Routes.manageDoctors)),
                          _buildMenuOption(Icons.logout, 'Logout',
                              () => controller.signOutUser()),
                        ],
                      )
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 20),

                            GestureDetector(
                              onTap: () => controller.pickProfileImage(),
                              child: Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 50,
                                    backgroundImage: controller
                                                    .userData?.profileImage !=
                                                null &&
                                            controller.userData!.profileImage
                                                .isNotEmpty &&
                                            !controller.userData!.profileImage
                                                .startsWith('/')
                                        ? NetworkImage(
                                            controller.userData!.profileImage)
                                        : controller.profileImagePath != null &&
                                                File(controller
                                                        .profileImagePath!)
                                                    .existsSync()
                                            ? FileImage(File(
                                                controller.profileImagePath!))
                                            : AssetImage(ImagePath.profile)
                                                as ImageProvider,
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: () =>
                                          controller.pickProfileImage(),
                                      child: Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          border:
                                              Border.all(color: Colors.grey),
                                        ),
                                        child: const Icon(Icons.edit,
                                            size: 18, color: Colors.blue),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 12),

                            // Name
                            Text(
                              controller.userData?.name ?? 'Loading...',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 24),

                            // Menu Options
                            _buildMenuOption(Icons.history, 'Your Appointments',
                                () => Get.toNamed(Routes.userAppointments)),
                            _buildMenuOption(Icons.logout, 'Logout',
                                () => controller.signOutUser()),
                            Get.find<ReelController>().isUploadLoading
                                ? CircularProgressIndicator()
                                : _buildMenuOption(Icons.logout, 'Upload Reels',
                                    () => reelController.uploadVideo()),
                            const SizedBox(height: 16),
                            ReelWidget(
                                videos: controller.userData!.reels,
                                userId: controller.userData!.id),
                          ],
                        ),
                      ));
      },
    );
  }

  Widget _buildMenuOption(IconData icon, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
        child: Card(
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: Colors.teal,
                  size: 22,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
