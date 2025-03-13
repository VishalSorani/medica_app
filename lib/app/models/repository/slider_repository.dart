import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medica_app/app/models/slider_model.dart';

class SliderRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<SliderModel>> getSliders() async {
    try {
      var snapshot = await _firestore.collection('slider').get();
      return snapshot.docs.map((doc) {
        return SliderModel.fromJson(doc.data(), doc.id);
      }).toList();
    } catch (e) {
      print("Error fetching sliders: $e");
      return [];
    }
  }
}
