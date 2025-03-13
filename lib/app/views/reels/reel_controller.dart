import 'dart:convert';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ReelController extends GetxController {
  final List<String> videoUrls = [];
  bool isLoading = false;
  final ImagePicker _picker = ImagePicker();

  // Cloudinary Config
  final String cloudName = "medicaapp";
  final String uploadPreset = "medicaapppreset";
  final String apiKey = "763694773583971"; // Replace with your API key
  final String apiSecret =
      "IsV8EH7desCiynnwPn5I3OWLGJc"; // Replace with your API secret

  @override
  void onInit() {
    fetchVideos();
    super.onInit();
  }

  // ✅ Fetch videos from Cloudinary
  Future<void> fetchVideos() async {
    isLoading = true;
    update(['videoList']);

    final url =
        Uri.parse("https://api.cloudinary.com/v1_1/$cloudName/resources/video");

    try {
      final response = await http.get(url, headers: {
        "Authorization":
            "Basic ${base64Encode(utf8.encode('$apiKey:$apiSecret'))}",
      });
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        videoUrls.clear();

        for (var resource in data['resources']) {
          if (resource['format'] == 'mp4') {
            // Ensure it's a video
            videoUrls.add(resource['secure_url']);
          }
          print(videoUrls);
        }
      } else {
        print("Failed to fetch videos: ${response.body}");
      }
    } catch (e) {
      print("Error fetching videos: $e");
    }

    isLoading = false;
    update(['videoList']);
  }

  // ✅ Upload video to Cloudinary
  Future<void> uploadVideo() async {
    final pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile == null) return;
    isLoading = true;
    update(['videoList']);
    final url =
        Uri.parse("https://api.cloudinary.com/v1_1/$cloudName/video/upload");

    var request = http.MultipartRequest("POST", url)
      ..fields['upload_preset'] = uploadPreset
      ..files.add(await http.MultipartFile.fromPath("file", pickedFile.path));
  
    var response = await request.send();
    if (response.statusCode == 200) {
      print("Video uploaded successfully!");
      fetchVideos(); // Refresh the video list after upload
    } else {
      print("Failed to upload video");
    }

    isLoading = false;
    update(['videoList']);
  }
}
