import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica_app/app/models/repository/auth_repository.dart';
import 'package:medica_app/app/models/repository/user_repository.dart';
import 'package:medica_app/app/models/user.dart';
import 'package:medica_app/app/routes/app_pages.dart';
import 'package:medica_app/app/utils/constant.dart';
import 'package:medica_app/app/views/signin/signin_controller.dart';

class SignUpController extends GetxController {
  static const togglePassword = 'togglePassword';
  static const signUpButton = 'signUpButton';
  static const signUpErrorText = 'signUpErrorText';

  final formKey = GlobalKey<FormState>();

  final fullNameController = TextEditingController();
  final contactNumberController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final SigninController signinController = Get.put(SigninController());

  bool isObscure = true;
  bool isSignupLoading = false;
  bool isGoogleLoading = false;

  String signUpError = '';

  final AuthRepository _authRepository = AuthRepository();
  final UserRepository _userRepository = UserRepository();

  // Toggle Password Visibility
  void onTapToggle() {
    isObscure = !isObscure;
    update([togglePassword]);
  }

  // Full Name Validation
  String? validateFullName(String value) {
    if (value.isEmpty) {
      return AppConstants.emptyFullNameError;
    } else if (value.length < 3) {
      return AppConstants.shortFullNameError;
    }
    return null;
  }

  // Contact Number Validation
  String? validateContactNumber(String value) {
    if (value.isEmpty) {
      return AppConstants.emptyContactError;
    } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
      return AppConstants.invalidContactError;
    }
    return null;
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
    } else if (value.length <= 6) {
      return AppConstants.shortPasswordError;
    } else if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return AppConstants.specialCharPasswordError;
    }
    return null;
  }

  // Sign Up Function
  void validateAndSignUp() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    isSignupLoading = true;
    update([signUpButton]);

    String? errorMessage = await _authRepository.signUp(
      emailController.text,
      passwordController.text,
    );

    if (errorMessage != null) {
      isSignupLoading = false;
      signUpError = errorMessage;
      update([signUpButton, signUpErrorText]);
      return;
    }

    // Get Current User's ID
    final userId = _authRepository.currentUser?.uid;
    if (userId == null) {
      isSignupLoading = false;
      signUpError = "User ID not found. Please try again.";
      update([signUpButton, signUpErrorText]);
      return;
    }

    Users user = Users(
      id: userId,
      name: fullNameController.text.trim(),
      isAdmin: false,
      contactNumber: contactNumberController.text.trim(),
      createdAt: DateTime.now(),
      profileImage: '',
      reels: [],
      email: emailController.text.trim(),
    );

    // Save User Data in Firestore
    try {
      await _userRepository.saveUserData(user: user);
      signUpError = '';
      update([signUpErrorText]);
      Get.offAllNamed(Routes.mainscreen);
    } catch (e) {
      signUpError = 'Failed to save user data. Please try again.';
      update([signUpErrorText]);
    } finally {
      isSignupLoading = false;
      update([signUpButton]);
    }
  }

  void googleSignIn() {
    print('googleSignIn done in signup ');
    isGoogleLoading = true;
    update([signUpButton]);
    signinController.googleSignIn();
    isGoogleLoading = false;
    update([signUpButton]);
  }

  // Clear Controllers on Dispose
  @override
  void onClose() {
    fullNameController.dispose();
    contactNumberController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
