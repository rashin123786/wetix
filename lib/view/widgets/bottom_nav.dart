import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:wetix/view/Booking/booking_screen.dart';
import 'package:wetix/view/Explore/explore_screen.dart';
import 'package:wetix/view/Home/home_screen.dart';
import 'package:wetix/view/Profile/profile_screen.dart';
import 'package:wetix/view/cart/cart_screen.dart';

import '../../controller/provider/bottom_control.dart';

class BottomNavWidget extends StatelessWidget {
  BottomNavWidget({super.key});
  final int _currentSelectedIndex = 0;

  final pages = [
    const HomeScreen(),
    const ExploreScreen(),
    const CartScreen(),
    const BookingScreen(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Consumer<BottomNavControll>(
        builder: (context, value, child) {
          return PageView(
            children: [
              pages[value.currentSelectedIndex],
            ],
          );
        },
      ),
      bottomNavigationBar: GNav(
        tabMargin: const EdgeInsets.only(bottom: 10, top: 10, left: 2, right: 2),
        selectedIndex: _currentSelectedIndex,
        onTabChange: (newIndex) {
          Provider.of<BottomNavControll>(context, listen: false)
              .bottomSwitch(newIndex);
        },
        padding: const EdgeInsets.all(11),
        tabBackgroundColor: const Color(0xFFF6E4F6),
        gap: 15,
        activeColor: const Color(0xFF8B575C),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        tabs: const [
          GButton(
            textColor: Colors.black,
            icon: Icons.home_filled,
            text: 'Home',
            iconColor: Color.fromARGB(255, 76, 76, 76),
          ),
          GButton(
            textColor: Colors.black,
            icon: Icons.search,
            text: 'Explore',
            iconColor: Color.fromARGB(255, 76, 76, 76),
          ),
          GButton(
            textColor: Colors.black,
            icon: Icons.shopping_cart,
            text: 'Cart',
            iconColor: Color.fromARGB(255, 76, 76, 76),
          ),
          GButton(
            textColor: Colors.black,
            icon: Icons.book_online,
            text: 'Booking',
            iconColor: Color.fromARGB(255, 76, 76, 76),
          ),
          GButton(
            textColor: Colors.black,
            icon: Icons.person,
            text: 'Profile',
            iconColor: Color.fromARGB(255, 76, 76, 76),
          ),
        ],
      ),
    );
  }
}
