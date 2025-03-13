import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica_app/app/views/userappointments/userappointments_controller.dart';

class UserAppointment extends StatelessWidget {
  const UserAppointment({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserappointmentsController>(
      init: UserappointmentsController(),
      builder: (controller) {
        return controller.isLoading
            ? const Center(child: CircularProgressIndicator())
            : controller.appointments.isEmpty
                ? const Center(child: Text('No Appointments Found'))
                : ListView.builder(
                    itemCount: controller.appointments.length,
                    itemBuilder: (context, index) {
                      final appointment = controller.appointments[index];
                        
                      return Card(
                        margin: const EdgeInsets.all(8),
                        child: ListTile(
                          title: Text("Doctor ID: ${appointment.doctorId}"),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Date: ${appointment.date.toLocal()}"),
                              Text("Time: ${appointment.time}"),
                              Text(
                                "Status: ${appointment.status}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: appointment.status == "approved"
                                      ? Colors.green
                                      : appointment.status == "rejected"
                                          ? Colors.red
                                          : Colors.orange,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
      }
    );
  }
}
