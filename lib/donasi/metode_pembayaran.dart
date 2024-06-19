import 'package:flutter/material.dart';

class MetodePembayaranPage extends StatefulWidget {
  final Function(String) onSelectPaymentMethod;

  const MetodePembayaranPage({required this.onSelectPaymentMethod, Key? key}) : super(key: key);

  @override
  _MetodePembayaranPageState createState() => _MetodePembayaranPageState();
}

class _MetodePembayaranPageState extends State<MetodePembayaranPage> {
  String? _selectedPaymentMethod;

  void _handleRadioValueChange(String? value) {
    setState(() {
      _selectedPaymentMethod = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Metode Pembayaran'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Pilih Metode Pembayaran', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 16),
            PaymentMethodTile(
              icon: Icons.account_balance,
              text: 'Bank Transfer',
              groupValue: _selectedPaymentMethod,
              onChanged: _handleRadioValueChange,
            ),
            PaymentMethodTile(
              icon: Icons.credit_card,
              text: 'Credit Card',
              groupValue: _selectedPaymentMethod,
              onChanged: _handleRadioValueChange,
            ),
            PaymentMethodTile(
              icon: Icons.account_balance_wallet,
              text: 'GOPAY',
              groupValue: _selectedPaymentMethod,
              onChanged: _handleRadioValueChange,
            ),
            PaymentMethodTile(
              icon: Icons.account_balance_wallet,
              text: 'OVO',
              groupValue: _selectedPaymentMethod,
              onChanged: _handleRadioValueChange,
            ),
            PaymentMethodTile(
              icon: Icons.account_balance_wallet,
              text: 'ShopeePay',
              groupValue: _selectedPaymentMethod,
              onChanged: _handleRadioValueChange,
            ),
            PaymentMethodTile(
              icon: Icons.account_balance_wallet,
              text: 'Dana',
              groupValue: _selectedPaymentMethod,
              onChanged: _handleRadioValueChange,
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                if (_selectedPaymentMethod != null) {
                  widget.onSelectPaymentMethod(_selectedPaymentMethod!);
                  Navigator.pop(context);
                } else {
                  // Tampilkan pesan untuk memilih metode pembayaran
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Silakan pilih metode pembayaran terlebih dahulu'),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Lanjut', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentMethodTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final String? groupValue;
  final ValueChanged<String?> onChanged;

  const PaymentMethodTile({
    required this.icon,
    required this.text,
    required this.groupValue,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(text, style: const TextStyle(fontSize: 16)),
      trailing: Radio<String>(
        value: text,
        groupValue: groupValue,
        onChanged: onChanged,
      ),
      onTap: () => onChanged(text),
    );
  }
}
