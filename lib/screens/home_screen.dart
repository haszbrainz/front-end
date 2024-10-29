import 'package:flutter/material.dart';
import 'package:responsi_wpk/screens/shoes_screen.dart';
import 'package:responsi_wpk/screens/clean_screen.dart';
import 'package:responsi_wpk/screens/profile_screen.dart';
import 'package:responsi_wpk/widgets/bottom_navigation_bar.dart';
import 'package:responsi_wpk/widgets/grid_item.dart'; // Import widget GridItem
import 'package:responsi_wpk/widgets/listview.dart'; // Import the new ListView widget

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Map<String, String>> items = [
    {'image': 'images/ungu.gif', 'text': 'Fire October Special 40% discount'},
    {'image': 'images/adidas_bluesky.png', 'text': 'Adidas BlueSky'},
    {'image': 'images/adidas_pildun.png', 'text': 'Adidas GreenNeo'},
    {'image': 'images/adidas_copa.png', 'text': 'Adidas Blood'},
  ];

  final List<double> fontSizes = [18.0, 18.0, 18.0, 18.0];
  final List<double> imageSizes = [140.0, 140.0, 140.0, 140.0];
  final List<Color> borderColors = [
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey,
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
      body: _getPage(_selectedIndex), // Menampilkan halaman sesuai dengan index
      bottomNavigationBar: BottomNavigationBarWidget(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 1:
        return ShoesScreen(onNavItemSelected: _onItemTapped); 
      case 2:
        return CleanScreen(onNavItemSelected: _onItemTapped);
      case 3:
        return const ProfileScreen();
      default:
        return _buildHomeContent(); // Menampilkan konten utama secara default
    }
  }

  Widget _buildHomeContent() {
    return ListView(
      padding: const EdgeInsets.only(top: 10.0, bottom: 80.0),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.notifications, color: Colors.black),
                onPressed: () {
                  // Tambahkan aksi untuk ikon lonceng jika diperlukan
                },
              ),
              const SizedBox(width: 4), // Jarak antara ikon lonceng dan pengaturan
              IconButton(
                icon: const Icon(Icons.settings, color: Colors.black),
                onPressed: () {
                  // Ubah indeks navbar ke profil, bukan navigasi halaman baru
                  setState(() {
                    _selectedIndex = 3; // Mengatur navbar ke halaman profil
                  });
                },
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GridItem(
              items: items,
              fontSizes: fontSizes,
              imageSizes: imageSizes,
              borderColors: borderColors,
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Image.asset(
                'images/adidas_iklan.png',
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),
            const ShoesListView(), // Add ShoesListView widget here
          ],
        ),
      ],
    );
  }
}
