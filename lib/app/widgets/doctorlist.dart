import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica_app/app/controllers/doctorlist_controller.dart';
import 'package:medica_app/app/models/doctor_model.dart';
import 'package:medica_app/app/routes/app_pages.dart';
import 'package:medica_app/app/utils/colors.dart';
import 'package:medica_app/app/views/doctorprofile/doctorprofile_controller.dart';
import 'package:medica_app/app/widgets/small_button.dart';

class Doctorlist extends StatelessWidget {
  const Doctorlist({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DoctorListController());
    return GetBuilder<DoctorListController>(
      id: DoctorListController.doctorId,
      builder: (controller) {
        return controller.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 16.0),
                    child: Text(
                      controller.selectedCategoryName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded( // This makes the ListView scrollable
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      itemCount: controller.doctorList.length,
                      itemBuilder: (context, index) {
                        Doctor doctor = controller.doctorList[index];

                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.doctorProfile, arguments: {
                              DoctorProfileController.doctorInfo: doctor,
                            });
                          },
                          child: Container(
                            height: 130,
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.textFieldColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: Row(
                                children: [
                                  Image.asset(
                                    doctor.profileImage,
                                    width: 80,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                doctor.name,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            doctor.specialization,
                                            style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SmallButton(
                                                label: 'Book',
                                                onPressed: () {
                                                  Get.toNamed(Routes.doctorProfile,
                                                      arguments: {
                                                        DoctorProfileController
                                                            .doctorInfo: doctor,
                                                      });
                                                },
                                              ),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                    size: 16,
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    doctor.ratings.toString(),
                                                    style: const TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
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
}
