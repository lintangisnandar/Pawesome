import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/home/post_model.dart';

class FirestoreService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> addPost(Map<String, dynamic> postData) async {
  try {
    await _db.collection('posts').add(postData);
    print('Post successfully added to Firestore'); // Log success
  } catch (e) {
    print('Error adding post: $e'); // Log any errors
    throw e; // Rethrow to catch in the UI
  }
}


  Stream<List<Post>> getPosts() {
    return _db.collection('posts').snapshots().map((snapshot) =>
      snapshot.docs.map((doc) => Post.fromDocument(doc)).toList());
  }
}

