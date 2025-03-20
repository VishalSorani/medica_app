import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medica_app/app/models/repository/user_repository.dart';
import 'package:medica_app/app/models/user.dart';
import 'package:medica_app/app/routes/app_pages.dart';
import 'package:medica_app/app/views/homeScreen/home_controller.dart';
import 'package:medica_app/app/views/mainscreen/main_controller.dart';
import 'package:medica_app/app/views/profile/profile_controller.dart';
import 'package:medica_app/app/views/reels/reel_controller.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final UserRepository _userRepository = UserRepository();

  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Sign In
  Future<String?> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: email.trim(), // Trim spaces
          password: password.trim() // Trim spaces
          );

      return null; // No error, successful login
    } on FirebaseAuthException catch (e) {
      return _handleAuthError(e);
    } catch (e) {
      return 'An error occurred. Please try again.';
    }
  }

  Future<String?> signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return _handleAuthError(e);
    } catch (e) {
      return 'An unexpected error occurred.';
    }
  }

  Future<void> googleSignIn() async {
    try {
      // Trigger the Google Authentication flow

      await _googleSignIn.signOut();
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // If the user cancels the sign-in, return early
      if (googleUser == null) {
        print('Google Sign-In cancelled by user.');
        return;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      // Check if user data already exists in Firestore
      final bool userExists = await _userRepository
          .getUser(userCredential.user!.uid)
          .then((data) => data != null);
      print('User ID: ${userCredential.user?.uid}');
      print('User Name: ${userCredential.user?.displayName}');
      print('User Email: ${userCredential.user?.email}');
      print('User Profile Image: ${userCredential.user?.photoURL}');

      if (userExists) {
        print('User data already exists. Navigating to Home Screen.');
        Get.offAllNamed(Routes.mainscreen);
      } else {
        // If new user, save their data in Firestore
        final data = Users(
          id: userCredential.user!.uid,
          name: userCredential.user!.displayName ?? '',
          contactNumber: '',
          reels: [],
          isAdmin: false,
          createdAt: DateTime.now(),
          email: userCredential.user!.email ?? 'No Email',
          profileImage: userCredential.user?.photoURL ?? '',
        );
        await _userRepository.saveUserData(
          user: data,
        );
        print('New Google User Registered. Navigating to Home Screen.');
        Get.offAllNamed(Routes.mainscreen);
      }
    } catch (e) {
      print('Google Sign-In Error: $e');
      Get.snackbar(
        'Sign-In Error',
        'Failed to sign in with Google. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> signout() async {
    Get.delete<ProfileController>(force: true);
    Get.delete<ReelController>(force: true);
    Get.delete<HomeController>(force: true);
    await _auth.signOut();
  }

  String _handleAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found with this email.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'email-already-in-use':
        return 'Email is already in use. Try another one.';
      case 'invalid-email':
        return 'Invalid email address.';
      case 'weak-password':
        return 'Password is too weak.';
      case 'invalid-credential':
        return 'Invalid credentials. Please check your email and password.';
      default:
        return 'An error occurred. Please try again.';
    }
  }
}
