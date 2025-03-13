import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica_app/app/models/repository/auth_repository.dart';
import 'package:medica_app/app/models/repository/user_repository.dart';
import 'package:medica_app/app/routes/app_pages.dart';
import 'package:medica_app/app/utils/constant.dart';

class SigninController extends GetxController {
  static const togglePassword = 'togglePassword';
  static const loginButton = 'loginButton';
  static const emailErrorText = 'emailErrorText';
  static const passwordErrorText = 'passwordErrorText';

  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isObscure = true;
  bool isSigninLoading = false;
  bool isGoogleLoading = false;

  UserCredential? userCredential;

  static const String adminUID = "ipXvc2uTNOS5VAgWHPJUfYuKgq42";

  // Error Messages
  String emailError = '';
  String passwordError = '';

  final AuthRepository _authRepository = AuthRepository();
  final UserRepository _userRepository = UserRepository();

  // Toggle Password Visibility
  void onTapToggle() {
    isObscure = !isObscure;
    update([togglePassword]);
  }

  // Email Validation
  String? validateEmail(String value) {
    if (value.isEmpty) {
      return AppConstants.emptyEmailError;
    } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(value)) {
      return AppConstants.invalidEmailError;
    }
    return null;
  }

  // Password Validation
  String? validatePassword(String value) {
    if (value.isEmpty) {
      return AppConstants.emptyPasswordError;
    }
    return null;
  }

  // Sign In
  void validateAndLogin() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    isSigninLoading = true;
    update([loginButton]);

    String? errorMessage = await _authRepository.signIn(
      emailController.text,
      passwordController.text,
    );

    isSigninLoading = false;
    update([loginButton]);

    if (errorMessage != null) {
      emailError = errorMessage;
      passwordError = errorMessage;
      update([emailErrorText, passwordErrorText]);
    } else {
      // print('User Logged In');
      // Get.offAllNamed(Routes.homeScreen);
    Get.offAllNamed(Routes.mainscreen);
    }
  }

  void googleSignIn() async {
    isGoogleLoading = true;
    update([loginButton]);
    await _authRepository.googleSignIn();
    isGoogleLoading = false;
    update([loginButton]);
  }

  Future<bool> fetchUserData() async {
    final userData =
        await _userRepository.getUser(_authRepository.currentUser!.uid);

    if (userData != null) {
      return true;
    } else {
      return false;
    }
  }

  // Navigation to Sign Up Screen
  void goToSignUp() {
    Get.offNamed(Routes.signup);
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
