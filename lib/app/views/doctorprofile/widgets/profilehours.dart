import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica_app/app/models/doctor_model.dart';
import 'package:medica_app/app/views/doctorprofile/doctorprofile_controller.dart';

import 'package:intl/intl.dart'; // Import for time formatting

class ProfileHours extends StatelessWidget {
  final Doctor doctor;
  const ProfileHours({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DoctorProfileController>(
      builder: (controller) {
        // Generate time slots
        List<String> timeSlots =
            _generateTimeSlots(doctor.startTime, doctor.endTime);

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Working Hours',
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
              margin: const EdgeInsets.only(top: 8),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: timeSlots.length,
                padding: const EdgeInsets.symmetric(
                    horizontal: 16), // Add horizontal padding
                itemBuilder: (context, index) {
                  final isSelected = controller.selectedTimeIndex == index;
                  return Padding(
                    // Add padding around each item
                    padding: EdgeInsets.only(
                        right: index == timeSlots.length - 1
                            ? 16
                            : 12), // Add right padding to last item
                    child: GestureDetector(
                      onTap: () {
                        controller.selectedTimeIndex = index;
                        controller.update();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.teal : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color:
                                isSelected ? Colors.teal : Colors.grey.shade300,
                          ),
                        ),
                        child: Text(
                          timeSlots[index],
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  /// Function to generate hourly time slots from startTime to endTime
  List<String> _generateTimeSlots(String startTime, String endTime) {
    print("Received Start Time: $startTime, End Time: $endTime"); // Debugging

    List<String> slots = [];

    if (startTime.isEmpty || endTime.isEmpty) {
      print("❌ Error: One of the times is empty");
      return slots; // Return empty list if values are missing
    }

    try {
      DateFormat format24 = DateFormat("HH:mm"); // 24-hour format
      DateFormat format12 = DateFormat("h:mm a"); // 12-hour format

      DateTime start = format24.parse(startTime);
      DateTime end = format24.parse(endTime);

      print("Parsed Start: $start, End: $end"); // Debugging

      while (start.isBefore(end) || start.isAtSameMomentAs(end)) {
        String formattedTime = format12.format(start);
        slots.add(formattedTime);
        print("Added Slot: $formattedTime"); // Debugging
        start = start.add(const Duration(hours: 1)); // Increment time
      }

      print("Final Generated Slots: $slots"); // Debugging
    } catch (e) {
      print("❌ Error parsing time: $e"); // Print error message
    }

    return slots;
  }
}
