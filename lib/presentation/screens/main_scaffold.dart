
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yap/presentation/screens/profile/profile_screen.dart';
import '../../controllers/nav_controller.dart';
import '../widgets/bottom_navigation_bar.dart';


class MainScaffold extends StatelessWidget {
  MainScaffold({super.key});

  final NavController navController = Get.put(NavController());

  final List<Widget> screens = [


    ProfileScreen(),
    ProfileScreen(),
    ProfileScreen(),
    ProfileScreen(),

  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      backgroundColor:   Color(0xFF121212),
      body: screens[navController.selectedIndex.value],
      bottomNavigationBar: BottomNavBar(navController: navController),
    ));
  }
}


