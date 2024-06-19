import 'package:flutter/material.dart';
import 'detail_donasi-1.page.dart';
// import 'input_nominal_page.dart';
import 'donasi_page.dart';

class DetailDonasiPage extends StatelessWidget {
  final Donasi donasi;

  DetailDonasiPage({required this.donasi});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Donasi'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(donasi.imageUrl, height: 200, fit: BoxFit.cover),
              const SizedBox(height: 16),
              Text(donasi.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
              const SizedBox(height: 8),
              Text(donasi.location),
              const SizedBox(height: 8),
              Text('Terkumpul: ${donasi.collectedAmount}'),
              const SizedBox(height: 4),
              const Text('29 hari lagi', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 16),
              Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: NetworkImage('https://via.placeholder.com/150'), // Replace with actual avatar URL
                    radius: 20,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Shelter Kamboja', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('Akun Terverifikasi', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text('Lorem ipsum dolor sit amet consectetur. Ultricies ut augue amet vel hac. Ut orci adipiscing fusce lacus lectus rhoncus.'),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InputNominalPage(donasi: donasi),
              ),
            );
          },
          child: const Text('Donasi Sekarang'),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50), // Sesuaikan ukuran tombol
          ),
        ),
      ),
    );
  }
}
