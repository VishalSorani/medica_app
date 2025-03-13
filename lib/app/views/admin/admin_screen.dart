import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica_app/app/views/admin/admin_controller.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return GetBuilder<AdminController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Admin Dashboard"),
            actions: [
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: controller.logout, // Logout function
              )
            ],
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: (){
                    controller.manageDoctors();
                  },
                  child: Text("Manage Doctors"),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: (){
                    controller.manageAppointments();
                  },
                  child: Text("Manage Appointments"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
