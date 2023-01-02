import 'package:flutter/material.dart';
import './screens/home_screen.dart';
import './screens/about.dart';
import './screens/patient_screen.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  static const routeName = '/bottomNavigationBar';
  const BottomNavigationBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const MyHomePage(),
    const PatientScreen(),
    const AboutScreen(),
  ];

  void navigatePage(int pageNum) {
    setState(() {
      _currentIndex = pageNum;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 5,
        currentIndex: _currentIndex,
        onTap: (pageNum) {
          navigatePage(pageNum);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital_sharp),
            label: 'Patient',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'About',
          ),
        ],
      ),
    );
  }
}
