import 'package:flutter/material.dart';

class GridItem extends StatelessWidget {
  final List<Map<String, String>> items;
  final List<double> fontSizes;
  final List<double> imageSizes;
  final List<Color> borderColors;

  const GridItem({
    Key? key,
    required this.items,
    required this.fontSizes,
    required this.imageSizes,
    required this.borderColors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Trending in October',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Visby',
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 260,
            child: GridView.count(
              scrollDirection: Axis.horizontal,
              crossAxisCount: 1,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.5,
              children: List.generate(items.length, (index) {
                return Container(
                  width: 200, // Set a fixed width for the container
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: borderColors[index],
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center, // Center the content vertically
                      crossAxisAlignment: CrossAxisAlignment.center, // Center the content horizontally
                      children: [
                        Image.asset(
                          items[index]['image']!,
                          width: imageSizes[index],
                          height: imageSizes[index],
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 8), // Space between image and text
                        Flexible(
                          child: Text(
                            items[index]['text']!,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: fontSizes[index],
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Visby',
                            ),
                            textAlign: TextAlign.center, // Center align the text
                            maxLines: 4, // Allow up to 2 lines
                            overflow: TextOverflow.ellipsis, // Add ellipsis if text overflows
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
