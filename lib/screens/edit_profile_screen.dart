// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../services/auth_service.dart';

// class EditProfileScreen extends StatefulWidget {
//   const EditProfileScreen({super.key});

//   @override
//   State<EditProfileScreen> createState() => _EditProfileScreenState();
// }

// class _EditProfileScreenState extends State<EditProfileScreen> {
//   final _formKey = GlobalKey<FormState>();

//   // Controllers to capture user input
//   final nameController = TextEditingController();
//   final emailController = TextEditingController();
//   final phoneController = TextEditingController();
//   final addressController = TextEditingController();
//   String selectedCountryCode = '+62'; // Default country code

//   // Daftar kode negara
//   final List<String> countryCodes = ['+62', '+1', '+44', '+91', '+81'];

//   @override
//   void initState() {
//     super.initState();
//     _loadUserProfile();
//   }

//   // Load existing user data into the text fields
//   Future<void> _loadUserProfile() async {
//     final prefs = await SharedPreferences.getInstance();
//     final email = await AuthService().getLoggedInUserEmail();
//     if (email != null) {
//       final userKey = 'user_$email';
//       setState(() {
//         nameController.text = prefs.getString('${userKey}_name') ?? '';
//         emailController.text = prefs.getString('${userKey}_email') ?? '';
//         phoneController.text = prefs.getString('${userKey}_phone') ?? '';
//         addressController.text = prefs.getString('${userKey}_address') ?? '';
//       });
//     }
//   }

//   // Save updated user profile data to SharedPreferences
//   Future<void> _saveUserProfile() async {
//     final prefs = await SharedPreferences.getInstance();
//     final email = await AuthService().getLoggedInUserEmail();
//     if (email != null) {
//       final userKey = 'user_$email';
//       await prefs.setString('${userKey}_name', nameController.text);
//       await prefs.setString('${userKey}_email', emailController.text);
//       await prefs.setString('${userKey}_phone', '$selectedCountryCode ${phoneController.text}');
//       await prefs.setString('${userKey}_address', addressController.text);
//     }
//   }

//   void _showConfirmationDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Image.asset(
//                 'images/akun.gif', // Ensure this image is added to your assets folder
//                 height: 100,
//               ),
//               const SizedBox(height: 16),
//               const Text(
//                 'Profile details have been updated!',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontFamily: 'Visby',
//                   fontWeight: FontWeight.bold,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ],
//           ),
//           actions: [
//             Center(
//               child: ElevatedButton(
//                 onPressed: () {
//                   Navigator.pop(context); // Close the dialog
//                   Navigator.pop(context); // Navigate back to the ProfileScreen
//                 },
//                 child: const Text(
//                   'OK',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontFamily: 'Visby',
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Edit Profile',
//           style: TextStyle(
//             fontSize: 20,
//             fontFamily: 'Visby',
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         iconTheme: const IconThemeData(color: Colors.black),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               const Text(
//                 'Edit your details',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontFamily: 'Visby',
//                 ),
//               ),
//               const SizedBox(height: 20),
//               TextFormField(
//                 controller: nameController,
//                 decoration: const InputDecoration(
//                   labelText: 'Name',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your name';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 12),
//               TextFormField(
//                 controller: emailController,
//                 decoration: const InputDecoration(
//                   labelText: 'Email',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your email';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 12),
//               Row(
//                 children: [
//                   Expanded(
//                     flex: 2,
//                     child: DropdownButtonFormField(
//                       value: selectedCountryCode,
//                       items: countryCodes.map((code) {
//                         return DropdownMenuItem(
//                           value: code,
//                           child: Text(code),
//                         );
//                       }).toList(),
//                       decoration: const InputDecoration(
//                         labelText: 'Country Code',
//                         border: OutlineInputBorder(),
//                       ),
//                       onChanged: (value) {
//                         setState(() {
//                           selectedCountryCode = value as String;
//                         });
//                       },
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   Expanded(
//                     flex: 4,
//                     child: TextFormField(
//                       controller: phoneController,
//                       decoration: const InputDecoration(
//                         labelText: 'Phone Number',
//                         border: OutlineInputBorder(),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your phone number';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 12),
//               TextFormField(
//                 controller: addressController,
//                 decoration: const InputDecoration(
//                   labelText: 'Address',
//                   prefixIcon: Icon(Icons.location_on), // Icon GPS
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your address';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 20),
//               Center(
//                 child: ElevatedButton(
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       _saveUserProfile(); // Save user profile to SharedPreferences
//                       _showConfirmationDialog(context); // Show confirmation dialog
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.black,
//                   ),
//                   child: const Text(
//                     'Save',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontFamily: 'Visby',
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
