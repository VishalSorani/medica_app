import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medica_app/app/models/category_model.dart';

class CategoryRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final String collection = 'categories';

 
  Future<List<Category>> getCategories() async {
    try {
      var snapshot = await _firestore.collection(collection).get();
      return snapshot.docs.map((doc) {
        return Category.fromJson(doc.data(), doc.id);
      }).toList();
    } catch (e) {
      print("Error fetching categories: $e");
      return [];
    }
  }

Future<void> addCategories() async {
  try {
    // Define 6 category names
    List<String> categoryNames = [
      'Cardiology',
      'Dermatology',
      'Neurology',
      'Pediatrics',
      'Orthopedics',
    ];

    // Add each category to Firestore
    for (String name in categoryNames) {
      await _firestore.collection('categories').add({
        'name': name,
      });
    }

    print('6 Categories added successfully!');
  } catch (e) {
    print('Error adding categories: $e');
  }
}

}
