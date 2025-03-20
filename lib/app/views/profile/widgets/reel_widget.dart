import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica_app/app/routes/app_pages.dart';
import 'package:medica_app/app/views/reels/reel_controller.dart';

class ReelWidget extends StatelessWidget {
  final List<String> videos;
  final String userId;

  const ReelWidget({
    super.key,
    required this.videos,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 2,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Text(
            'Your Posts',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        GridView.builder(
          padding: const EdgeInsets.all(8),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1,
          ),
          itemCount: videos.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // You can write your navigation or any function here
                Get.find<ReelController>().resetVideos(true, videos, index);
                print('Tapped video $index');
                Get.toNamed(Routes.reel);

                print('Tapped video $index');
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: const Center(
                  child: Icon(
                    Icons.play_circle_fill,
                    color: Colors.black54,
                    size: 40,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
