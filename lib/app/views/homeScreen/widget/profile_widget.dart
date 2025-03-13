import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica_app/app/utils/colors.dart';
import 'package:medica_app/app/utils/constant.dart';
import 'package:medica_app/app/utils/fonts.dart';
import 'package:medica_app/app/utils/image_path.dart';
import 'package:medica_app/app/views/homeScreen/home_controller.dart';
import 'package:medica_app/app/views/profile/profile_controller.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the ProfileController

    return Builder(builder: (context) {
      return GetBuilder<HomeController>(builder: (controller) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 28, 14, 0),
          child: Row(
            children: [
              GetBuilder<ProfileController>(builder: (ctx) {
                return CircleAvatar(
                  radius: 28,
                  backgroundImage: ctx.userData?.profileImage != null &&
                          ctx.userData!.profileImage.isNotEmpty &&
                          !ctx.userData!.profileImage.startsWith('/')
                      ? NetworkImage(ctx.userData!.profileImage)
                      : ctx.profileImagePath != null &&
                              File(ctx.profileImagePath!).existsSync()
                          ? FileImage(File(ctx.profileImagePath!))
                          : AssetImage(ImagePath.profile) as ImageProvider,
                );
              }),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppConstants.welcomeUser,
                      style: FMPTextTheme.instance.displayExtraSmall
                          ?.copyWith(fontSize: 14),
                    ),
                    const SizedBox(height: 0),
                    GetBuilder<ProfileController>(builder: (controller) {
                      return Text(
                        // Display name from Firestore
                        controller.userData?.name ?? 'Loading...',
                        style: FMPTextTheme.instance.displaySmall?.copyWith(
                          color: AppColors.black,
                          fontSize: 16,
                        ),
                      );
                    }),
                  ],
                ),
              ),
              Stack(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications_outlined, size: 28),
                  ),
                  Positioned(
                    right: 12,
                    top: 8,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: AppColors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      });
    });
  }
}
