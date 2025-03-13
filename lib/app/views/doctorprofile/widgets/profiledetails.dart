import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica_app/app/models/doctor_model.dart';
import 'package:medica_app/app/views/doctorprofile/doctorprofile_controller.dart';

class ProfileDetails extends StatelessWidget {
  final Doctor doctor;
  const ProfileDetails({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DoctorProfileController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Details',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                doctor.details,
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
