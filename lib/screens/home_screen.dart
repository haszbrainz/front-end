import 'package:flutter/material.dart';
import 'package:responsi_wpk/screens/login_screen.dart';  // Mengimpor LoginScreen
import 'package:responsi_wpk/screens/resgistration_screen.dart';  // Mengimpor RegistrationScreen

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Menjaga state untuk memilih menu

  // Fungsi untuk menampilkan halaman login atau registrasi
  Widget _getPage(int index) {
    switch (index) {
      case 0:  // Menampilkan halaman login saat index 0
        return const LoginScreen();
      case 1:  // Menampilkan halaman registrasi saat index 1
        return const RegistrationScreen();
      default:
        return const LoginScreen(); // Default menampilkan halaman login
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(10.0),
        child: AppBar(
          title: const Text(''),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      body: _getPage(_selectedIndex), // Menampilkan halaman berdasarkan index
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index; // Mengubah index saat tombol dipilih
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.login),
            label: 'Login',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.app_registration),
            label: 'Register',
          ),
        ],
      ),
    );
  }
}
