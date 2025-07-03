import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yap/presentation/screens/profile/profile_screen.dart';
import 'package:yap/presentation/screens/home/home_screen.dart';
import 'package:yap/presentation/screens/chat/chat_list_screen.dart';
import 'package:yap/presentation/widgets/bottom_navigation_bar.dart';
import '../../app/controllers/nav_controller.dart';

class MainScaffold extends StatelessWidget {
  MainScaffold({super.key});

  final NavController navController = Get.find();

  final List<Widget> screens = [
     HomeScreen(),
     ChatListScreen(),
     ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: screens[navController.selectedIndex.value],
      bottomNavigationBar: BottomNavBar(navController: navController),
    ));
  }
}