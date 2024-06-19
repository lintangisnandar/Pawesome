import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  static final FirebaseStorage _storage = FirebaseStorage.instance;

  static Future<String> uploadImage(String filePath, String fileName) async {
  File file = File(filePath);
  try {
    await _storage.ref(fileName).putFile(file);
    String downloadUrl = await _storage.ref(fileName).getDownloadURL();
    print('Image uploaded successfully: $downloadUrl'); // Log success
    return downloadUrl;
  } catch (e) {
    print('Error uploading image: $e'); // Log any errors
    return '';
  }
}
}
