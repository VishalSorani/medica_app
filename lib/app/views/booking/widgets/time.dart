import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica_app/app/models/doctor_model.dart';
import 'package:medica_app/app/views/booking/booking_controller.dart';
import 'package:intl/intl.dart';

class Time extends StatelessWidget {
  final Doctor doctor;
  const Time({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingController>(
      builder: (controller) {
        List<String> timeSlots =
            _generateTimeSlots(doctor.startTime, doctor.endTime);

        bool isAvailableToday = doctor.availableDays.contains(
            controller.selectedDay?.weekday ?? DateTime.now().weekday);

        return controller.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Working Hours',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  if (!isAvailableToday) // 🔹 Show Not Available if doctor is off
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Doctor is not available today",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  else
                    Container(
                      height: 50,
                      margin: const EdgeInsets.only(top: 8),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: timeSlots.length,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemBuilder: (context, index) {
                          final isSelected =
                              controller.selectedTimeIndex == index;

                          final isBooked =
                              controller.bookedTimeSlots.any((appointment) {
                            return appointment.date.isAtSameMomentAs(
                                    controller.selectedDay!) &&
                                _convertTo24HourFormat(appointment.time) ==
                                    _convertTo24HourFormat(timeSlots[index]);
                          });

                          return Padding(
                            padding: EdgeInsets.only(
                                right: index == timeSlots.length - 1 ? 16 : 12),
                            child: GestureDetector(
                              onTap: () {
                                if (isBooked) {
                                  Get.snackbar("Already Booked",
                                      "This time slot is not available.");
                                  return;
                                }
                                controller.selectAppointment(
                                    controller.selectedDay!, timeSlots[index]);
                                controller.selectedTimeIndex = index;
                                controller.update();
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: isBooked
                                      ? Colors.black // 🔹 Booked slots in black
                                      : isSelected
                                          ? Colors.teal
                                          : Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: isSelected
                                          ? Colors.teal
                                          : Colors.grey.shade300),
                                ),
                                child: Text(
                                  timeSlots[index],
                                  style: TextStyle(
                                    color: isBooked
                                        ? Colors
                                            .white // 🔹 White text for booked slots
                                        : isSelected
                                            ? Colors.white
                                            : Colors.black,
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
    List<String> slots = [];
    if (startTime.isEmpty || endTime.isEmpty) return slots;

    try {
      DateFormat format24 = DateFormat("HH:mm");
      DateFormat format12 = DateFormat("h:mm a");

      DateTime start = format24.parse(startTime);
      DateTime end = format24.parse(endTime);

      while (start.isBefore(end) || start.isAtSameMomentAs(end)) {
        slots.add(format12.format(start));
        start = start.add(const Duration(hours: 1));
      }
    } catch (e) {
      print("❌ Error parsing time: $e");
    }

    return slots;
  }

  String _convertTo24HourFormat(String time12Hour) {
    try {
      DateFormat format12 = DateFormat("h:mm a"); // 12-hour format
      DateFormat format24 = DateFormat("HH:mm"); // 24-hour format
      DateTime dateTime = format12.parse(time12Hour);
      return format24.format(dateTime); // Convert to 24-hour format
    } catch (e) {
      print("❌ Error converting time format: $e");
      return time12Hour; // Return as is if conversion fails
    }
  }
}
