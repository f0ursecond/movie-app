// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:movie_app/constant/color_constant.dart';
import 'package:movie_app/core/home/screens/home_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int selectedIndex = 0;

  List<Widget> screenList = [
    HomeScreen(),
    Center(child: Text('Play')),
    Center(child: Text('Profile')),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screenList.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.kPrimaryColor,
        unselectedItemColor: Colors.grey.shade300,
        selectedItemColor: Colors.white,
        selectedLabelStyle: const TextStyle(color: Colors.white),
        unselectedLabelStyle: TextStyle(color: Colors.grey.shade300),
        onTap: onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.play_arrow_rounded), label: 'Watch'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
