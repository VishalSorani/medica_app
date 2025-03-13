import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica_app/app/utils/colors.dart';
import 'package:medica_app/app/views/homeScreen/home_controller.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      id: HomeController.categoryId,
      builder: (controller) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                children: [
                  const Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 48,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount:
                    controller.categoryList.length + 1, // +1 for "All" option
                itemBuilder: (context, index) {
                  final bool isAll = index == 0;
                  final bool isSelected = isAll
                      ? controller.selectedCategoryId.isEmpty
                      : controller.selectedCategoryId ==
                          controller.categoryList[index - 1].id;

                  return GestureDetector(
                    onTap: () {
                      if (isAll) {
                        controller.filterDoctors(
                            "", "All Doctors"); // Show all doctors
                      } else {
                        final category = controller.categoryList[index - 1];
                        controller.filterDoctors(category.id, category.name);
                      }
                      print(controller.filteredDoctors);
                      controller.update([HomeController.categoryId]);
                    },
                    child: Container(
                      width: 140,
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.sliderBackground
                            : AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          isAll
                              ? "All"
                              : controller.categoryList[index - 1].name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
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
}
