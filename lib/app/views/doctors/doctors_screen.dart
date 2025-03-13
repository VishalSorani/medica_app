import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica_app/app/utils/colors.dart';
import 'package:medica_app/app/widgets/doctorlist.dart';
import 'package:medica_app/app/widgets/searchbar_widget.dart';

class DoctorsScreen extends StatelessWidget {
  const DoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () {
            Get.back(); // Navigate back
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
      body: Column(
        children: [
          SearchBarWidget(),
          Expanded(
            // Ensure Doctorlist takes available space
            child: Doctorlist(),
          ),
        ],
      ),
    );
  }
}
