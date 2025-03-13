import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  String id;
  String doctorId;
  String userId;
  DateTime date;
  String time;
  String status;

  Appointment({
    required this.id,
    required this.doctorId,
    required this.userId,
    required this.date,
    required this.time,
    required this.status,
  });

  factory Appointment.fromJson(Map<String, dynamic> json, String id) {
    return Appointment(
      id: id,
      doctorId: json['doctorId'] ?? '',
      userId: json['userId'] ?? '',
      date: (json['date'] as Timestamp).toDate(),
      time: json['time'] ?? '',
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'doctorId': doctorId,
      'userId': userId,
      'date': Timestamp.fromDate(date),
      'time': time,
      'status': status,
    };
  }

  factory Appointment.fromSnapshot(DocumentSnapshot snapshot) {
    return Appointment.fromJson(
        snapshot.data() as Map<String, dynamic>, snapshot.id);
  }

  Appointment copyWith({required String id}) {
    return Appointment(
      id: id,
      doctorId: doctorId,
      userId: userId,
      date: date,
      time: time,
      status: status,
    );
  }
}
