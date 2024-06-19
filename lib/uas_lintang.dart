import 'package:flutter/material.dart';

void main() {
  runApp(PrimeNumberApp());
}

class PrimeNumberApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Prime Number Finder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PrimeNumberHomePage(),
    );
  }
}

class PrimeNumberHomePage extends StatefulWidget {
  @override
  _PrimeNumberHomePageState createState() => _PrimeNumberHomePageState();
}

class _PrimeNumberHomePageState extends State<PrimeNumberHomePage> {
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _endController = TextEditingController();
  List<int> _primeNumbers = [];

  void _findPrimeNumbers() {
    final int startNumber = int.tryParse(_startController.text) ?? 0;
    final int endNumber = int.tryParse(_endController.text) ?? 0;

    if (startNumber > endNumber) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Start Number harus lebih kecil dari End Number')),
      );
      return;
    }

    List<int> primes = [];
    for (int i = startNumber; i <= endNumber; i++) {
      if (_isPrime(i)) {
        primes.add(i);
      }
    }

    setState(() {
      _primeNumbers = primes;
    });
  }

  bool _isPrime(int number) {
    if (number <= 1) return false;
    for (int i = 2; i <= number ~/ 2; i++) {
      if (number % i == 0) return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Identifikasi Bilangan Prima'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _startController,
              decoration: InputDecoration(labelText: 'Start Number'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _endController,
              decoration: InputDecoration(labelText: 'End Number'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _findPrimeNumbers,
              child: Text('Submit'),
            ),
            SizedBox(height: 20),
            _primeNumbers.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: _primeNumbers.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text('${_primeNumbers[index]}'),
                        );
                      },
                    ),
                  )
                : Text('Tidak ditemukan bilangan prima diantara start number dan end number'),
          ],
        ),
      ),
    );
  }
}
