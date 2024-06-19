import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'services/storage_service.dart';
import 'services/firestore_service.dart';
import 'post_model.dart';
import 'post_widget.dart';
import 'create_post_page.dart';
import 'news_page.dart';
import 'events_page.dart';

class AddPostPage extends StatefulWidget {
  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _message = '';
  String _label = 'Missing';
  File? _imageFile;

  Future<File?> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Post'),
        backgroundColor: Colors.brown,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Username'),
                onSaved: (value) {
                  _username = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Message'),
                onSaved: (value) {
                  _message = value!;
                },
              ),
              DropdownButtonFormField<String>(
                value: _label,
                items: ['Missing', 'Found', 'In Need'].map((label) {
                  return DropdownMenuItem(
                    value: label,
                    child: Text(label),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _label = value!;
                  });
                },
                decoration: InputDecoration(labelText: 'Label'),
              ),
              TextButton(
                onPressed: () async {
                  final file = await _pickImage();
                  setState(() {
                    _imageFile = file;
                  });
                },
                child: Text('Pick Image'),
              ),
              if (_imageFile != null)
                Image.file(
                  _imageFile!,
                  height: 200,
                ),
              ElevatedButton(
                onPressed: () async {
                  _formKey.currentState!.save();
                  String imageUrl = '';

                  // if (_imageFile != null) {
                  //   imageUrl = await StorageService.uploadImage(
                  //     _imageFile!.path,
                  //     'unique_image_name.jpg',
                  //   );
                  // }

                  final newPost = {
                    'username': _username,
                    'message': _message,
                    'imageUrl': imageUrl,
                    'time': FieldValue.serverTimestamp(),
                    'label': _label,
                    'likes': 0,
                  };
                  await FirestoreService.addPost(newPost);
                  Navigator.pop(context);
                },
                child: Text('Add Post'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePosts extends StatefulWidget {
  final String title;

  const HomePosts({Key? key, required this.title}) : super(key: key);

  @override
  _HomePostsState createState() => _HomePostsState();
}

class _HomePostsState extends State<HomePosts> with SingleTickerProviderStateMixin {
  String selectedLabel = 'All';
  int _currentIndex = 0;
  late TabController _tabController;

  final List<Post> dummyPosts = [
    Post(
      username: 'JJ Maybank',
      message: 'Halo, ada yang lihat kucing aku gak ya? Hilang di sekitar Kalimasada.',
      imageUrl: 'https://via.placeholder.com/150',
      time: '2 mins',
      label: 'Missing',
      likes: 10,
    ),
    Post(
      username: 'John B',
      message: 'Hai guys aku nemu kucing ini nih, deket pasar Banaran. Ada yang merasa punya?',
      imageUrl: 'https://via.placeholder.com/150',
      time: '1 hour',
      label: 'Found',
      likes: 20,
    ),
    Post(
      username: 'Sarah Cameron',
      message: 'Kucingku butuh perawatan medis. Ada yang tahu klinik hewan terdekat yang buka? Klinik langgananku libur hari ini.',
      imageUrl: 'https://via.placeholder.com/150',
      time: '3 hours',
      label: 'In Need',
      likes: 25,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Post> filteredPosts() {
    if (selectedLabel == 'All') {
      return dummyPosts;
    } else {
      return dummyPosts.where((post) => post.label == selectedLabel).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'PAWESOME',
            style: TextStyle(
              color: Colors.brown,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(100.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search',
                            hintStyle: TextStyle(color: Colors.brown),
                            prefixIcon: const Icon(Icons.search, color: Colors.brown),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.brown),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.brown),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.brown),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.notifications, color: Colors.brown),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                TabBar(
                  controller: _tabController,
                  labelColor: Colors.brown,
                  unselectedLabelColor: Colors.brown,
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
                  indicatorColor: Colors.brown,
                  indicatorWeight: 3.0,
                  tabs: const [
                    Tab(text: 'Posts'),
                    Tab(text: 'News'),
                    Tab(text: 'Events'),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            Column(
              children: [
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FilterButton(
                        label: 'Missing',
                        isSelected: selectedLabel == 'Missing',
                        onTap: () {
                          setState(() {
                            selectedLabel = 'Missing';
                          });
                        },
                      ),
                      FilterButton(
                        label: 'Found',
                        isSelected: selectedLabel == 'Found',
                        onTap: () {
                          setState(() {
                            selectedLabel = 'Found';
                          });
                        },
                      ),
                      FilterButton(
                        label: 'In Need',
                        isSelected: selectedLabel == 'In Need',
                        onTap: () {
                          setState(() {
                            selectedLabel = 'In Need';
                          });
                        },
                      ),
                      FilterButton(
                        label: 'All',
                        isSelected: selectedLabel == 'All',
                        onTap: () {
                          setState(() {
                            selectedLabel = 'All';
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  // child: StreamBuilder<List<Post>>(
                  //   stream: FirestoreService().getPosts(),
                  //   builder: (context, snapshot) {
                  //     if (snapshot.connectionState == ConnectionState.waiting) {
                  //       return Center(child: CircularProgressIndicator());
                  //     }
                  //     if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  //       return Center(child: Text('No posts yet.'));
                  //     }

                  //     List<Post> posts = snapshot.data!;
                  //     print('Posts retrieved: ${posts.length}'); // Log the number of posts

                  //     return ListView.builder(
                  //       itemCount: posts.length,
                  //       itemBuilder: (context, index) {
                  //         return PostWidget(post: posts[index]);
                  //       },
                  //     );
                  //   },
                  // ),
                  child: ListView.builder(
                    itemCount: filteredPosts().length,
                    itemBuilder: (context, index) {
                      return PostWidget(post: filteredPosts()[index]);
                    },
                  ),
                ),
              ],
            ),
            NewsPage(), // News page
            EventsPage(), // Events page
          ],
        ),
        floatingActionButton: _currentIndex == 0 // Only show FAB on Posts tab
            ? FloatingActionButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreatePostPage(),
                    ),
                  );
                  if (result != null) {
                    final newPost = {
                      'username': 'Guest123', // Placeholder username
                      'message': result['message'],
                      'imageUrl': result['imageUrl'],
                      'time': FieldValue.serverTimestamp(),
                      'label': result['label'],
                      'likes': 0,
                    };
                    await FirestoreService.addPost(newPost);
                  }
                },
                child: Icon(Icons.add),
                backgroundColor: Colors.brown,
              )
            : null, // Hide FAB on other tabs
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const FilterButton({
    Key? key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        decoration: BoxDecoration(
          color: isSelected ? Colors.brown : Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.brown),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.brown,
          ),
        ),
      ),
    );
  }
}