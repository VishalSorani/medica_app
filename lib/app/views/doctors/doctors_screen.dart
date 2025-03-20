import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica_app/app/models/doctor_model.dart';
import 'package:medica_app/app/utils/colors.dart';
import 'package:medica_app/app/views/doctors/doctors_controller.dart';
import 'package:medica_app/app/widgets/doctor_list_item.dart';

class DoctorsScreen extends StatelessWidget {
  const DoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text(
          'All Doctors',
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
      body: GetBuilder<DoctorController>(
        id: DoctorController.doctorId,
        builder: (controller) {
          return controller.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search Bar
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextField(
                        onChanged: (value) {
                          controller.searchDoctor(value);
                        },
                        decoration: InputDecoration(
                          hintText: 'Search doctors...',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: AppColors.textFieldColor,
                        ),
                      ),
                    ),

                    // Searched list OR all doctors
                    Expanded(
                      child: controller.filteredDoctorList.isEmpty
                          ? controller.searchQuery
                                  .isNotEmpty // <-- ADD searchQuery check
                              ? Center(
                                  child: Text(
                                    "No doctor found",
                                    style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              : ListView.builder(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  itemCount: controller.doctorList.length,
                                  itemBuilder: (context, index) {
                                    Doctor doctor =
                                        controller.doctorList[index];
                                    return DoctorListItem(doctor: doctor);
                                  },
                                )
                          : ListView.builder(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              itemCount: controller.filteredDoctorList.length,
                              itemBuilder: (context, index) {
                                Doctor doctor =
                                    controller.filteredDoctorList[index];
                                return DoctorListItem(doctor: doctor);
                              },
                            ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
