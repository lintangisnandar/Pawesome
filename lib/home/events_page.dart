import 'package:flutter/material.dart';

class EventsPage extends StatelessWidget {
  final List<Map<String, String>> dummyEvents = [
    {
      'title': 'Dog Days of Summer',
      'description': 'Collecting donations of dog food',
      'date': '21 August 2024',
      'time': '18.00 WIB',
      'location': 'Semarang',
      'imageUrl': 'https://via.placeholder.com/150',
    },
    {
      'title': 'Pet Show',
      'description': 'Sharing education and entertainment for all pets',
      'date': '21 August 2024',
      'time': '18.00 WIB',
      'location': 'Semarang',
      'imageUrl': 'https://via.placeholder.com/150',
    },
    {
      'title': 'Dog Movie Night',
      'description': 'Watch your favorite movie with your lovely dog',
      'date': '21 August 2024',
      'time': '18.00 WIB',
      'location': 'Semarang',
      'imageUrl': 'https://via.placeholder.com/150',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {}, // Placeholder for future functionality
        child: Icon(Icons.add),
        backgroundColor: Colors.orange.shade300,
      ),
      body: ListView.builder(
        itemCount: dummyEvents.length,
        itemBuilder: (context, index) {
          final event = dummyEvents[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (event['imageUrl'] != null)
                  Image.network(
                    event['imageUrl']!,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    event['title']!,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(event['description']!),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16),
                      SizedBox(width: 4),
                      Text(event['date']!),
                      SizedBox(width: 16),
                      Icon(Icons.access_time, size: 16),
                      SizedBox(width: 4),
                      Text(event['time']!),
                      SizedBox(width: 16),
                      Icon(Icons.location_on, size: 16),
                      SizedBox(width: 4),
                      Text(event['location']!),
                    ],
                  ),
                ),
                SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('MORE INFO'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange.shade300,
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
              ],
            ),
          );
        },
      ),
    );
  }
}
