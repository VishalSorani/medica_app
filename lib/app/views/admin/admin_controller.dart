import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medica_app/app/routes/app_pages.dart';// Make sure routes are set up

class AdminController extends GetxController {
  /// 🔹 Logout function
  void logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(Routes.signin); // Redirect to login screen
  }

  /// 🔹 Navigate to Doctor Management Page
  void manageDoctors() {
    Get.toNamed(Routes.manageDoctors);
  }

  /// 🔹 Navigate to Appointments Management Page
  void manageAppointments() {
    Get.toNamed(Routes.manageAppointments);
  }
}
