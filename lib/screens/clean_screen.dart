import 'package:flutter/material.dart';

class CleanScreen extends StatefulWidget {
  final Function(int) onNavItemSelected;

  const CleanScreen({super.key, required this.onNavItemSelected});

  @override
  _CleanScreenState createState() => _CleanScreenState();
}

class _CleanScreenState extends State<CleanScreen> {
  String? _selectedCleaningType;
  final List<Map<String, String>> _cleaningOptions = [
    {
      'type': 'Regular Wash',
      'price': '\$10',
      'description': 'Light wash to remove dust and surface dirt.',
      'image': 'images/biasa.gif', // Replace with the correct image path
    },
    {
      'type': 'Deep Clean',
      'price': '\$20',
      'description': 'Thorough cleaning for shoes with heavy stains and dirt.',
      'image': 'images/deepclean.gif', // Replace with the correct image path
    },
  ];

  void _confirmBooking() {
    if (_selectedCleaningType != null) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Booking Confirmation'),
            content: Text('Are you sure you want to select $_selectedCleaningType?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('You have selected $_selectedCleaningType.'),
                    ),
                  );
                },
                child: const Text('Confirm'),
              ),
            ],
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a cleaning type first.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0), // Hide the app bar
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      body: ListView(
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
                    // Action for notifications if needed
                  },
                ),
                const SizedBox(width: 4),
                IconButton(
                  icon: const Icon(Icons.settings, color: Colors.black),
                  onPressed: () {
                    widget.onNavItemSelected(3); // Navigasi ke halaman profil via navbar
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Choose Cleaning Type:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Visby',
                  ),
                ),
                const SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _cleaningOptions.length,
                  itemBuilder: (context, index) {
                    final option = _cleaningOptions[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedCleaningType = option['type'];
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: _selectedCleaningType == option['type'] ? Colors.black : Colors.white,
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
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Image.asset(
                                  option['image']!,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      option['type']!,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Visby',
                                        color: _selectedCleaningType == option['type'] ? Colors.white : Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      option['price']!,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Visby',
                                        color: _selectedCleaningType == option['type'] ? Colors.white70 : Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      option['description']!,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'Visby',
                                        color: _selectedCleaningType == option['type'] ? Colors.white70 : Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _confirmBooking,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                      backgroundColor: Colors.black,
                    ),
                    child: const Text(
                      'Confirm Booking',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Visby',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
