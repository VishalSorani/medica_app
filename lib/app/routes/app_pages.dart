import 'package:get/get.dart';
import 'package:medica_app/app/views/admin/admin_binding.dart';
import 'package:medica_app/app/views/admin/admin_screen.dart';
import 'package:medica_app/app/views/booking/booking_binding.dart';
import 'package:medica_app/app/views/booking/booking_screen.dart';
import 'package:medica_app/app/views/doctorprofile/doctorprofile_binding.dart';
import 'package:medica_app/app/views/doctorprofile/doctorprofile_screen.dart';
import 'package:medica_app/app/views/doctors/doctors_binding.dart';
import 'package:medica_app/app/views/doctors/doctors_screen.dart';
import 'package:medica_app/app/views/homeScreen/home_binding.dart';
import 'package:medica_app/app/views/mainscreen/main_bindings.dart';
import 'package:medica_app/app/views/manageappointments/manageappointments_binding.dart';
import 'package:medica_app/app/views/manageappointments/manageappointments_screen.dart';
import 'package:medica_app/app/views/mainscreen/main_screen.dart';
import 'package:medica_app/app/views/managedoctors/managedoctors_binding.dart';
import 'package:medica_app/app/views/managedoctors/managedoctors_screen.dart';
import 'package:medica_app/app/views/profile/profile_binding.dart';
import 'package:medica_app/app/views/profile/profile_screen.dart';
import 'package:medica_app/app/views/signin/signin_binding.dart';
import 'package:medica_app/app/views/signin/signin_screen.dart';
import 'package:medica_app/app/views/signup/signup_bindng.dart';
import 'package:medica_app/app/views/signup/signup_screen.dart';
import 'package:medica_app/app/views/splash/splash_binding.dart';
import 'package:medica_app/app/views/splash/splash_screen.dart';
import 'package:medica_app/app/views/userappointments/userappointments_binding.dart';
import 'package:medica_app/app/views/userappointments/userappointments_screen.dart';
import '../views/homeScreen/home_screen.dart';

part 'app_routes.dart';

class AppPages {
  static const initial = Routes.splash; // Set the initial route

  static final routes = [
    GetPage(
      name: Routes.splash,
      page: () => const Splash(),
      binding: SplashBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.mainscreen,
      page: () => MainScreen(),
      binding: MainBindings(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.signin,
      page: () => const SignInScreen(),
      binding: SigninBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.signup,
      page: () => const SignUpScreen(),
      binding: SignUpBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.homeScreen,
      page: () => HomeScreen(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.doctors,
      page: () => const DoctorsScreen(),
      binding: DoctorsBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.doctorProfile,
      page: () => const DoctorprofileScreen(),
      binding: DoctorProfileBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.booking,
      page: () => const BookingScreen(),
      binding: BookingBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.admin,
      page: () => const AdminScreen(),
      binding: AdminBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.manageDoctors,
      page: () => const ManagedoctorsScreen(),
      binding: ManagedoctorsBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.manageAppointments,
      page: () => const ManageappointmentsScreen(),
      binding: ManageappointmentsBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.profile,
      page: () => const ProfileScreen(),
      binding: ProfileBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.userAppointments,
      page: () => const UserappointmentsScreen(),
      binding: UserappointmentsBinding(),
      transition: Transition.fadeIn,
    )
  ];
}


