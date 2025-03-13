import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica_app/app/utils/constant.dart';
import 'package:medica_app/app/utils/fonts.dart';
import 'package:medica_app/app/utils/image_path.dart';
import 'package:medica_app/app/views/splash/splash_controller.dart'; // Import Controller

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      init: SplashController(), // Initialize the controller
      builder: (controller) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  ImagePath.logo,
                  width: 135,
                  height: 135,
                ),
                const SizedBox(height: 18),
                Text(
                  AppConstants.appName,
                  style: FMPTextTheme.instance.displayLarge,
                  textScaler: TextScaler.linear(1),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
