import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica_app/app/utils/colors.dart';
import 'package:medica_app/app/views/userappointments/widgets/user_appointment.dart';
import 'package:medica_app/app/views/userappointments/userappointments_controller.dart';

class UserappointmentsScreen extends StatelessWidget {
  const UserappointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserappointmentsController>(
      init: UserappointmentsController(),
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
                'Your Appointments',
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
            body: UserAppointment());
      },
    );
  }
}
