import 'package:medica_app/app/models/appointment_model.dart';

class Doctor {
  final String id;
  final String name;
  final double ratings;
  final String specialization;
  final String profileImage;
  final String categoryId;
  final String payment;
  final String details;
  final String startTime;
  final String endTime;
  final List<int> availableDays;
  final List<Appointment>? appointments; // Updated here

  Doctor({
    required this.id,
    required this.name,
    required this.ratings,
    required this.specialization,
    required this.profileImage,
    required this.categoryId,
    required this.payment,
    required this.details,
    required this.startTime,
    required this.endTime,
    required this.availableDays,
    required this.appointments,
  });

  // Convert Firestore data to Doctor object
  factory Doctor.fromJson(Map<String, dynamic> json, String id) {
    return Doctor(
      id: id,
      name: json['name'],
      ratings: json['ratings'].toDouble(),
      specialization: json['specialization'],
      profileImage: json['profileImage'],
      categoryId: json['categoryId'],
      payment: json['payment'],
      details: json['details'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      availableDays: List<int>.from(json['availableDays']),
      appointments: [], // Parse list of appointments
    );
  }

  // Convert Doctor object to Firestore data
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'ratings': ratings,
      'specialization': specialization,
      'profileImage': profileImage,
      'categoryId': categoryId,
      'payment': payment,
      'details': details,
      'startTime': startTime,
      'endTime': endTime,
      'availableDays': availableDays,
      'appointments': appointments?.map((e) => e.toJson()).toList(), // Convert appointments to JSON
    };
  }
}
