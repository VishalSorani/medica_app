import 'dart:convert';
import 'dart:developer';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:medica_app/app/views/profile/profile_controller.dart';

class ReelController extends GetxController {
  static String videoList = 'VIDEO_LIST';

  final List<String> videoUrls = [];
  bool isLoading = false;
  bool isUploadLoading = false;
  final ImagePicker _picker = ImagePicker();
  int currentIndex = 0;

  // Cloudinary Config
  final String cloudName = "medicaapp";
  final String uploadPreset = "medicaapppreset";
  final String apiKey = "763694773583971";
  final String apiSecret = "IsV8EH7desCiynnwPn5I3OWLGJc";

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onInit() {
      fetchVideos();
    
    super.onInit();
  }

  void resetVideos(bool isFromProfile,
      [List<String>? videoUrls, int index = 0]) {
    if (isFromProfile && videoUrls != null) {
      if (index != 0) {
      String temp = videoUrls[0];
      videoUrls[0] = videoUrls[index];
      videoUrls[index] = temp;
    }

      currentIndex = index;
      this.videoUrls.clear();
      this.videoUrls.addAll(videoUrls);
      update([videoList]);
      // fetchVideos();
    } else {
      fetchVideos();
    }
  }

  // Fetch videos from Cloudinary
  Future<void> fetchVideos() async {
    try {
      isLoading = true;
      update([videoList]);

      
      // If no videos from Firestore, fetch from Cloudinary
      final url = Uri.parse(
          "https://api.cloudinary.com/v1_1/$cloudName/resources/video");

      final response = await http.get(
        url,
        headers: {
          "Authorization":
              "Basic ${base64Encode(utf8.encode('$apiKey:$apiSecret'))}",
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        videoUrls.clear();

        for (var resource in data['resources']) {
          if (resource['format'] == 'mp4') {
            videoUrls.add(resource['secure_url']);
          }
        }
        videoUrls.shuffle(Random());
        print("Fetched videos: ${videoUrls}");
      } else {
        print(
            "Failed to fetch videos: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Error fetching videos: $e");
    } finally {
      isLoading = false;
      update([videoList]);
    }
  }



  // Upload video to Cloudinary
  Future<void> uploadVideo() async {
    try {
      isUploadLoading = true;
      update([videoList]);
      Get.find<ProfileController>().update();

      final XFile? pickedFile =
          await _picker.pickVideo(source: ImageSource.gallery);
      if (pickedFile == null) return;

      final url =
          Uri.parse("https://api.cloudinary.com/v1_1/$cloudName/video/upload");

      var request = http.MultipartRequest("POST", url)
        ..fields['upload_preset'] = uploadPreset
        ..files.add(await http.MultipartFile.fromPath("file", pickedFile.path));

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        String videoUrl = jsonResponse['secure_url'];

        // Save video URL to user's Firestore document
        await saveVideoToUser(videoUrl);

        // Add to local list and update UI
        videoUrls.add(videoUrl);
        // update([videoList]);

        Get.snackbar(
          'Success',
          'Video uploaded successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        print(
            "Failed to upload video: ${response.statusCode} - ${response.body}");
        Get.snackbar(
          'Error',
          'Failed to upload video',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      print("Error uploading video: $e");
      Get.snackbar(
        'Error',
        'An error occurred while uploading',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isUploadLoading = false;
      update([videoList]);
      Get.find<ProfileController>().update();
    }
  }



  Future<void> saveVideoToUser(String videoUrl) async {
    final userId = _auth.currentUser?.uid;

    if (userId == null) {
      print("Cannot save video: User not logged in");
      return;
    }

    try {
      if (Get.isRegistered<ProfileController>()) {
        final reels = Get.find<ProfileController>().userData;
        reels?.reels.add(videoUrl);
        Get.find<ProfileController>().userData = reels;

        print("new user: ${Get.find<ProfileController>().userData}");
      }
      final userDoc =
          FirebaseFirestore.instance.collection('users').doc(userId);

      // First check if the document exists
      final docSnapshot = await userDoc.get();

      if (docSnapshot.exists) {
        // Update existing document
        await userDoc.update({
          'reels': FieldValue.arrayUnion([videoUrl])
        });
      } else {
        // Create new document with reels array
        await userDoc.set({
          'reels': [videoUrl]
        });
      }

      print("Video URL saved to user's Firestore successfully");
    } catch (e) {
      print("Error saving video to user: $e");
      throw e; // Re-throw to handle in calling function
    }
  }

  // For handling video deletion if needed
  Future<void> deleteVideo(String videoUrl) async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) return;

      // Remove from Firestore
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'reels': FieldValue.arrayRemove([videoUrl])
      });

      // Remove from local list
      videoUrls.remove(videoUrl);
      update(['videoList']);

      Get.snackbar(
        'Success',
        'Video removed successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      print("Error deleting video: $e");
      Get.snackbar(
        'Error',
        'Failed to delete video',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
