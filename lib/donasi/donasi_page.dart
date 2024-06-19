import 'package:flutter/material.dart';
import 'detail_donasi_page.dart';

class DonasiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: AppBar(
              title: Text('Donasi', style: TextStyle(fontWeight: FontWeight.bold)),
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: donasiList.length,
                itemBuilder: (context, index) {
                  final donasi = donasiList[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailDonasiPage(donasi: donasi),
                        ),
                      );
                    },
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(donasi.imageUrl, height: 100, fit: BoxFit.cover),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(donasi.title, style: TextStyle(fontWeight: FontWeight.bold)),
                                Text(donasi.location),
                                Text('Terkumpul: ${donasi.collectedAmount}'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Donasi {
  final String title;
  final String location;
  final String collectedAmount;
  final String imageUrl;

  Donasi(this.title, this.location, this.collectedAmount, this.imageUrl);
}

final List<Donasi> donasiList = [
  Donasi('Bantu Anak Kucing Kelaparan', 'Semarang', 'Rp24.000.000', 'https://cdn.pixabay.com/photo/2017/02/20/18/03/cat-2083492_1280.jpg'),
  Donasi('Pembangunan Kandang Anjing dan Kucing', 'Tasikmalaya', 'Rp10.000.000', 'https://cdn.pixabay.com/photo/2022/12/31/14/32/cat-7688749_1280.jpg'),
  Donasi('Berbagi Pakan Kucing Terlantar', 'Bandung', 'Rp4.000.000', 'https://cdn.pixabay.com/photo/2018/07/13/10/20/kittens-3535404_1280.jpg'),
  Donasi('Bantu Shelter Merawat Puluhan Anabul', 'Jakarta', 'Rp12.000.000', 'https://cdn.pixabay.com/photo/2020/08/14/13/57/cat-5488070_1280.jpg'),
  Donasi('Bantu Biaya Pengobatan Anabul di Shelter', 'Yogyakarta', 'Rp6.000.000', 'https://cdn.pixabay.com/photo/2021/08/26/01/40/cats-6574788_1280.jpg'),
  Donasi('Donasi Obat dan Makanan untuk Kucing', 'Surabaya', 'Rp8.000.000', 'https://cdn.pixabay.com/photo/2020/02/20/12/12/cat-4864605_960_720.jpg'),
];
