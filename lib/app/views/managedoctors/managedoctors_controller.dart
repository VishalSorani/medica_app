import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica_app/app/models/doctor_model.dart';
import 'package:medica_app/app/models/repository/doctor_repository.dart';
import 'package:medica_app/app/utils/image_path.dart';

class ManagedoctorController extends GetxController {
  // Repository
  final _doctorRepository = DoctorRepository();

  // Doctor list
  List<Doctor> doctorList = [];
  static const String doctorId = 'DOCTOR_ID';
  bool isLoading = false;

  // Form controllers
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final detailsController = TextEditingController();
  final paymentController = TextEditingController();

  // Rating
  static const String ratingId = 'RATING_ID';
  double rating = 3;

  // Specialization
  static const String specializationId = 'SPECIALIZATION_ID';
  String selectedSpecialization = '';
  String selectedCategoryId = '';

  // Time
  int startTime = 9;
  int endTime = 17;

  // Days
  final selectedDays = <String>[];
  final daysOfWeek = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ];
  final dayToIndex = {
    'Sunday': 0,
    'Monday': 1,
    'Tuesday': 2,
    'Wednesday': 3,
    'Thursday': 4,
    'Friday': 5,
    'Saturday': 6,
  };

  // Specialization options and mapping
  final specializationOptions = [
    'Cardiologist',
    'Pediatrician',
    'Neurologist',
    'Dermatologist',
    'Physiotherapist'
  ];
  final specializationToCategoryId = {
    'Cardiologist': 'y24BNM67Xq6x7lVSStGz',
    'Pediatrician': 'guQSr78LqDvZxTkdtZcm',
    'Neurologist': '7S1IEA2yyEvep6teZJF4',
    'Dermatologist': '5pvetqC6FoxTM0wNbOgd',
    'Physiotherapist': '2JvmVDIoEp5ivDrmsRyf',
  };

  // Profile image
  final profileImagePath = Rx<String?>(null);

  // Hours for dropdown
  final hours = List.generate(24, (index) => index + 1);

  // Fetch doctors
  void fetchDoctors() async {
    isLoading = true;
    update();
    try {
      doctorList = await _doctorRepository.getDoctors();
      update([doctorId]);
    } catch (e) {
      print("Error fetching doctors: $e");
    }
    isLoading = false;
    update();
  }

  // Rating update
  void updateRating(double value) {
    rating = value.toDouble();
    update([ratingId]);
  }

  // Time update
  void updateStartTime(int? newValue) {
    if (newValue != null) {
      startTime = newValue;
      if (endTime <= startTime) {
        endTime = (startTime % 24) + 1;
      }
      update();
    }
  }

  void updateEndTime(int? newValue) {
    if (newValue != null) {
      endTime = newValue;
      update();
    }
  }

  // Specialization update (also update categoryId)
  void updateSpecialization(String value) {
    selectedSpecialization = value;
    selectedCategoryId = specializationToCategoryId[value] ?? '';
    update([specializationId]);
  }

  // Day toggle
  void toggleDay(String day, bool isSelected) {
    if (isSelected) {
      if (!selectedDays.contains(day)) {
        selectedDays.add(day);
      }
    } else {
      selectedDays.remove(day);
    }
    update();
  }

  bool isDaySelected(String day) {
    return selectedDays.contains(day);
  }

  String? validateEndTime(int? value) {
    if (value == null) {
      return 'Please select end time';
    }
    if (value <= startTime) {
      return 'End time must be after start time';
    }
    return null;
  }

  void pickImage() {
    profileImagePath.value = 'assets/placeholder_profile.png';
  }

  // Submit form logic
  Future<bool> submitForm(BuildContext context) async {
    if (selectedDays.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please select at least one available day')),
      );
      return false;
    }
    // Format start & end time manually (e.g., 09:00)
    String formattedStartTime = '${startTime.toString().padLeft(2, '0')}:00';
    String formattedEndTime = '${endTime.toString().padLeft(2, '0')}:00';

    if (formKey.currentState!.validate()) {
      DocumentReference docRef =
          FirebaseFirestore.instance.collection('doctors').doc();

      final doctor = Doctor(
        id: docRef.id,
        name: nameController.text,
        ratings: rating,
        specialization: selectedSpecialization,
        profileImage: ImagePath.doctorFive,
        categoryId: selectedCategoryId,
        payment: paymentController.text,
        details: detailsController.text,
        startTime: formattedStartTime,
        endTime: formattedEndTime,
        availableDays: selectedDays.map((day) => dayToIndex[day]!).toList(),
        appointments: [],
      );

      try {
        await docRef.set(doctor.toJson());
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Doctor information saved successfully')),
        );
        doctorList.add(doctor);
        update([doctorId]);
        return true;
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save doctor: $e')),
        );
        return false;
      }
    }
    return false;
  }

  // Initialize
  @override
  void onInit() {
    fetchDoctors();
    super.onInit();
  }

  // Dispose
  @override
  void onClose() {
    nameController.dispose();
    detailsController.dispose();
    paymentController.dispose();
    super.onClose();
  }
}
