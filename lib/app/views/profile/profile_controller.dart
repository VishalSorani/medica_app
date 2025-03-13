import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medica_app/app/routes/app_pages.dart';
import 'package:medica_app/app/views/homeScreen/home_controller.dart';
import 'package:medica_app/app/views/mainscreen/main_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:medica_app/app/models/repository/user_repository.dart';
import 'package:medica_app/app/models/user.dart';
import 'package:path/path.dart' as path;

class ProfileController extends GetxController {
  bool isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserRepository _userRepository = UserRepository();
  Users? userData;
  String? profileImagePath; // Store the local image path

  @override
  void onInit() {
    super.onInit();
    getUserData();
    _loadLocalImagePath();
  }

  // 📸 Pick Profile Image & Save Locally
  Future<void> pickProfileImage() async {
    // isLoading = true;
    // update();

    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final File savedImage = await _saveImageLocally(File(pickedFile.path));
      profileImagePath = savedImage.path;

      // Save path to SharedPreferences
      await _saveLocalImagePath(profileImagePath!);

      // Update Firestore with new image path
      await _userRepository.updateUserData(_auth.currentUser!.uid, {
        'profileImage': profileImagePath,
      });
      await _loadLocalImagePath();
      print("page is loaded after image path changed");
      // isLoading = false;
      // update(); // Refresh UI
    }
  }

  // 💾 Save Image to Local Storage
  // Future<File> _saveImageLocally(File imageFile) async {
  //   final Directory appDir = await getApplicationDocumentsDirectory();
  //   final String fileName = path.basename(imageFile.path);
  //   final File localImage = File('${appDir.path}//$fileName');

  //   return await imageFile.copy(localImage.path);
  // }

  Future<File> _saveImageLocally(File imageFile) async {
    final Directory appDir = await getApplicationDocumentsDirectory();
    final String userId = _auth.currentUser!.uid; // Get user ID

    // Create a directory for the user inside the app storage
    final Directory userDir = Directory('${appDir.path}/$userId');
    if (!await userDir.exists()) {
      await userDir.create(recursive: true); // Create folder if missing
    }

    final String fileName = path.basename(imageFile.path);
    final File localImage = File('${userDir.path}/$fileName');

    return await imageFile.copy(localImage.path);
  }

  // 🔄 Load Image Path from SharedPreferences
  Future<void> _loadLocalImagePath() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userId = _auth.currentUser?.uid ?? ''; // Get current user ID
    profileImagePath = prefs
        .getString('profileImagePath_$userId'); // Get path specific to user
    print(profileImagePath);
    update();
  }

  // 🔒 Save Image Path in SharedPreferences
  // 🔒 Save Image Path in SharedPreferences
  Future<void> _saveLocalImagePath(String path) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userId = _auth.currentUser!.uid; // Get current user ID
    await prefs.setString('profileImagePath_$userId', path);
  }

  // 👤 Fetch User Data from Firestore
  void getUserData() async {
    isLoading = true;
    update();
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      userData = await _userRepository.getUser(currentUser.uid);
      print(userData);
      update();
    }
    isLoading = false;
    update();
  }

  // // 🚀 Clear Image Path on Logout
  // Future<void> _clearImagePathOnLogout() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final String userId = _auth.currentUser?.uid ?? '';

  //   // Remove the saved image path
  //   await prefs.remove('profileImagePath_$userId');
  //   profileImagePath = null; // Reset in memory

  //   update();
  // }

  // 🔓 Sign Out
  void signOutUser() async {
    // await _clearImagePathOnLogout();
    Get.delete<ProfileController>(force: true);
    Get.delete<MainController>(force: true);
    Get.delete<HomeController>(force: true);
    await _auth.signOut();
    Get.offAllNamed(Routes.signin);
  }
}
