import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medica_app/app/utils/colors.dart';
import 'package:medica_app/app/views/manageappointments/manageappointments_controller.dart';

class ManageappointmentsScreen extends StatelessWidget {
  const ManageappointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ManageappointmentsController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.black),
              onPressed: () => Get.back(),
            ),
            title: const Text(
              'Manage Appointments',
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
          body: controller.isLoading
              ? const Center(child: CircularProgressIndicator())
              : controller.appointments.isEmpty
                  ? const Center(child: Text('No Appointments Found'))
                  : ListView.builder(
                      itemCount: controller.appointments.length,
                      itemBuilder: (context, index) {
                        final appointment = controller.appointments[index];
                        print(appointment);
                        print("Appointment ID: ${appointment.id}");
                        return Card(
                          margin: const EdgeInsets.all(8),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Doctor ID: ${appointment.doctorId}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 4),
                                Text("User ID: ${appointment.userId}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 4),
                                Text(
                                    "Date: ${DateFormat('dd-MM-yyyy').format(appointment.date)}"),
                                Text("Time: ${appointment.time}"),
                                const SizedBox(height: 8),

                                // Status with Color
                                Text(
                                  "Status: ${appointment.status}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: appointment.status == "approved"
                                        ? Colors.green
                                        : appointment.status == "rejected"
                                            ? Colors.red
                                            : Colors.black,
                                  ),
                                ),

                                const SizedBox(height: 8),

                                // Buttons appear only if the status is pending
                                if (appointment.status == "pending")
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            controller.approveAppointment(
                                                appointment.id);
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.green),
                                          child: const Text("Approve"),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            controller.rejectAppointment(
                                                appointment.id);
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red),
                                          child: const Text("Reject"),
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
        );
      },
    );
  }
}
