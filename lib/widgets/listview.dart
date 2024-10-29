import 'package:flutter/material.dart';

class ShoesListView extends StatefulWidget {
  const ShoesListView({Key? key}) : super(key: key);

  @override
  _ShoesListViewState createState() => _ShoesListViewState();
}

class _ShoesListViewState extends State<ShoesListView> {
  final List<Map<String, String>> shoes = [
    {'image': 'images/nike_hitam.png', 'name': 'Nike Asli Ngawi', 'description': 'Price: \$400'},
    {'image': 'images/nike_merah.png', 'name': 'Nike Red', 'description': 'Price: \$350'},
    {'image': 'images/jordan.png', 'name': 'Nike Air Jordan Red', 'description': 'Price: \$250'},
    {'image': 'images/jordan2.png', 'name': 'Nike Air Jordan Blue Light', 'description': 'Price: \$300'},
    {'image': 'images/jordan3.png', 'name': 'Nike Air Jordan Green', 'description': 'Price: \$275'},
    {'image': 'images/puma.png', 'name': 'Puma Gel-Lyte', 'description': 'Price: \$320'},
  ];

  // Track liked status for each item
  final List<bool> likedStatus = List.filled(6, false);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "Recommended for You",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(), // Prevents inner scrolling
          itemCount: shoes.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 4,
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      height: 180, // Fixed height for uniformity
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 140, // Set a fixed width
                            height: 140, // Set a fixed height
                            color: const Color.fromARGB(58, 224, 224, 224), // Gray background
                            child: Image.asset(
                              shoes[index]['image']!,
                              width: 140,
                              height: 140,
                              fit: BoxFit.contain, // Ensure the image fits without cropping
                            ),
                          ),
                          const SizedBox(width: 16), // Space between image and text
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  shoes[index]['name']!,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8), // Space between title and description
                                Text(
                                  shoes[index]['description']!,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: IconButton(
                        icon: Icon(
                          likedStatus[index] ? Icons.favorite : Icons.favorite_border,
                          color: likedStatus[index] ? Colors.red : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            likedStatus[index] = !likedStatus[index];
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
