import 'package:flutter/material.dart';
import 'package:responsi_wpk/widgets/grid_shoes.dart'; // Import the GridShoes widget
import 'package:responsi_wpk/widgets/shoes_list_view_order.dart'; // Import the ShoesListViewOrder widget

class ShoesScreen extends StatefulWidget {
  final Function(int) onNavItemSelected;

  const ShoesScreen({super.key, required this.onNavItemSelected});

  @override
  _ShoesScreenState createState() => _ShoesScreenState();
}

class _ShoesScreenState extends State<ShoesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0), // Set height to 0 to hide the app bar
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      body: ListView( // Make the entire screen scrollable
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
                    widget.onNavItemSelected(3); // Navigasi ke halaman profil via navbar
                  },
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'From all famous shoe brands',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Visby',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const GridShoes(), // Display the grid
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'Order Now',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Visby',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const ShoesListViewOrder(), // Display the list view
            ],
          ),
        ],
      ),
    );
  }
}
