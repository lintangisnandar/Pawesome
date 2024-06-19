import 'package:flutter/material.dart';
// import 'package:myapp/Profile/main_profile.dart';
// import 'package:myapp/adopsi/main_ado.dart';
// import 'package:myapp/home/home_posts.dart';
import 'janji temu/janji_temu_page.dart';
import 'utils/colors.dart';

import 'Profile/main_profile.dart';
import 'adopsi/main_ado.dart';
import 'donasi/donasi_page.dart';
import 'home/home_posts.dart';
// import 'janji temu/buat_janji_temu_page.dart';

class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key : key);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _currentIndex = 0;
  List<Widget> body = [
    AddPostPage(),
    MainAdo(),
    DonasiPage(),
    JanjiTemuPage(),
    MainProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: body[_currentIndex],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 1), 
            ),
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (int newIndex) {
              setState(() {
                _currentIndex = newIndex;
              });
            },
            selectedItemColor: AppColors.brown1Color,
            unselectedItemColor: AppColors.pink2Color,
            items: const [
              BottomNavigationBarItem(
                label: 'Home',
                icon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                label: 'Adoption',
                icon: Icon(Icons.pets),
              ),
              BottomNavigationBarItem(
                label: 'Donation',
                icon: Icon(Icons.currency_exchange_outlined),
              ),
              BottomNavigationBarItem(
                label: 'Janji Temu',
                icon: Icon(Icons.calendar_today),
              ),
              BottomNavigationBarItem(
                label: 'Profile',
                icon: Icon(Icons.person_outline),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
