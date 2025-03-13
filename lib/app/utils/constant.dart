// App Constants for Medica App
abstract class AppConstants {
  // App Info
  static const String appName = "Medica";

  // Sign In Screen Strings
  static const String welcome = 'Welcome';
  static const String signIn = 'Sign In';
  static const String signInScreenText =
      "Welcome tho the Medica App, Please sign in to continue";
  static const String emailLabel = 'Email';
  static const String emailPlaceholder = 'Enter Your Email';
  static const String passwordLabel = 'Password';
  static const String passwordPlaceholder = 'Enter Your Password';
  static const String forgotPassword = 'Forgot Password';
  static const String signInButton = 'Sign In';
  static const String signInWithGoogle = 'Sign In With Google';
  static const String or = 'OR';
  static const String noAccountQuestion = 'Don\'t have an account?';
  static const String signUpLink = 'Sign Up';
  static const String emptyEmailError = 'Email cannot be empty';
  static const String invalidEmailError = 'Enter a valid email';
  // Password Errors
  static const String emptyPasswordError = "Password cannot be empty";
  static const String shortPasswordError = "Password must be more than 6 characters";
  static const String specialCharPasswordError = "Password must contain a special character";
  static const String numberPasswordError = "Password must contain at least one number";


  // Full Name Errors
  static const String emptyFullNameError = "Full name cannot be empty";
  static const String shortFullNameError = "Full name must be at least 3 characters long";

  // Contact Number Errors
  static const String emptyContactError = "Contact number cannot be empty";
  static const String invalidContactError = "Enter a valid 10-digit contact number";

  // Placeholder and Labels for Sign Up Screen
  static const String createNewAccount = 'Create New Account';
  static const String fullNameLabel = 'Full Name';
  static const String fullNamePlaceholder = 'Enter Your Full Name';
  static const String mobileNumberLabel = 'Mobile Number';
  static const String mobileNumberPlaceholder = 'Enter Your Phone Number';
  static const String signUpButton = 'Sign Up';
  static const String haveAccountQuestion = 'Already have an account?';
  static const String signInLink = 'Sign In';

  // Home Screen Strings
  static const String welcomeUser = 'Hi, Welcome Back,';
  static const String searchDoctorPlaceholder = 'Search a Doctor';
  static const String medicalCenter = 'Medical Center';
  static const String medicalCenterDescription =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed viverra ultrices libero et volutpat.';
  static const String categories = 'Categories';
  static const String allDoctors = 'All Doctors';
  static const String seeAll = 'See All';
  static const String dentiseth = 'Dentiseth';
  static const String therapist = 'Therapist';
  static const String surgeon = 'Surgeon';
  static const String book = 'Book';

  // Doctor List Screen Strings
  static const String allDoctorsTitle = 'All Doctors';
  static const String searchDoctorHint = 'Search a Doctor';

  // Doctor Details and Appointment Screen Strings
  static const String appointment = 'Appointment';
  static const String payment = 'Payment';
  static const String details = 'Details';
  static const String workingHours = 'Working Hours';
  static const String date = 'Date';
  static const String bookAnAppointment = 'Book an Appointment';

  // Date and Time Selection Screen Strings
  static const String selectDateAndTime = 'Select Date And Time';
  static const String availableTimeSlot = 'Available Time Slot';
  static const String setAppointment = 'Set Appointment';

  // Payment Screen Strings
  static const String doctorChangingPaymentMethod =
      'Doctor Changing Payment Method';
  static const String cardPayment = 'Card Payment';
  static const String cashPayment = 'Cash Payment';
  static const String cardNumber = 'Card Number';
  static const String expiryDate = 'Expiry Date';
  static const String cvv = 'CVV';
  static const String name = 'Name';
  static const String payNow = 'Pay Now';

  // Payment Success Screen Strings
  static const String congratulations = 'Congratulations';
  static const String paymentSuccessful =
      'Your Payment is Successfully Completed';
  static const String back = 'Back';
}

// Doctor Information Constants
class DoctorStrings {
  static const String drPawan = 'Dr. Pawan';
  static const String drWanitha = 'Dr. Wanitha';
  static const String drUdara = 'Dr. Udara';
  static const String drUpul = 'Dr. Upul';
  static const String dentiseth = 'Dentiseth'; // Specialty
}

// Rating Constants
class RatingStrings {
  static const String perfectRating = '5.0'; // Perfect rating value
}

// Calendar Strings
class CalendarStrings {
  static const String may = 'May';
  static const String year2023 = '2023';
  static const List<String> weekdaysShort = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
  static const List<String> dayAbbreviations = ['Sun', 'Mon', 'Tue'];
}

// Time Slot Strings for Appointment
class TimeSlotStrings {
  static const String slot1 = '10:00 AM';
  static const String slot2 = '11:00 AM';
  static const String slot3 = '12:00 PM';
}

// Payment Amount Constants
class PaymentStrings {
  static const String amount = '\$120.00'; // Example amount
}
