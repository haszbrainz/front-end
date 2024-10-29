import 'package:flutter/material.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const BottomNavigationBarWidget({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  _BottomNavigationBarWidgetState createState() => _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      lowerBound: 1.0,
      upperBound: 1.2,
    );
  }

  @override
  void didUpdateWidget(covariant BottomNavigationBarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      _controller.forward().then((_) => _controller.reverse());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black87.withOpacity(0.9),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        items: <BottomNavigationBarItem>[
          _buildNavItem(Icons.home, 'Home', 0),
          _buildNavItem(Icons.shopping_bag, 'Shoes', 1),
          _buildNavItem(Icons.cleaning_services, 'Clean', 2),
          _buildNavItem(Icons.person, 'Profile', 3),
        ],
        currentIndex: widget.selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[400],
        selectedLabelStyle: const TextStyle(fontFamily: 'Visby', fontSize: 12),
        unselectedLabelStyle: const TextStyle(fontFamily: 'Visby', fontSize: 12),
        onTap: widget.onItemTapped,
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: ScaleTransition(
        scale: widget.selectedIndex == index ? _controller : const AlwaysStoppedAnimation(1.0),
        child: Icon(icon),
      ),
      label: label,
    );
  }
}
