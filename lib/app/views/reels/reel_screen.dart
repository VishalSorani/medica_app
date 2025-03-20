import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica_app/app/utils/colors.dart';
import 'package:medica_app/app/views/reels/reel_controller.dart';
import 'package:medica_app/app/widgets/video_player.dart';

class ReelScreen extends StatelessWidget {
  const ReelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // FIXED: Initialize controller only once
    // final controller = Get.put(ReelController());
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () {
            Get.back();
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
      body: GetBuilder<ReelController>(
        id: ReelController.videoList,
        builder: (controller) {

          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.videoUrls.isEmpty) {
            return const Center(child: Text('No videos available'));
          }
          // final pageController = PageController(initialPage: controller.currentIndex);

          return PageView.builder(
            // controller: pageController,
            scrollDirection: Axis.vertical,
            itemCount: controller.videoUrls.length,
            itemBuilder: (context, index) {
              return VideoPlayerItem(
                key: ValueKey('video-${controller.videoUrls[index]}'),
                videoUrl: controller.videoUrls[index],
                index: index,
              );
            },
          );
        },
      ),
    );
  }
}
