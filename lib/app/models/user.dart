import 'package:medica_app/app/models/appointment_model.dart';

class Users {
  final String id;
  final String name;
  final String contactNumber;
  final String email;
  final DateTime createdAt;
  final String profileImage;
  final bool isAdmin;
  final List<String> reels;
  final List<Appointment>? appointments; // List of user appointments

  Users({
    required this.id,
    required this.name,
    required this.contactNumber,
    required this.email,
    required this.createdAt,
    required this.profileImage,
    required this.isAdmin,
    required this.reels,
    this.appointments,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id: json['id'],
      name: json['name'],
      contactNumber: json['contactNumber'],
      email: json['email'],
      createdAt: DateTime.parse(json['createdAt']),
      profileImage: json['profileImage'],
      isAdmin: json['isAdmin'] ?? false,
      reels: json['reels'] != null
          ? List<String>.from(json['reels'])
          : <String>[],
      appointments: [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'contactNumber': contactNumber,
      'email': email,
      'createdAt': createdAt.toIso8601String(),
      'profileImage': profileImage,
      'isAdmin': isAdmin,
      'reels': reels,
      'appointments':
          appointments?.map((appointment) => appointment.toJson()).toList(),
    };
  }
}
