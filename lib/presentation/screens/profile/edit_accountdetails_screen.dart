import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../controllers/editaccount_controller.dart';

class EditAccountPage extends StatelessWidget {
  final accountController = Get.put(EditAccountController());

EditAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, color: Colors.black),
          onPressed: () => Get.back(result: true),
        ),
        title: Text(
          'Edit Account',
          style: GoogleFonts.playfairDisplay(
            fontSize: 22,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              GestureDetector(
                onTap: accountController.pickImage,
                child: CircleAvatar(
                  radius: Get.width * 0.22,
                  backgroundImage: accountController.selectedImage.value != null
                      ? FileImage(accountController.selectedImage.value!)
                      : accountController.userController.profileImageUrl.value.isNotEmpty
                      ? NetworkImage(accountController.userController.profileImageUrl.value)
                      : const AssetImage('assets/default_profile.png') as ImageProvider,
                ),
              ),
              const SizedBox(height: 24),
              buildTextField(
                label: 'Name',
                controller: accountController.nameController,
              ),
              const SizedBox(height: 20),
              buildTextField(
                label: 'Email',
                controller: accountController.emailController,
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: accountController.isLoading.value
                      ? null
                      : accountController.saveChanges,
                  child: accountController.isLoading.value
                      ? const CircularProgressIndicator(
                      color: Colors.white, strokeWidth: 2.5)
                      : Text(
                    'Save Changes',
                    style: GoogleFonts.barlow(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }

  Widget buildTextField({
    required String label,
    required TextEditingController controller,
  }) {
    return TextField(
      controller: controller,
      style: GoogleFonts.barlow(
        color: Colors.black,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.barlow(
          color: Colors.grey[700],
          fontSize: 15,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.deepPurpleAccent),
        ),
      ),
    );
  }
}
