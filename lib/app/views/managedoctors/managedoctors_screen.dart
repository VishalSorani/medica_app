import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica_app/app/models/doctor_model.dart';
import 'package:medica_app/app/utils/colors.dart';
import 'package:medica_app/app/views/managedoctors/managedoctors_controller.dart';
import 'package:medica_app/app/views/managedoctors/widgets/doctor_form.dart';
import 'package:medica_app/app/widgets/doctor_list_item.dart';

class ManagedoctorsScreen extends StatelessWidget {
  const ManagedoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final doctorController = Get.put(DoctorListController());

    return GetBuilder<ManagedoctorController>(builder: (controller) {
      return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.black),
              onPressed: () {
                Get.back(); // Navigate back
              },
            ),
            title: const Text(
              'manage doctors',
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
          body: GetBuilder<ManagedoctorController>(
              id: ManagedoctorController.doctorId,
              builder: (controller) {
                return Column(children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.to(DoctorForm());
                    },
                    child: const Text("Add Doctor"),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      itemCount: controller.doctorList.length,
                      itemBuilder: (context, index) {
                        Doctor doctor = controller.doctorList[index];
                        return DoctorListItem(doctor: doctor);
                      },
                    ),
                  ),
                ]);
              }));
    });
  }
}
