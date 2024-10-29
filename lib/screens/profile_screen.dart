import 'package:flutter/material.dart';
import 'edit_profile_screen.dart'; // Import the EditProfileScreen

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Profile',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Visby',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align to the start for a clean layout
          children: [
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('images/mas_iyan.png'),
              ),
            ),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                'Haszbrainz',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Visby',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                'hasbi@gmail.com',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Visby',
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                'Yogyakarta',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Visby',
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            const SizedBox(height: 16), // Space before account settings section
            const Text(
              'Account Settings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Visby',
              ),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EditProfileScreen()),
                );
              },
              child: _buildSettingOption('Manage Account'),
            ),
            const SizedBox(height: 8),
            _buildSettingOption('Notifications'),
            const SizedBox(height: 8),
            _buildSettingOption('Privacy Policy'),
            const SizedBox(height: 8),
            _buildSettingOption('Terms of Service'),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.logout, color: Colors.red),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: const Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Visby',
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingOption(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Visby',
            ),
          ),
          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}
