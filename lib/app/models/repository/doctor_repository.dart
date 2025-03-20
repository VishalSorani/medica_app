import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medica_app/app/models/appointment_model.dart';
import 'package:medica_app/app/models/doctor_model.dart';
import 'package:medica_app/app/utils/image_path.dart';

class DoctorRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // Future<List<Doctor>> getDoctorsByCategory(categoryId) async {
  //   try {
  //     final snapshot = await _firestore
  //         .collection('doctors')
  //         .where('categoryId', isEqualTo: categoryId)
  //         .get();
  //     return snapshot.docs.map((doc) {
  //       return Doctor.fromJson(doc.data(), doc.id);
  //     }).toList();
  //   } catch (e) {
  //     return [];
  //   }
  // }

  Future<List<Doctor>> getDoctors() async {
    try {
      final snapshot = await _firestore.collection('doctors').get();
      return snapshot.docs.map((doc) {
        return Doctor.fromJson(doc.data(), doc.id);
      }).toList();
    } catch (e) {
      return [];
    }
  }

  Future<Doctor?> getDoctorById(String doctorId) async {
  try {
    final doc = await _firestore.collection('doctors').doc(doctorId).get();
    if (doc.exists) {
      return Doctor.fromJson(doc.data() as Map<String, dynamic>, doc.id);
    }
    return null;
  } catch (e) {
    print("Error fetching doctor by ID: $e");
    return null;
  }
}


  Future<List<Appointment>> getBookedTimeSlots(
      String doctorId, DateTime date) async {
    try {
      print('doctorId: $doctorId, date: $date');
      QuerySnapshot snapshot = await _firestore
          .collection('appointments') // 🔹 Global "appointments" collection
          .where('doctorId', isEqualTo: doctorId) // 🔹 Filter by doctor ID
          .where('date', isEqualTo: date) // 🔹 Filter by selected date
          .get();
print('snapshot: $snapshot');
      List<Appointment> bookedSlots = snapshot.docs
          .map((doc) =>
              Appointment.fromJson(doc.data() as Map<String, dynamic>, doc.id))
          .toList();

      print('bookedSlots: $bookedSlots');

      return bookedSlots;
    } catch (e) {
      print("Error fetching booked slots: $e");
      return [];
    }
  }

  /// Add an appointment as a subcollection inside the doctor's document
  // Future<void> addAppointmentToDoctor(String doctorId, Appointment appointment) async {
  //   try {
  //     await _firestore
  //         .collection('doctors')
  //         .doc(doctorId)
  //         .collection('appointments') // Create subcollection
  //         .doc() // Unique appointment ID
  //         .set(appointment.toJson()); // Store appointment data

  //     print("Appointment added to doctor's subcollection successfully!");
  //   } catch (e) {
  //     print("Error adding appointment to doctor's subcollection: $e");
  //     throw Exception("Failed to add appointment");
  //   }
  // }

  Future<void> addDoctor(Doctor doctor) async {
    try {
      List<Doctor> doctors = [
        // Cardiologists
        Doctor(
          id: '',
          name: 'Dr. John Doe',
          ratings: 4.8,
          specialization: 'Cardiologist',
          profileImage: ImagePath.doctor,
          categoryId: 'y24BNM67Xq6x7lVSStGz',
          payment: '\$100',
          details:
              'Expert in heart diseases, hypertension, and cholesterol management. Committed to patient education and preventive care.',
          startTime: '09:00',
          endTime: '17:00',
          availableDays: [1, 2, 3, 4, 5],
          appointments: [],
        ),
        Doctor(
          id: '',
          name: 'Dr. Emily Carter',
          ratings: 4.9,
          specialization: 'Cardiologist',
          profileImage: ImagePath.doctor,
          categoryId: 'y24BNM67Xq6x7lVSStGz',
          payment: '\$120',
          details:
              'Specializes in complex heart surgeries and preventive cardiology. Focused on improving cardiac health through lifestyle changes.',
          startTime: '08:30',
          endTime: '16:30',
          availableDays: [0, 2, 3, 4, 5],
          appointments: [],
        ),

        // Pediatricians
        Doctor(
          id: '',
          name: 'Dr. Lisa Roberts',
          ratings: 4.7,
          specialization: 'Pediatrician',
          profileImage: ImagePath.doctorTwo,
          categoryId: 'guQSr78LqDvZxTkdtZcm',
          payment: '\$80',
          details:
              'Dedicated pediatrician with a passion for child health, vaccinations, and developmental care.',
          startTime: '10:00',
          endTime: '18:00',
          availableDays: [1, 2, 4, 5, 6],
          appointments: [],
        ),
        Doctor(
          id: '',
          name: 'Dr. Kevin Smith',
          ratings: 4.6,
          specialization: 'Pediatrician',
          profileImage: ImagePath.doctorTwo,
          categoryId: 'guQSr78LqDvZxTkdtZcm',
          payment: '\$90',
          details:
              'Expert in childhood illnesses, nutrition, and behavioral disorders. Committed to providing friendly and compassionate care.',
          startTime: '09:00',
          endTime: '17:30',
          availableDays: [0, 2, 3, 5, 6],
          appointments: [],
        ),

        // Neurologists
        Doctor(
          id: '',
          name: 'Dr. Michael Brown',
          ratings: 4.9,
          specialization: 'Neurologist',
          profileImage: ImagePath.doctorThree,
          categoryId: '7S1IEA2yyEvep6teZJF4',
          payment: '\$150',
          details:
              'Specialist in stroke management, migraines, and neurodegenerative diseases. Provides advanced treatment solutions.',
          startTime: '08:00',
          endTime: '16:00',
          availableDays: [1, 3, 4, 5],
          appointments: [],
        ),
        Doctor(
          id: '',
          name: 'Dr. Sophia Williams',
          ratings: 4.8,
          specialization: 'Neurologist',
          profileImage: ImagePath.doctorThree,
          categoryId: '7S1IEA2yyEvep6teZJF4',
          payment: '\$140',
          details:
              'Expert in epilepsy, multiple sclerosis, and nervous system disorders. Passionate about research and innovation in neurology.',
          startTime: '09:30',
          endTime: '17:30',
          availableDays: [0, 2, 3, 4, 6],
          appointments: [],
        ),

        // Dermatologists
        Doctor(
          id: '',
          name: 'Dr. Rachel Green',
          ratings: 4.7,
          specialization: 'Dermatologist',
          profileImage: ImagePath.doctorFour,
          categoryId: '5pvetqC6FoxTM0wNbOgd',
          payment: '\$110',
          details:
              'Skincare specialist with expertise in acne, eczema, and cosmetic dermatology. Helps patients achieve healthy skin.',
          startTime: '10:00',
          endTime: '18:00',
          availableDays: [1, 2, 3, 5, 6],
          appointments: [],
        ),
        Doctor(
          id: '',
          name: 'Dr. Daniel Lee',
          ratings: 4.8,
          specialization: 'Dermatologist',
          profileImage: ImagePath.doctorFour,
          categoryId: '5pvetqC6FoxTM0wNbOgd',
          payment: '\$130',
          details:
              'Expert in skin cancer treatment, laser therapies, and anti-aging solutions. Prioritizes skin health and well-being.',
          startTime: '08:30',
          endTime: '17:00',
          availableDays: [0, 1, 3, 4, 5],
          appointments: [],
        ),

        // Physiotherapists
        Doctor(
          id: '',
          name: 'Dr. Mark Wilson',
          ratings: 4.6,
          specialization: 'Physiotherapist',
          profileImage: ImagePath.doctorFive,
          categoryId: '2JvmVDIoEp5ivDrmsRyf',
          payment: '\$70',
          details:
              'Specializes in sports injuries, chronic pain management, and rehabilitation therapies for mobility improvement.',
          startTime: '09:00',
          endTime: '16:00',
          availableDays: [0, 1, 3, 4, 5],
          appointments: [],
        ),
        Doctor(
          id: '',
          name: 'Dr. Olivia Martinez',
          ratings: 4.9,
          specialization: 'Physiotherapist',
          profileImage: ImagePath.doctorFive,
          categoryId: '2JvmVDIoEp5ivDrmsRyf',
          payment: '\$80',
          details:
              'Expert in post-surgical recovery, spine alignment, and physical therapy techniques to restore movement and reduce pain.',
          startTime: '10:00',
          endTime: '18:00',
          availableDays: [1, 2, 3, 5, 6],
          appointments: [],
        ),
      ];

      for (Doctor doctor in doctors) {
        await _firestore.collection('doctors').add(doctor.toJson());
      }

      print('Doctors added successfully!');
    } catch (e) {
      print('Error adding sample doctors: $e');
    }
  }
}
