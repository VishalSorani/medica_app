import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:medica_app/app/models/appointment_model.dart';
import 'package:medica_app/app/models/repository/appointment_repository.dart';

class UserappointmentsController extends GetxController {
  final AppointmentRepository _appointmentRepo = AppointmentRepository();
  List<Appointment> appointments = [];
  bool isLoading = true;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    print("🚀 ProfileController Init");
    fetchUserAppointments();
  }

Future<void> fetchUserAppointments() async {
  try {
    isLoading = true;
    update();

    final user = _auth.currentUser;
    print("👤 Current User: $user"); // Debugging print

    if (user == null) {
      print("❌ No user is logged in!"); // This means _auth.currentUser is null
      return; // Stop execution if user is null
    }

    String userId = user.uid;
    print("📌 Fetching appointments for User ID: $userId"); // Debugging print

    appointments = await _appointmentRepo.getUserAppointments(userId);
  } catch (e) {
    print("❌ Error fetching user appointments: $e");
  } finally {
    isLoading = false;
    update();
  }
}




}
