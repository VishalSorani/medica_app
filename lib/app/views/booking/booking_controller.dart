import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:medica_app/app/models/appointment_model.dart';
import 'package:medica_app/app/models/doctor_model.dart';
import 'package:medica_app/app/models/repository/appointment_repository.dart';
import 'package:medica_app/app/models/repository/doctor_repository.dart';
import 'package:medica_app/app/routes/app_pages.dart';
import 'package:table_calendar/table_calendar.dart';

enum AppointmentStatus { pending, approved, rejected }

class BookingController extends GetxController {
  final String loading = 'LOADING';
  static const String doctorInfo = "DOCTOR_INFO";

  late Doctor doctor;
  bool isLoading = false;
  bool isAddLoading = false;

  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;
  CalendarFormat calendarFormat = CalendarFormat.month;

  int? selectedTimeIndex;
  String? selectedTime;

  final AppointmentRepository _appointmentRepo = AppointmentRepository();
  final DoctorRepository _doctorRepo = DoctorRepository();
  List<Appointment> bookedTimeSlots = [];

  Map<String, dynamic>? userData;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void selectDay(DateTime newSelectedDay, DateTime newFocusedDay) {
    selectedDay = newSelectedDay;
    focusedDay = newFocusedDay;

    fetchBookedTimeSlots();

    update();
  }

  Future<void> fetchBookedTimeSlots() async {
    if (selectedDay == null || doctor.id == null) {
      print("❌ selectedDay or doctor.id is null");
      return;
    }

    print("📅 Fetching booked slots for: ${selectedDay}");
    print("👨‍⚕️ Doctor ID: ${doctor.id}");

    isLoading = true;
    update();

    try {
      final bookedSlots =
          await _doctorRepo.getBookedTimeSlots(doctor.id, selectedDay!);

      print(
        "✅ Booked slots fetched: $bookedSlots, $selectedDay",
      ); // Debug print

      bookedTimeSlots = bookedSlots;
      print(bookedTimeSlots);
      update();
    } catch (e) {
      print("❌ Error fetching booked slots: $e");
    }

    isLoading = false;
    update();
  }

  void selectAppointment(DateTime date, String time) {
    if (bookedTimeSlots.any((slot) => slot.time == (time))) {
      Get.snackbar("Already Booked", "This time slot is unavailable.");
      return;
    }

    selectedDay = date;
    selectedTime = time;
    update();
  }

  Future<void> addAppointment() async {
    isAddLoading = true;
    update();
    if (selectedDay == null || selectedTime == null) {
      Get.snackbar("Error", "Please select a date and time.");
      return;
    }

    int selectedWeekday = selectedDay!.weekday;

    if (!doctor.availableDays.contains(selectedWeekday)) {
      Get.snackbar("Not Available", "Doctor is not available today.");
      return;
    }

    bool isBooked = bookedTimeSlots.any((slot) => slot.time == selectedTime);
    if (isBooked) {
      Get.snackbar("Already Booked", "This time slot is not available.");
      return;
    }

    try {
      Appointment appointment = Appointment(
        id: "",
        doctorId: doctor.id,
        userId: _auth.currentUser!.uid,
        date: selectedDay!,
        time: selectedTime!,
        status: AppointmentStatus.pending.name,
      );

      DocumentReference appointmentRef =
          await _appointmentRepo.addAppointment(appointment);

      String appointmentId = appointmentRef.id;
      appointment = appointment.copyWith(id: appointmentId);

      Get.toNamed(Routes.userAppointments);
      Get.snackbar("Success", "Appointment booked successfully.");
    } catch (e) {
      Get.snackbar("Error", "Failed to book appointment.");
    }

    isAddLoading = false;
    update();
  }

  @override
  @override
  void onInit() {
    super.onInit();

    if (Get.arguments[doctorInfo] != null) {
      doctor = Get.arguments[doctorInfo];
    } else {
      Get.snackbar("Error", "Doctor information not found.");
      return;
    }

    selectedDay = DateTime.now();
    selectDay(DateTime.now(), DateTime.now());

    fetchBookedTimeSlots();
  }
}