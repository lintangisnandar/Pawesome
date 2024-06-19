import 'package:flutter/material.dart';
import 'donasi_page.dart';

class PembayaranBerhasilPage extends StatelessWidget {
  final String nominal;
  final String metodePembayaran;

  PembayaranBerhasilPage({required this.nominal, required this.metodePembayaran});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pembayaran Berhasil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 100),
            SizedBox(height: 16),
            Text('Donasi Berhasil Terkirim', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Text('Nominal: Rp $nominal', style: TextStyle(fontSize: 18)),
            Text('Metode Pembayaran: $metodePembayaran', style: TextStyle(fontSize: 18)),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => DonasiPage()),
                  (Route<dynamic> route) => false,
                );
              },
              child: Text('Tutup'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
