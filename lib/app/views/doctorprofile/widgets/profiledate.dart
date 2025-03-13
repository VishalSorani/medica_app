import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica_app/app/models/doctor_model.dart';
import 'package:medica_app/app/views/doctorprofile/doctorprofile_controller.dart';

class ProfileDate extends StatelessWidget {
  final Doctor doctor;
  const ProfileDate({super.key, required this.doctor});
  // Mapping integer days (0-6) to actual weekday names
  static const List<String> weekDays = [
    "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DoctorProfileController>(builder: (controller) {
      return Column(children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Date',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'See All',
                  style: TextStyle(
                    color: Colors.teal[700],
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 50,
          margin: const EdgeInsets.only(top: 8, bottom: 16),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: doctor.availableDays.length,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) {
              // final date = doctor.availableDays[index];
              final isSelected = controller.selectedDateIndex == index;
              return GestureDetector(
                onTap: () {
                  controller.selectedDateIndex = index;
                  controller.update();
                },
                child: Container(
                  width: 100,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.teal : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected ? Colors.teal : Colors.grey.shade300,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        weekDays[doctor.availableDays[index]],
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ]);
    });
  }
}
