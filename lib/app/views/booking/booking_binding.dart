import 'package:get/get.dart';
import 'package:medica_app/app/views/booking/booking_controller.dart';

class BookingBinding extends Bindings{
  @override
  void dependencies() { 
    Get.put<BookingController>(BookingController());
  }
}