import 'package:flutter/material.dart';

class GridShoes extends StatefulWidget {
  const GridShoes({Key? key}) : super(key: key);

  @override
  _GridShoesState createState() => _GridShoesState();
}

class _GridShoesState extends State<GridShoes> {
  final List<String> shoeImages = [
    'images/nike_logo.png',
    'images/adidas_logo.png',
    'images/puma_logo.png',
    'images/mizuno_logo.png',
    'images/reebok_logo.png',
    'images/nb_logo.png',
    'images/converse_logo.png',
    'images/vans_logo.png',
    'images/diadora_logo.png',
  ];

  int? expandedIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(), // Prevent independent scrolling
        shrinkWrap: true, // Adjust GridView to fit content
        itemCount: shoeImages.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 3 columns
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
          childAspectRatio: 1, // Force items to be square
        ),
        itemBuilder: (context, index) {
          final isExpanded = expandedIndex == index;
          return GestureDetector(
            onTap: () {
              setState(() {
                expandedIndex = isExpanded ? null : index;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 2), // Stroke only, no fill
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  width: isExpanded ? 110 : 80, // Larger width when expanded
                  height: isExpanded ? 110 : 80, // Larger height when expanded
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      shoeImages[index],
                      fit: BoxFit.contain, // Ensure the image fits within the container
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
