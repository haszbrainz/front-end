// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';
// import '../services/auth_service.dart';
// import 'booking_screen.dart';

// class CleanScreen extends StatefulWidget {
//   final Function(int) onNavItemSelected;

//   const CleanScreen({super.key, required this.onNavItemSelected});

//   @override
//   _CleanScreenState createState() => _CleanScreenState();
// }

// class _CleanScreenState extends State<CleanScreen> {
//   String? _selectedCleaningType;
//   final List<Map<String, String>> _cleaningOptions = [
//     {
//       'type': 'Regular Wash',
//       'price': '\$10',
//       'description': 'Light wash to remove dust and surface dirt.',
//       'image': 'images/biasa.gif',
//     },
//     {
//       'type': 'Deep Clean',
//       'price': '\$20',
//       'description': 'Thorough cleaning for shoes with heavy stains and dirt.',
//       'image': 'images/deepclean.gif',
//     },
//   ];

//   final TextEditingController _shoeTypeController = TextEditingController();
//   final TextEditingController _shoeSizeController = TextEditingController();
//   final TextEditingController _shoeColorController = TextEditingController();

//   // Fungsi untuk menampilkan dialog input
//   void _showBookingDialog() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Booking Details'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextFormField(
//                 controller: _shoeTypeController,
//                 decoration: const InputDecoration(
//                   labelText: 'Shoe Type (e.g., Leather, Canvas)',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 8),
//               TextFormField(
//                 controller: _shoeSizeController,
//                 decoration: const InputDecoration(
//                   labelText: 'Shoe Size',
//                   border: OutlineInputBorder(),
//                 ),
//                 keyboardType: TextInputType.number,
//               ),
//               const SizedBox(height: 8),
//               TextFormField(
//                 controller: _shoeColorController,
//                 decoration: const InputDecoration(
//                   labelText: 'Shoe Color',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context); // Close dialog
//               },
//               child: const Text('Cancel'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 _confirmBooking();
//                 Navigator.pop(context); // Close dialog after confirm
//               },
//               child: const Text('Confirm'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   // Fungsi untuk memproses konfirmasi booking
//   void _confirmBooking() async {
//     if (_selectedCleaningType != null) {
//       final email = await AuthService().getLoggedInUserEmail();
//       if (email != null) {
//         await _saveBooking(email);
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Booking confirmed!')),
//         );
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Please select a cleaning type first.'),
//         ),
//       );
//     }
//   }

//   Future<void> _saveBooking(String email) async {
//     final prefs = await SharedPreferences.getInstance();
//     final userKey = 'user_$email';

//     // Prepare booking data and handle nullability with empty strings
//     final bookingData = {
//       'type': _selectedCleaningType ?? '',
//       'shoeType': _shoeTypeController.text,
//       'shoeSize': _shoeSizeController.text,
//       'shoeColor': _shoeColorController.text,
//     };

//     // Retrieve existing user data
//     final userData = jsonDecode(prefs.getString(userKey)!);
//     final userBookings = List<Map<String, String>>.from((userData['bookings'] as List)
//         .map((booking) => Map<String, String>.from(booking as Map)));

//     // Add the new booking data
//     userBookings.add(Map<String, String>.from(bookingData));

//     // Update the user data with the new booking
//     userData['bookings'] = userBookings;
//     prefs.setString(userKey, jsonEncode(userData));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(0),
//         child: AppBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//         ),
//       ),
//       body: ListView(
//         padding: const EdgeInsets.only(top: 10.0, bottom: 80.0),
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 IconButton(
//                   icon: const Icon(Icons.shopping_bag, color: Colors.black),
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const BookingScreen()),
//                     );
//                   },
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.notifications, color: Colors.black),
//                   onPressed: () {
//                     // Action for notifications if needed
//                   },
//                 ),
//                 const SizedBox(width: 4),
//                 IconButton(
//                   icon: const Icon(Icons.settings, color: Colors.black),
//                   onPressed: () {
//                     widget.onNavItemSelected(3);
//                   },
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'Choose Cleaning Type:',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     fontFamily: 'Visby',
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 ListView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemCount: _cleaningOptions.length,
//                   itemBuilder: (context, index) {
//                     final option = _cleaningOptions[index];
//                     return GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           _selectedCleaningType = option['type'];
//                         });
//                       },
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: _selectedCleaningType == option['type']
//                               ? Colors.black
//                               : Colors.white,
//                           borderRadius: BorderRadius.circular(8),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(0.2),
//                               spreadRadius: 2,
//                               blurRadius: 5,
//                               offset: const Offset(0, 3),
//                             ),
//                           ],
//                         ),
//                         margin: const EdgeInsets.symmetric(vertical: 8),
//                         child: Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Expanded(
//                                 child: Image.asset(
//                                   option['image']!,
//                                   width: 100,
//                                   height: 100,
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                               const SizedBox(width: 10),
//                               Expanded(
//                                 flex: 2,
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       option['type']!,
//                                       style: TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.bold,
//                                         fontFamily: 'Visby',
//                                         color: _selectedCleaningType == option['type']
//                                             ? Colors.white
//                                             : Colors.black,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 4),
//                                     Text(
//                                       option['price']!,
//                                       style: TextStyle(
//                                         fontSize: 14,
//                                         fontFamily: 'Visby',
//                                         color: _selectedCleaningType == option['type']
//                                             ? Colors.white70
//                                             : Colors.grey,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 4),
//                                     Text(
//                                       option['description']!,
//                                       style: TextStyle(
//                                         fontSize: 12,
//                                         fontFamily: 'Visby',
//                                         color: _selectedCleaningType == option['type']
//                                             ? Colors.white70
//                                             : Colors.black54,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//                 const SizedBox(height: 20),
//                 Center(
//                   child: ElevatedButton(
//                     onPressed: _selectedCleaningType == null
//                         ? null
//                         : _showBookingDialog, // Show dialog first
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 16, horizontal: 32),
//                       backgroundColor: Colors.black,
//                     ),
//                     child: const Text(
//                       'Confirm Booking',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontFamily: 'Visby',
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
