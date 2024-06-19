import 'package:flutter/material.dart';

class NewsPage extends StatelessWidget {
  final List<Map<String, String>> dummyNews = [
    {
      'title': 'Lorem Ipsum Dolor Sit Amet',
      'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam at elit non felis faucibus imperdiet. Nullam placerat velit eros, vel suscipit sem var...',
      'imageUrl': 'https://via.placeholder.com/150',
    },
    {
      'title': 'Lorem Ipsum Dolor Sit Amet',
      'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam at elit non felis faucibus imperdiet. Nullam placerat velit eros, vel suscipit sem var...',
      'imageUrl': 'https://via.placeholder.com/150',
    },
    {
      'title': 'Lorem Ipsum Dolor Sit Amet',
      'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam at elit non felis faucibus imperdiet. Nullam placerat velit eros, vel suscipit sem var...',
      'imageUrl': 'https://via.placeholder.com/150',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dummyNews.length,
      itemBuilder: (context, index) {
        final news = dummyNews[index];
        return Card(
          margin: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (news['imageUrl'] != null)
                Image.network(
                  news['imageUrl']!,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  news['title']!,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(news['description']!),
              ),
              SizedBox(height: 8.0),
            ],
          ),
        );
      },
    );
  }
}
