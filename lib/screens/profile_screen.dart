import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'edit_profile_screen.dart';
import '../services/auth_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _username = "";
  String _email = "";
  String _phone = "";
  String _address = "";

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final email = await AuthService().getLoggedInUserEmail();
    if (email != null) {
      final userKey = 'user_${email}';
      setState(() {
        _username = prefs.getString('${userKey}_name') ?? "Unknown User";
        _email = email;
        _phone = prefs.getString('${userKey}_phone') ?? "Phone and address not set";
        _address = prefs.getString('${userKey}_address') ?? "Update in Manage Account.";
      });
    }
  }

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('images/mas_iyan.png'),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                _username,
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Visby',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                _email,
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Visby',
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                _phone,
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Visby',
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                _address,
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Visby',
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            const SizedBox(height: 16),
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
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EditProfileScreen()),
                );
                _loadUserData(); // Refresh data after returning from edit screen
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
