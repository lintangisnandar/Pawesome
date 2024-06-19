import 'package:flutter/material.dart';
import 'post_model.dart'; // Ensure this is the correct import path for your Post model
import 'package:cloud_firestore/cloud_firestore.dart';

class PostWidget extends StatefulWidget {
  final Post post;

  const PostWidget({Key? key, required this.post}) : super(key: key);

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  child: Text(widget.post.username[0]),
                ),
                const SizedBox(width: 8.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.post.username,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4.0),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                      decoration: BoxDecoration(
                        color: widget.post.label == 'Missing' ? Colors.red : (widget.post.label == 'Found' ? Colors.green : Colors.orange),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        widget.post.label,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0, // Smaller font size
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Text(widget.post.time),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(widget.post.message),
            const SizedBox(height: 8.0),
            widget.post.imageUrl.isNotEmpty
                ? Image.network(widget.post.imageUrl)
                : Container(),
            const SizedBox(height: 8.0),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    widget.post.isLiked ? Icons.favorite : Icons.favorite_border,
                    color: widget.post.isLiked ? Colors.red : null,
                  ),
                  onPressed: () {
                    setState(() {
                      if (widget.post.isLiked) {
                        widget.post.likes--;
                      } else {
                        widget.post.likes++;
                      }
                      widget.post.isLiked = !widget.post.isLiked;
                    });
                  },
                ),
                Text(widget.post.likes.toString()),
                IconButton(
                  icon: Icon(Icons.comment),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
