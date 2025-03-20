import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica_app/app/routes/app_pages.dart';
import 'package:medica_app/app/utils/constant.dart';
import 'package:medica_app/app/utils/fonts.dart';
import 'package:medica_app/app/utils/colors.dart';
import 'package:medica_app/app/views/signup/signup_controller.dart';
import 'package:medica_app/app/widgets/textfield.dart';
import 'package:medica_app/app/widgets/custom_elevated_button.dart';
import 'package:medica_app/app/widgets/custom_text_button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(
      init: SignUpController(),
      id: SignUpController.togglePassword,
      builder: (controller) => Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            AppConstants.createNewAccount, // Use the welcome text in AppBar
            style: FMPTextTheme.instance.displayMedium
                ?.copyWith(color: AppColors.primaryColor),
          ),
        ),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22.0),
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 36),

                          // Error Message Above Full Name Field
                          GetBuilder<SignUpController>(
                            id: SignUpController.signUpErrorText,
                            builder: (controller) {
                              return controller.signUpError.isNotEmpty
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Text(
                                        controller.signUpError,
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 14),
                                      ),
                                    )
                                  : SizedBox.shrink();
                            },
                          ),

                          // Full Name Field
                          CustomTextField(
                            hintText: AppConstants.fullNamePlaceholder,
                            labelText: AppConstants.fullNameLabel,
                            controller: controller
                                .fullNameController, // Change to fullNameController
                            keyboardType: TextInputType
                                .name, // Set appropriate keyboard type

                            validator: (p0) =>
                                controller.validateFullName(p0 ?? ""),
                          ),

                          const SizedBox(height: 20),

                          // Password Field
                          CustomTextField(
                            hintText: AppConstants.passwordPlaceholder,
                            labelText: AppConstants.passwordLabel,
                            controller: controller.passwordController,
                            keyboardType: TextInputType.text,
                            obscureText: controller.isObscure,
                            // onChanged: (value) =>
                            //     controller.validatePassword(value),
                            suffixIcon: IconButton(
                              icon: Icon(
                                controller.isObscure
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: AppColors.primaryColor,
                              ),
                              onPressed: controller.onTapToggle,
                            ),
                            validator: (p0) =>
                                controller.validatePassword(p0 ?? ""),
                          ),

                          const SizedBox(height: 20),

                          CustomTextField(
                            hintText: AppConstants.emailPlaceholder,
                            labelText: AppConstants.emailLabel,
                            controller: controller.emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (p0) =>
                                controller.validateEmail(p0 ?? ""),
                          ),
                          const SizedBox(height: 20),

                          CustomTextField(
                            hintText: AppConstants.mobileNumberPlaceholder,
                            labelText: AppConstants.mobileNumberLabel,
                            controller: controller
                                .contactNumberController, // Change to contactNumberController
                            keyboardType: TextInputType
                                .phone, // Set appropriate keyboard type

                            validator: (p0) =>
                                controller.validateContactNumber(p0 ?? ""),
                          ),

                          const SizedBox(height: 36),

                          // Sign-In Button with Loader
                          GetBuilder<SignUpController>(
                              id: SignUpController.signUpButton,
                              builder: (ctx) {
                                return AbsorbPointer(
                                  absorbing: ctx.isSignupLoading,
                                  child: CustomButton(
                                    text: ctx.isSignupLoading
                                        ? null
                                        : AppConstants
                                            .signUpButton, // Hide text when loading
                                    onPressed: ctx.isSignupLoading
                                        ? null
                                        : ctx.validateAndSignUp,
                                    paddingVertical: 12,
                                    child: controller.isSignupLoading
                                        ? SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 2,
                                            ),
                                          )
                                        : null, // Show loader instead of text
                                  ),
                                );
                              }),

                          const SizedBox(height: 15),

                          Center(
                            child: Text(
                              AppConstants.or,
                              style: FMPTextTheme.instance.displayExtraSmall
                                  ?.copyWith(
                                      color: AppColors.lightTextColor,
                                      fontWeight: FontWeight.bold),
                            ),
                          ),

                          const SizedBox(height: 15),

                          
                          GetBuilder<SignUpController>(
                              id: SignUpController.signUpButton,
                              builder: (ctx) {
                                return CustomButton(
                                  text: ctx.isGoogleLoading
                                      ? null
                                      : AppConstants
                                          .signInWithGoogle, // Hide text when loading
                                  onPressed: ctx.isGoogleLoading
                                      ? null
                                      : ctx.googleSignIn,
                                  paddingVertical: 12,
                                  child: controller.isGoogleLoading
                                      ? SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : null, // Show loader instead of text
                                );
                              }),

                          const SizedBox(height: 28),

                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppConstants.haveAccountQuestion,
                                  style: FMPTextTheme.instance.displayExtraSmall
                                      ?.copyWith(
                                    color: AppColors.lightTextColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                CustomTextButton(
                                  text: AppConstants.signInLink,
                                  onPressed: () {
                                    Get.offNamed(Routes.signin);
                                  }, // Call the method from controller
                                  color: AppColors.primaryColor,
                                  paddingHorizontal: 10,
                                  fontSize: 12,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
