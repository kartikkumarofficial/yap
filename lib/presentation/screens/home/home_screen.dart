import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../../app/controllers/user_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find<UserController>();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          'Home',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() {
              if (userController.isLoading.value) {
                return const CircularProgressIndicator();
              }
              return Text(
                'Hello, ${userController.userName.value}!',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              );
            }),
            const SizedBox(height: 10),
            Text(
              'Welcome to Yap!',
              style: GoogleFonts.barlow(
                fontSize: 16,
                color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 50),
            Obx(() {
              if (userController.profileImageUrl.value.isNotEmpty) {
                return CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(userController.profileImageUrl.value),
                );
              }
              return CircleAvatar(
                radius: 60,
                backgroundColor: Theme.of(context).colorScheme.surface,
                child: Icon(Icons.person, size: 60, color: Theme.of(context).colorScheme.onSurface),
              );
            }),
          ],
        ),
      ),
    );
  }
}