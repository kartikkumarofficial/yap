import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controllers/theme_controller.dart';
import '../../../controllers/user_controller.dart';
import '../../widgets/profile_tile.dart';
import 'edit_accountdetails_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ThemeController themeController = Get.put(ThemeController());
  final UserController userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
    userController.fetchUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: userController.fetchUserProfile,
        child: Stack(
          children: [
            Obx(() => userController.isLoading.value
                ? Center(child: CircularProgressIndicator())
                : ListView(
              children: [
                const SizedBox(height: 45),
                Center(
                  child: CircleAvatar(
                    radius: Get.width * 0.17,
                    backgroundImage:
                    userController.profileImageUrl.value.isNotEmpty
                        ? NetworkImage(userController.profileImageUrl.value)
                        : const AssetImage('assets/default_profile.png') as ImageProvider,
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    userController.userName.value,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Center(
                  child: Text(
                    userController.email.value,
                    style: GoogleFonts.barlow(color: Colors.grey[700]),
                  ),
                ),
                 SizedBox(height: Get.height*0.2),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 32),
                      ProfileTile(
                        onTap: () async {
                          final result = await Get.to(() => EditAccountPage());
                          if (result == true) {
                            userController.fetchUserProfile();
                          }
                        },
                        icon: Icons.settings,
                        label: "Edit Account Details",
                      ),
                      Obx(() => ProfileTile(
                        icon: Icons.brightness_6,
                        label: themeController.isDarkMode.value
                            ? "Switch to Light Mode"
                            : "Switch to Dark Mode",
                        onTap: themeController.toggleTheme,
                      )),
                      ProfileTile(
                        icon: Icons.lock,
                        label: "Security",
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                TextButton.icon(
                  onPressed: () {
                    userController.logout();
                  },
                  icon: const Icon(Icons.logout, color: Colors.redAccent),
                  label: const Text(
                    'Log Out',
                    style: TextStyle(color: Colors.redAccent),
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: Text(
                    "v1.0.0 • RentRover",
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
