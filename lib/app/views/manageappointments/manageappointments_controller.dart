import 'package:get/get.dart';
import 'package:medica_app/app/models/appointment_model.dart';
import 'package:medica_app/app/models/repository/appointment_repository.dart';

class ManageappointmentsController extends GetxController {
  final AppointmentRepository _appointmentRepo = AppointmentRepository();
  List<Appointment> appointments = [];
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    fetchAppointments();
  }

  Future<void> fetchAppointments() async {
    try {
      isLoading = true;
      update();

      // Fetch all appointments (for admin)
      appointments = await _appointmentRepo.getAppointments();
      update();
    } catch (e) {
      print("Error fetching appointments: $e");
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> approveAppointment(String appointmentId) async {
    try {
      await _appointmentRepo.updateStatus(appointmentId, "approved");
      Get.snackbar("Success", "Appointment approved!");
      await fetchAppointments();
    } catch (e) {
      print("Error approving appointment: $e");
      Get.snackbar("Error", "Failed to approve appointment.");
    }
  }

  Future<void> rejectAppointment(String appointmentId) async {
    try {
      await _appointmentRepo.updateStatus(appointmentId, "rejected");
      Get.snackbar("Success", "Appointment rejected!");
      await fetchAppointments();
    } catch (e) {
      print("Error rejecting appointment: $e");
      Get.snackbar("Error", "Failed to reject appointment.");
    }
  }
}
