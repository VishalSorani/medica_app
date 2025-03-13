import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica_app/app/utils/colors.dart';
import 'package:medica_app/app/views/booking/booking_controller.dart';
import 'package:medica_app/app/views/booking/widgets/calendar.dart';
import 'package:medica_app/app/views/booking/widgets/time.dart';

class BookingScreen extends GetWidget<BookingController> {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingController>(
        id: BookingController.doctorInfo,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CalendarScreen(),
                          Time(doctor: controller.doctor),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity, // Full width
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: ElevatedButton(
                    onPressed: controller.isAddLoading
                        ? null
                        : () {
                            controller.addAppointment();
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: controller.isAddLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 3,
                            ),
                          )
                        : const Text(
                            'Set an Appointment',
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
