import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../../controllers/auth_controller.dart';
import '../../widgets/social_login_button.dart';
import 'signup_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => Get.to(null),
              child: Text(
                'RentRover',
                style: GoogleFonts.pacifico(
                  fontSize: 40,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 40),
            TextField(
              controller: authController.emailController,
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[100],
                prefixIcon: const Icon(Icons.email, color: Colors.black),
                hintText: 'Email',
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: authController.passwordController,
              obscureText: true,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[100],
                prefixIcon: const Icon(Icons.lock, color: Colors.black),
                hintText: 'Password',
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Forgot Password?',
                style: TextStyle(color: Colors.grey[700]),
              ),
            ),
            const SizedBox(height: 20),
            Obx(() => SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: authController.isLoading.value
                    ? null
                    : () {
                  authController.logIn();
                },
                child: authController.isLoading.value
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Sign in'),
              ),
            )),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account? ",
                  style: TextStyle(color: Colors.black87),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => SignUpPage()),
                    );
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.deepPurpleAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'or sign in with',
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                socialLoginButton('assets/auth/google.png', () {}),
                socialLoginButton('assets/auth/facebook.png', () {}),
                socialLoginButton('assets/auth/apple.png', () {}),
                socialLoginButton('assets/auth/x.png', () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
