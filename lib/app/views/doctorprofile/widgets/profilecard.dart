import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica_app/app/models/doctor_model.dart';
import 'package:medica_app/app/views/doctorprofile/doctorprofile_controller.dart';

class ProfileCard extends StatelessWidget {
  final Doctor doctor;
  const ProfileCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DoctorProfileController>(builder: (controller) {
      return Container(
        height: 132,
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            // Doctor image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                doctor.profileImage,
                width: 100,
                height: 130,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),

            // Doctor info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        doctor.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    doctor.specialization,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 28),
                  Row(
                    children: [
                      const Text(
                        'Payment',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        doctor.payment,
                        style: TextStyle(
                          color: Colors.teal[700],
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
