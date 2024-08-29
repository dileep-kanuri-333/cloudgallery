import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{
  Stream<Map<String, dynamic>> getImageDetailsStreamById(String id,String profileimage) {
  try {
    CollectionReference imageSubCollection = FirebaseFirestore.instance.collection("images").doc(id).collection(profileimage);

    return imageSubCollection.doc(profileimage).snapshots().map((snapshot) {
      if (snapshot.exists) {
        // Retrieve profile image URL from document data
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        return data;
      } else {
        // Document doesn't exist, return empty map
        return {};
      }
    });
  } catch (error) {
    // Handle errors
    print('Error getting image details stream: $error');
    // Return an empty stream in case of error
    return Stream.value({});
  }
}
}