// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:medica_app/app/models/doctor_model.dart';
// import 'package:medica_app/app/views/booking/booking_controller.dart';
// import 'package:medica_app/app/views/doctorprofile/doctorprofile_controller.dart';
// import 'package:table_calendar/table_calendar.dart';

// class ProfileCalender extends StatelessWidget {
//   const ProfileCalender({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: GetBuilder<DoctorProfileController>(
//         init: DoctorProfileController(), // Initialize GetX Controller
//         builder: (controller) {
//           return TableCalendar(
//             firstDay: DateTime.utc(2025, 1, 1),
//             lastDay: DateTime.utc(2025, 12, 31),
//             focusedDay: controller.focusedDay,
//             calendarFormat: controller.calendarFormat,
//             selectedDayPredicate: (day) {
//               return controller.selectedDay != null &&
//                   isSameDay(controller.selectedDay, day);
//             },
//             onDaySelected: (selectedDay, focusedDay) {
//               controller.setDate(selectedDay);
//               controller.selectDay(selectedDay, focusedDay);
//               print("calender shown");
//             },
//             calendarStyle: CalendarStyle(
//               todayDecoration: BoxDecoration(
//                 color: Colors.black,
//                 shape: BoxShape.circle,
//               ),
//               selectedDecoration: BoxDecoration(
//                 color: Colors.blue,
//                 shape: BoxShape.circle,
//               ),
//             ),
//             headerStyle: HeaderStyle(
//               formatButtonVisible: false,
//               titleCentered: true,
//               titleTextStyle:
//                   const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             startingDayOfWeek: StartingDayOfWeek.monday,
//             daysOfWeekStyle: const DaysOfWeekStyle(
//               weekdayStyle: TextStyle(fontWeight: FontWeight.bold),
//               weekendStyle: TextStyle(fontWeight: FontWeight.bold),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
