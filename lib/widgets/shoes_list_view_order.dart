import 'package:flutter/material.dart';

class ShoesListViewOrder extends StatefulWidget {
  const ShoesListViewOrder({Key? key}) : super(key: key);

  @override
  _ShoesListViewOrderState createState() => _ShoesListViewOrderState();
}

class _ShoesListViewOrderState extends State<ShoesListViewOrder> {
  final List<Map<String, dynamic>> shoes = [
    {
      'image': 'images/nike_hitam.png',
      'name': 'Nike Asli Ngawi',
      'price': 400,
      'stock': 12,
      'sizes': ['38', '39', '40', '41', '42'],
    },
    {
      'image': 'images/nike_merah.png',
      'name': 'Nike Red',
      'price': 350,
      'stock': 8,
      'sizes': ['37', '38', '39', '41'],
    },
    {
      'image': 'images/jordan.png',
      'name': 'Nike Air Jordan Red',
      'price': 250,
      'stock': 5,
      'sizes': ['39', '40', '42'],
    },
    {
      'image': 'images/jordan2.png',
      'name': 'Nike Air Jordan Blue Light',
      'price': 300,
      'stock': 10,
      'sizes': ['38', '39', '40', '41'],
    },
    {
      'image': 'images/jordan3.png',
      'name': 'Nike Air Jordan Green',
      'price': 275,
      'stock': 6,
      'sizes': ['39', '41', '42'],
    },
    {
      'image': 'images/puma.png',
      'name': 'Puma Gel-Lyte',
      'price': 320,
      'stock': 15,
      'sizes': ['40', '41', '42', '43'],
    },
  ];

  // Function to show the order dialog
  void _showOrderDialog(BuildContext context, Map<String, dynamic> shoe) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text(shoe['name'])), // Center-align title text
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center, // Center-align content
            children: [
              Center(
                child: Container(
                  width: 150, // Fixed width for consistency
                  height: 150, // Fixed height for consistency
                  decoration: BoxDecoration(
                    color: Colors.grey[300]!.withOpacity(0.2), // Filled background color
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.asset(
                    shoe['image'],
                    fit: BoxFit.contain, // Preserve aspect ratio within fixed size
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text("Price: \$${shoe['price']}"),
              Text("Stock: ${shoe['stock']}"),
              const SizedBox(height: 10),
              Text("Available Sizes:"),
              Wrap(
                spacing: 8.0,
                children: shoe['sizes'].map<Widget>((size) {
                  return Chip(label: Text(size));
                }).toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Add further order processing if needed
              },
              child: const Text('Order Now'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: shoes.map((shoe) {
        return GestureDetector(
          onTap: () => _showOrderDialog(context, shoe),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              height: 150,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    color: const Color.fromARGB(58, 224, 224, 224),
                    child: Image.asset(
                      shoe['image'],
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          shoe['name'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Price: \$${shoe['price']}",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
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
      }).toList(),
    );
  }
}
