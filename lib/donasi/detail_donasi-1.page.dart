import 'package:flutter/material.dart';
import 'metode_pembayaran.dart';
import 'pembayaran_berhasil.dart';
import 'donasi_page.dart';
// import 'metode_pembayaran_page.dart';
// import 'pembayaran_berhasil_page.dart';

class InputNominalPage extends StatefulWidget {
  final Donasi donasi;
  final String? selectedPaymentMethod;

  InputNominalPage({required this.donasi, this.selectedPaymentMethod});

  @override
  _InputNominalPageState createState() => _InputNominalPageState();
}

class _InputNominalPageState extends State<InputNominalPage> {
  final TextEditingController _nominalController = TextEditingController(text: '200000');
  String? _selectedPaymentMethod;

  @override
  void initState() {
    super.initState();
    _selectedPaymentMethod = widget.selectedPaymentMethod;
  }

  void _setNominal(String value) {
    setState(() {
      _nominalController.text = value;
    });
  }

  void _navigateToMetodePembayaranPage() async {
    final selectedMethod = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MetodePembayaranPage(
          onSelectPaymentMethod: (method) {
            setState(() {
              _selectedPaymentMethod = method;
            });
          },
        ),
      ),
    );

    if (selectedMethod != null) {
      setState(() {
        _selectedPaymentMethod = selectedMethod;
      });
    }
  }

  void _handlePembayaranBerhasil() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PembayaranBerhasilPage(
          nominal: _nominalController.text,
          metodePembayaran: _selectedPaymentMethod!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Donasi'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(widget.donasi.imageUrl, height: 200, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Masukkan Nominal Donasi', style: TextStyle(fontSize: 18)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _nominalController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      prefixText: 'Rp ',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    children: [
                      _nominalButton('10000'),
                      _nominalButton('50000'),
                      _nominalButton('100000'),
                      _nominalButton('150000'),
                      _nominalButton('200000'),
                      _nominalButton('250000'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _navigateToMetodePembayaranPage,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _selectedPaymentMethod ?? 'Pilih Metode Pembayaran',
                          style: TextStyle(
                            color: _selectedPaymentMethod != null ? Colors.black : Colors.grey,
                          ),
                        ),
                        const Icon(Icons.arrow_forward),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50), // Sesuaikan ukuran tombol
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            if (_selectedPaymentMethod != null) {
              _handlePembayaranBerhasil();
            } else {
              // Tampilkan pesan untuk memilih metode pembayaran
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Silakan pilih metode pembayaran terlebih dahulu'),
                ),
              );
            }
          },
          child: Text(_selectedPaymentMethod != null ? 'Selesaikan Pembayaran' : 'Lanjut Pembayaran'),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50), // Sesuaikan ukuran tombol
          ),
        ),
      ),
    );
  }

  Widget _nominalButton(String amount) {
    return ElevatedButton(
      onPressed: () => _setNominal(amount),
      child: Text('Rp $amount'),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black, backgroundColor: Colors.grey[200],
      ),
    );
  }
}
