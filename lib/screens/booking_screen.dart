import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../services/auth_service.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  List<Map<String, String>> _bookings = [];

  @override
  void initState() {
    super.initState();
    _loadBookings();
  }

  // Fungsi untuk memuat data booking dari SharedPreferences berdasarkan email pengguna yang sedang login
  Future<void> _loadBookings() async {
    final email = await AuthService().getLoggedInUserEmail();
    if (email != null) {
      final bookings = await AuthService().getUserBookings(email);
      setState(() {
        _bookings = bookings;
      });
    }
  }

  // Fungsi untuk menghapus booking dari daftar dan memperbarui SharedPreferences
  Future<void> _deleteBooking(int index) async {
    final email = await AuthService().getLoggedInUserEmail();
    if (email != null) {
      final prefs = await SharedPreferences.getInstance();
      final userKey = 'user_$email';

      // Ambil data pengguna dari SharedPreferences
      final userData = jsonDecode(prefs.getString(userKey)!);
      List<Map<String, String>> userBookings = List<Map<String, String>>.from(
        (userData['bookings'] as List).map(
          (booking) => Map<String, String>.from(booking as Map),
        ),
      );

      // Hapus booking yang dipilih
      userBookings.removeAt(index);
      userData['bookings'] = userBookings;

      // Simpan perubahan kembali ke SharedPreferences
      await prefs.setString(userKey, jsonEncode(userData));
      
      // Refresh UI
      setState(() {
        _bookings = userBookings;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookings'),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: _bookings.length,
          itemBuilder: (context, index) {
            final booking = _bookings[index];
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300, width: 1),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Type: ${booking['type']}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text('Shoe Type: ${booking['shoeType']}'),
                        Text('Size: ${booking['shoeSize']}'),
                        Text('Color: ${booking['shoeColor']}'),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.remove_circle, color: Colors.red),
                    onPressed: () async {
                      await _deleteBooking(index);
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
