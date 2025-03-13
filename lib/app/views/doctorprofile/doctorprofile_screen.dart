import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica_app/app/routes/app_pages.dart';
import 'package:medica_app/app/utils/colors.dart';
import 'package:medica_app/app/views/booking/booking_controller.dart';
import 'package:medica_app/app/views/doctorprofile/doctorprofile_controller.dart';
import 'package:medica_app/app/views/doctorprofile/widgets/profilecard.dart';
import 'package:medica_app/app/views/doctorprofile/widgets/profiledetails.dart';

class DoctorprofileScreen extends GetWidget<DoctorProfileController> {
  const DoctorprofileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DoctorProfileController>(
      id: DoctorProfileController.doctorInfo,
      builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.black),
            onPressed: () {
              Get.back();
            },
          ),
          title: const Text(
            'Appointment',
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
        body: Column(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween, // Pushes button to bottom
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    spacing: 16,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileCard(doctor: controller.doctor),
                      ProfileDetails(doctor: controller.doctor),
                      // ProfileDate(doctor: controller.doctor),
                      // ProfileHours(doctor: controller.doctor),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity, // Full width
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed(Routes.booking, arguments: {
                    BookingController.doctorInfo: controller.doctor,
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Book an Appointment',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
