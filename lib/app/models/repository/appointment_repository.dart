import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medica_app/app/models/appointment_model.dart';

class AppointmentRepository {
  final CollectionReference _appointmentsCollection =
      FirebaseFirestore.instance.collection('appointments');

      final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// 🔹 Add a new appointment to Firestore
  /// 🔹 Add a new appointment using separate parameters instead of a map or model
  Future<DocumentReference> addAppointment(Appointment appointment) async {
  try {
    DocumentReference ref = await _appointmentsCollection.add(appointment.toJson());
    print("Appointment added successfully!");
    return ref; // 🔹 Return DocumentReference so we get the Firestore-generated ID
  } catch (e) {
    print("Error adding appointment: $e");
    throw Exception("Failed to add appointment");
  }
}


 /// Update appointment status (Pending -> Approved/Rejected)
   Future<void> updateStatus(String appointmentId, String newStatus) async {
    try {
      // 🔹 Ensure the appointment document exists
      DocumentSnapshot doc = await _appointmentsCollection.doc(appointmentId).get();

      if (!doc.exists) {
        print("Error: Appointment does not exist!");
        throw Exception("Appointment not found");
      }

      // 🔹 Update the status
      await _appointmentsCollection.doc(appointmentId).update({
        'status': newStatus,
      });

      print("Appointment status updated successfully!");
    } catch (e) {
      print("Error updating appointment status: $e");
      throw Exception("Failed to update appointment status");
    }
  }
  /// 🔹 Fetch all appointments from Firestore
  Future<List<Appointment>> getAppointments() async {
    try {
      // QuerySnapshot snapshot = await _appointmentsCollection.get();
      // return snapshot.docs
      //     .map((doc) => Appointment.fromSnapshot(doc))
      //     .toList();
      final snapshot = await _firestore.collection('appointments').get();
      return snapshot.docs.map((doc) {
        return Appointment.fromJson(doc.data(), doc.id);
      }).toList();
    } catch (e) {
      print("Error fetching appointments: $e");
      throw Exception("Failed to fetch appointments");
    }
  }

// Future<List<Appointment>> getUserAppointments(String userId) async {
//   try {
//     QuerySnapshot snapshot = await _appointmentsCollection
//         .where('userId', isEqualTo: userId)
//         .get();

//     return snapshot.docs
//         .map((doc) => Appointment.fromSnapshot(doc))
//         .toList();
//   } catch (e) {
//     print("Error fetching user appointments: $e");
//     throw Exception("Failed to fetch user appointments");
//   }
// }



  // /// 🔹 Fetch appointments by doctor ID
  // Future<List<Appointment>> getAppointmentsByDoctor(String userId) async {
  //   try {
  //     QuerySnapshot snapshot =
  //         await _appointmentsCollection.where('userId', isEqualTo: userId).get();
  //     return snapshot.docs
  //         .map((doc) => Appointment.fromSnapshot(doc))
  //         .toList();
  //   } catch (e) {
  //     print("Error fetching doctor appointments: $e");
  //     throw Exception("Failed to fetch appointments for doctor");
  //   }
  // }

Future<List<Appointment>> getUserAppointments(String userId) async {
  try {
    QuerySnapshot snapshot = await _firestore.collection("appointments")
        .where('userId', isEqualTo: userId)
        .get();

    return snapshot.docs
        .map((doc) => Appointment.fromJson(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  } catch (e) {
    print("Error fetching user appointments: $e");
    throw Exception("Failed to fetch user appointments");
  }
}

/// 🔹 Fetch appointments by doctor ID
Future<List<Appointment>> getAppointmentsByDoctor(String doctorId) async {
  try {
    QuerySnapshot snapshot = await _firestore.collection("appointments")
        .where('doctorId', isEqualTo: doctorId)
        .get();

    return snapshot.docs
        .map((doc) => Appointment.fromJson(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  } catch (e) {
    print("Error fetching doctor appointments: $e");
    throw Exception("Failed to fetch appointments for doctor");
  }
}



}
