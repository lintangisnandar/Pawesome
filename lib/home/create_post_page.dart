import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'services/firestore_service.dart';
import 'services/storage_service.dart';

class CreatePostPage extends StatefulWidget {
  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  String? selectedLabel;
  File? _imageFile;

  // Placeholder username
  final String _username = 'Guest123';

  Future<File?> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  Future<void> _submitPost() async {
  if (_formKey.currentState!.validate()) {
    _formKey.currentState!.save();
    String imageUrl = '';

    // Log the current state
    print('Form validated and saved. Message: ${_controller.text}');

    if (_imageFile != null) {
      String filePath = _imageFile!.path;
      String fileName = 'images/${DateTime.now().millisecondsSinceEpoch}.jpg';
      imageUrl = await StorageService.uploadImage(filePath, fileName);
      print('Image URL: $imageUrl'); // Log the image URL
    } else {
      print('No image selected'); // Log if no image is selected
    }

    final newPost = {
      'username': _username, // Use placeholder username
      'message': _controller.text,
      'imageUrl': imageUrl,
      'time': FieldValue.serverTimestamp(),
      'label': selectedLabel ?? 'No Label',
      'likes': 0,
    };

    try {
      await FirestoreService.addPost(newPost);
      print('Post added: $newPost'); // Log the new post
      Navigator.pop(context, newPost);
    } catch (e) {
      print('Error submitting post: $e'); // Log any errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit post')),
      );
    }
  } else {
    print('Form is not valid'); // Log if the form is not valid
  }
}


@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.close, color: Colors.brown),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      actions: [
        TextButton(
          onPressed: _submitPost,
          child: Text(
            'Send',
            style: TextStyle(color: Colors.brown),
          ),
        ),
      ],
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage('https://via.placeholder.com/150'), // Replace with user's profile picture URL
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Katakan sesuatu...',
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a message';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            Divider(color: Colors.brown),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.image, color: Colors.brown),
                  onPressed: () async {
                    final file = await _pickImage();
                    setState(() {
                      _imageFile = file;
                    });
                  },
                ),
                _buildLabelButton('Missing'),
                SizedBox(width: 10),
                _buildLabelButton('Found'),
                SizedBox(width: 10),
                _buildLabelButton('In Need'),
              ],
            ),
            if (_imageFile != null)
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Image.file(_imageFile!),
              ),
          ],
        ),
      ),
    ),
  );
}



  Widget _buildLabelButton(String label) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedLabel = selectedLabel == label ? null : label;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: selectedLabel == label ? Colors.brown : Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.brown),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selectedLabel == label ? Colors.white : Colors.brown,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
