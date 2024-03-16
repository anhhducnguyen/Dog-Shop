
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({Key? key, required this.currentIndex, required this.onTabTapped}) : super(key: key);

  final int currentIndex;
  final Function(int) onTabTapped;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60, 
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTabTapped,
        selectedFontSize: 12,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Iconsax.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.heart),
            label: 'Favourite',
          ),
          
          BottomNavigationBarItem(
            icon: Icon(Ionicons.person_circle_outline,size: 28),
            label: 'Profile',
          ),
        ],
      ),
    );
 
  }
}
