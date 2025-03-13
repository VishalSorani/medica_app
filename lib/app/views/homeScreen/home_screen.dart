import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica_app/app/views/homeScreen/home_controller.dart';
import 'package:medica_app/app/views/homeScreen/widget/categories_widget.dart';
import 'package:medica_app/app/views/homeScreen/widget/doctor_list.dart';
import 'package:medica_app/app/views/homeScreen/widget/home_carousel.dart';
import 'package:medica_app/app/views/homeScreen/widget/profile_widget.dart';
import 'package:medica_app/app/widgets/searchbar_widget.dart';



class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return Scaffold(
            body: SafeArea(
              child: controller.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProfileWidget(),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    controller.signOutUser();
                                  },
                                  child: const Text('sign out'),
                                ),
                                SearchBarWidget(),
                                HomeCarousel(),
                                CategoriesWidget(),
                                SizedBox(child: DoctorList()),
                                // Doctorlist(),
                                // _buildDoctorsList(),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          );
        });
  }
}
