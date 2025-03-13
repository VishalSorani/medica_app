import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:medica_app/app/routes/app_pages.dart';

class SplashController extends GetxController {

  final FirebaseAuth _auth = FirebaseAuth.instance;
 

  @override
  void onInit() {
    super.onInit();
    startSplash();
  }

  void startSplash() {
    
    Timer(Duration(seconds: 2), () {
     if(_auth.currentUser != null) {
        Get.offAllNamed(Routes.mainscreen);
      } else {
        Get.offAllNamed(Routes.signin);
     }
    });
  }
}
