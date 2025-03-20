import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica_app/app/utils/constant.dart';
import 'package:medica_app/app/utils/fonts.dart';
import 'package:medica_app/app/utils/colors.dart';
import 'package:medica_app/app/views/signin/signin_controller.dart';
import 'package:medica_app/app/widgets/textfield.dart';
import 'package:medica_app/app/widgets/custom_elevated_button.dart';
import 'package:medica_app/app/widgets/custom_text_button.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SigninController>(
      init: SigninController(),
      id: SigninController.togglePassword,
      builder: (controller) => Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            AppConstants.welcome, // Use the welcome text in AppBar
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
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22.0),
                      child: Form(
                        key: controller.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 20),
                            Text(AppConstants.signIn,
                                style: FMPTextTheme.instance.displayMedium
                                    ?.copyWith(color: AppColors.black)),
                            const SizedBox(height: 10),
                            Text(AppConstants.signInScreenText,
                                style: FMPTextTheme.instance.displayExtraSmall
                                    ?.copyWith(fontSize: 14)),
                            const SizedBox(height: 48),

                            // Error Message Above Email Field
                            GetBuilder<SigninController>(
                              id: SigninController.emailErrorText,
                              builder: (controller) {
                                return controller.emailError.isNotEmpty
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8.0),
                                        child: Text(
                                          controller.emailError,
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 14),
                                        ),
                                      )
                                    : SizedBox.shrink();
                              },
                            ),
                            // Email Field
                            CustomTextField(
                              hintText: AppConstants.emailPlaceholder,
                              labelText: AppConstants.emailLabel,
                              controller: controller.emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (p0) =>
                                  controller.validateEmail(p0 ?? ""),
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
                              // validator: controller.passwordError.value.isEmpty
                              //     ? null
                              //     : (value) {
                              //         return controller.passwordError.value;
                              //       },
                              validator: (p0) =>
                                  controller.validatePassword(p0 ?? ""),
                            ),

                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  Get.snackbar("Forgot Password",
                                      "Reset Password feature");
                                },
                                child: Text(
                                  AppConstants.forgotPassword,
                                  style: FMPTextTheme.instance.displayExtraSmall
                                      ?.copyWith(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 36),

                            // Sign-In Button with Loader
                            GetBuilder<SigninController>(
                                id: SigninController.loginButton,
                                builder: (ctx) {
                                  return CustomButton(
                                    text: ctx.isSigninLoading
                                        ? null
                                        : AppConstants
                                            .signInButton, // Hide text when loading
                                    onPressed: ctx.isSigninLoading
                                        ? null
                                        : ctx.validateAndLogin,
                                    paddingVertical: 12,
                                    child: controller.isSigninLoading
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
                            GetBuilder<SigninController>(
                                id: SigninController.loginButton,
                                builder: (ctx) {
                                  return CustomButton(
                                    text: ctx.isGoogleLoading
                                        ? null
                                        : AppConstants
                                            .signInWithGoogle, // Hide text when loading
                                    onPressed:
                                        ctx.isGoogleLoading ? null : ctx.googleSignIn,
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

                            const SizedBox(height: 15),

                            

                            const SizedBox(height: 28),

                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    AppConstants.noAccountQuestion,
                                    style: FMPTextTheme
                                        .instance.displayExtraSmall
                                        ?.copyWith(
                                      color: AppColors.lightTextColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  CustomTextButton(
                                    text: AppConstants.signUpLink,
                                    onPressed: controller
                                        .goToSignUp, // Call the method from controller
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
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
