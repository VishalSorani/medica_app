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
    
    fetchBookedTimeSlots(); // Fetch booked slots when selecting a date
    
    update();
  }

  /// Fetch booked time slots for the selected date
  Future<void> fetchBookedTimeSlots() async {

    isLoading = true;
    update();
    if (selectedDay == null) return;

    try {
      final bookedSlots =
          await _doctorRepo.getBookedTimeSlots(doctor.id, selectedDay!);
      bookedTimeSlots = bookedSlots;
      print(bookedSlots);
      update();
    } catch (e) {
      print("Error fetching booked slots: $e");
    }

    isLoading = false;
    update();
  }

  /// Select appointment date and time
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

    // 🔹 Check if the doctor is available on this day
    if (!doctor.availableDays.contains(selectedWeekday)) {
      Get.snackbar("Not Available", "Doctor is not available today.");
      return;
    }

    // 🔹 Check if the selected time slot is already booked
    bool isBooked = bookedTimeSlots.any((slot) => slot.time == selectedTime);
    if (isBooked) {
      Get.snackbar("Already Booked", "This time slot is not available.");
      return;
    }

    try {
      // 🔹 Generate appointment object
      Appointment appointment = Appointment(
        id: "", // Firestore will generate the ID
        doctorId: doctor.id,
        userId: _auth.currentUser!.uid,
        date: selectedDay!,
        time: selectedTime!,
        status: AppointmentStatus.pending.name,
      );

      // 🔹 Save the appointment in Firestore (Global appointment collection)
      DocumentReference appointmentRef =
          await _appointmentRepo.addAppointment(appointment);

      // 🔹 Get Firestore-generated ID and update appointment object
      String appointmentId = appointmentRef.id;
      appointment = appointment.copyWith(id: appointmentId);

      // 🔹 Add the appointment to the **User's Firestore Document**
      // await FirebaseFirestore.instance
      //     .collection('users')
      //     .doc(appointment.userId)
      //     .update({
      //   'appointments': FieldValue.arrayUnion([appointment.toJson()])
      // });

      // 🔹 Add the appointment to the **Doctor's Firestore Document**
      // await FirebaseFirestore.instance
      //     .collection('doctors')
      //     .doc(appointment.doctorId)
      //     .update({
      //   'appointments': FieldValue.arrayUnion([appointment.toJson()])
      // });

      // 🔹 Update UI
      // doctor.appointments?.add(appointment);
      // update();

      Get.toNamed(Routes.userAppointments);
      Get.snackbar("Success", "Appointment booked successfully.");
    } catch (e) {
      Get.snackbar("Error", "Failed to book appointment.");
    }

    isAddLoading = false;
    update();
  }

  @override
  void onInit() {
    super.onInit();

    

    if (Get.arguments[doctorInfo] != null) {
      doctor = Get.arguments[doctorInfo];
    }

    selectedDay = DateTime.now();

    fetchBookedTimeSlots(); // Load booked slots initially

    // 🔹 Listen for auth changes and update slots dynamically
  }
}
