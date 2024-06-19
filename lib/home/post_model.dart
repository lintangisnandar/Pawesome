import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String username;
  final String message;
  final String imageUrl;
  final String time;
  final String label;
  int likes; // Add this field
  bool isLiked; // Add this field

  Post({
    required this.username,
    required this.message,
    required this.imageUrl,
    required this.time,
    required this.label,
    this.likes = 0, // Initialize likes
    this.isLiked = false, // Initialize isLiked
  });

  factory Post.fromDocument(DocumentSnapshot doc) {
    return Post(
      username: doc['username'],
      message: doc['message'],
      imageUrl: doc['imageUrl'],
      time: (doc['time'] as Timestamp).toDate().toString(),
      label: doc['label'],
      likes: doc['likes'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'message': message,
      'imageUrl': imageUrl,
      'time': time,
      'label': label,
      'likes': likes,
    };
  }
}
