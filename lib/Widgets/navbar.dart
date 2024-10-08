import 'package:farmfusion/Screens/users/userHomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Screens/users/userBookedScreen.dart';
import '../Screens/users/userProfileScreen.dart';

class NavbarController extends GetxController {
  var selectedIndex = 0.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}

class Navbar extends StatelessWidget {
  final NavbarController navbarController = Get.put(NavbarController());

  final screens = [
    userHomeScreen(),
    userBookedScreen(),
    userProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() => screens[navbarController.selectedIndex.value]),
      bottomNavigationBar: Obx(
            () => BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.green,
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
            fontFamily: "LocalFont",
          ),
          unselectedLabelStyle: TextStyle(
            fontFamily: "LocalFont",
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          currentIndex: navbarController.selectedIndex.value,
          onTap: navbarController.changeIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.book), label: "Booked"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
    );
  }
}
