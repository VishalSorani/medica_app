// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:medica_app/app/utils/constant.dart';
// import 'package:medica_app/app/utils/fonts.dart';
// import 'package:medica_app/app/utils/colors.dart';
// import 'package:medica_app/app/views/signin/signin_controller.dart';
// import 'package:medica_app/app/views/signin/widget/textfield.dart';
// import 'package:medica_app/app/widgets/custom_button.dart';

// class SigninScreen extends StatelessWidget {
//   const SigninScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<SigninController>(
//       init: SigninController(),
//       id: SigninController.togglePassword,
//       builder: (controller) => Scaffold(
//         resizeToAvoidBottomInset: true,
//         body: SafeArea(
//           child: LayoutBuilder(
//             builder: (context, constraints) {
//               return SingleChildScrollView(
//                 physics: const BouncingScrollPhysics(),
//                 child: ConstrainedBox(
//                   constraints: BoxConstraints(
//                     minHeight: constraints.maxHeight,
//                   ),
//                   child: IntrinsicHeight(
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 22.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: [
//                           SizedBox(height: 28),
//                           Center(
//                             child: Text(AppConstants.welcome,
//                                 style: FMPTextTheme.instance.displayMedium,
//                                 textScaler: TextScaler.linear(1)),
//                           ),
//                           SizedBox(height: 20),
//                           Text(AppConstants.signIn,
//                               style: FMPTextTheme.instance.displayMedium
//                                   ?.copyWith(color: AppColors.blackColor),
//                               textScaler: TextScaler.linear(1)),
//                           const SizedBox(height: 10),
//                           Text(AppConstants.dummyText,
//                               style: FMPTextTheme.instance.displayExtraSmall
//                                   ?.copyWith(fontSize: 16),
//                               textScaler: TextScaler.linear(1)),
//                           SizedBox(height: 48),

//                           // Custom Email TextField
//                           CustomTextField(
//                             hintText: AppConstants.emailPlaceholder,
//                             labelText: AppConstants.emailLabel,
//                             controller: controller.emailController,
//                             keyboardType: TextInputType.emailAddress,
//                             onChanged: (value) => controller.validateEmail(value),
//                             validator: controller.emailError.value.isEmpty
//                                 ? null
//                                 : (value) {
//                                     return controller.emailError.value;
//                                   },
//                           ),
//                           SizedBox(height: 20),

//                           // Custom Password TextField
//                           CustomTextField(
//                             hintText: AppConstants.passwordPlaceholder,
//                             labelText: AppConstants.passwordLabel,
//                             controller: controller.passwordController,
//                             keyboardType: TextInputType.text,
//                             obscureText: controller.isObscure,
//                             onChanged: (value) => controller.validatePassword(value),
//                             suffixIcon: IconButton(
//                               icon: Icon(
//                                 controller.isObscure
//                                     ? Icons.visibility_off
//                                     : Icons.visibility,
//                                 color: AppColors.primaryColor,
//                               ),
//                               onPressed: controller.onTapToggle,
//                             ),
//                             validator: controller.passwordError.value.isEmpty
//                                 ? null
//                                 : (value) {
//                                     return controller.passwordError.value;
//                                   },
//                           ),
//                           SizedBox(height: 10),

//                           Align(
//                             alignment: Alignment.centerRight,
//                             child: TextButton(
//                               onPressed: () {
//                                 Get.snackbar("Forgot Password", "Reset Password feature");
//                               },
//                               child: Text(
//                                 AppConstants.forgotPassword,
//                                 style: FMPTextTheme.instance.displayExtraSmall?.copyWith(
//                                   color: AppColors.blackColor,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 14,
//                                 ),
//                               ),
//                             ),
//                           ),

//                           SizedBox(height: 60),

//                           // SignIn Button
//                           CustomButton(
//                             text: AppConstants.signInButton,
//                             onPressed: () {
//                               final email = controller.emailController.text;
//                               final password = controller.passwordController.text;

//                               if (controller.emailError.value.isNotEmpty ||
//                                   controller.passwordError.value.isNotEmpty) {
//                                 Get.snackbar("Error", "Please fix the errors");
//                                 return;
//                               }

//                               if (email.contains('@') &&
//                                   password.length > 6 &&
//                                   RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(password) &&
//                                   RegExp(r'[0-9]').hasMatch(password)) {
//                                 Get.snackbar("Success", "Login Successful");
//                               }
//                             },
//                             paddingVertical: 15,
//                           ),
//                           SizedBox(height: 15),
//                           Center(
//                             child: Text(
//                               AppConstants.or,
//                               style: FMPTextTheme.instance.displayExtraSmall
//                                   ?.copyWith(color: AppColors.lightTextColor, fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                           SizedBox(height: 15),

//                           // Google SignIn Button
//                           CustomButton(
//                             text: AppConstants.signInWithGoogle,
//                             onPressed: () {},
//                             paddingVertical: 15,
//                             color: AppColors.lightTextColor,
//                           ),
//                           const Expanded(
//                             child: SizedBox(), // Using Expanded instead of Spacer
//                           ),
//                           Center(
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   AppConstants.noAccountQuestion,
//                                   style: FMPTextTheme.instance.displayExtraSmall
//                                       ?.copyWith(
//                                     color: AppColors.lightTextColor,
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 TextButton(
//                                   onPressed: () {},
//                                   child: Text(AppConstants.signUpLink,
//                                       style: FMPTextTheme.instance.displayExtraSmall
//                                           ?.copyWith(
//                                         color: AppColors.primaryColor,
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.bold,
//                                       )),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
