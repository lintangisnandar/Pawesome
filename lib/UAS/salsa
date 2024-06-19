import 'package:flutter/material.dart';

class LeapYearScreen extends StatefulWidget {
  @override
  _LeapYearScreenState createState() => _LeapYearScreenState();
}

class _LeapYearScreenState extends State<LeapYearScreen> {
  final TextEditingController _startYearController = TextEditingController();
  final TextEditingController _endYearController = TextEditingController();
  List<int> _leapYears = [];

  bool isLeapYear(int year) {
    if (year % 4 == 0) {
      if (year % 100 == 0) {
        if (year % 400 == 0) {
          return true;
        } else {
          return false;
        }
      } else {
        return true;
      }
    } else {
      return false;
    }
  }

  void findLeapYears() {
    final int startYear = int.tryParse(_startYearController.text) ?? 0;
    final int endYear = int.tryParse(_endYearController.text) ?? 0;
    if (startYear > 0 && endYear > 0 && startYear <= endYear) {
      List<int> leapYears = [];
      for (int year = startYear; year <= endYear; year++) {
        if (isLeapYear(year)) {
          leapYears.add(year);
        }
      }
      setState(() {
        _leapYears = leapYears;
      });
    } else {
      setState(() {
        _leapYears = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leap Year Finder'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _startYearController,
              decoration: InputDecoration(
                labelText: 'Start Year',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _endYearController,
              decoration: InputDecoration(
                labelText: 'End Year',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: findLeapYears,
              child: Text('Find Leap Years'),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _leapYears.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_leapYears[index].toString()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
