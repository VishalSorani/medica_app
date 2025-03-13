import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica_app/app/utils/constant.dart';
import 'package:medica_app/app/widgets/textfield.dart';
import 'package:medica_app/app/routes/app_pages.dart'; // Import routes

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // final controller = Get.find<HomeController>();

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: GestureDetector(
        onTap: () {
          // Navigate to the Search Screen
          Get.toNamed(Routes.doctors);
        },
        child: AbsorbPointer(
          child: CustomTextField(
            hintText: AppConstants.searchDoctorPlaceholder,
            labelText: '',
            // controller: controller.searchController,
            prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
            // Disable text input
          ),
        ),
      ),
    );
  }
}
