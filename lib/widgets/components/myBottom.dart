
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
      height: 60, // Điều chỉnh chiều cao của Bottom Navigation ở đây
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTabTapped,
        selectedFontSize: 12, // Đặt kích thước của nhãn khi được chọn
        items: const [
          BottomNavigationBarItem(
            // icon: Icon(Ionicons.home_outline),
            // icon: Icon(Ionicons.home_outline),
            icon: Icon(Iconsax.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            // icon: Icon(Ionicons.heart_outline),
            icon: Icon(Iconsax.heart),
            label: 'Favourite',
          ),
          
          BottomNavigationBarItem(
            // icon: Icon(Ionicons.person_outline),
            // icon: Icon(Iconsax.user),
            // icon: Icon(Iconsax.user),
            icon: Icon(Ionicons.person_circle_outline,size: 28),
            label: 'Profile',
          ),
        ],
      ),
    );
 
  }
}
