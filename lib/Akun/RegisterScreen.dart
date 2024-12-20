import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Light background for a clean look
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 100),  // Increased space at the top

              // App Icon - Using a lock icon
              const Icon(Icons.person_add, size: 100, color: Color.fromRGBO(83, 127, 231, 1)),
              const SizedBox(height: 20),
              const Text(
                'Buat Akun Baru',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // Email Text Field with Modern Design
              _buildTextField(
                controller: emailController,
                label: 'Email',
                obscureText: false,
              ),
              const SizedBox(height: 20),

              // Password Text Field with Modern Design
              _buildTextField(
                controller: passwordController,
                label: 'Password',
                obscureText: true,
              ),
              const SizedBox(height: 30),

              // Register Button with Adjusted Size
              ElevatedButton(
                onPressed: () async {
                  try {
                    final email = emailController.text.trim();
                    final password = passwordController.text.trim();

                    // Register user with email and password
                    await _auth.createUserWithEmailAndPassword(
                      email: email,
                      password: password,
                    );

                    Get.snackbar('Registration', 'Registration successful! Please log in.',
                        backgroundColor: const Color.fromRGBO(83, 127, 231, 1), colorText: Colors.white);
                    Get.offAllNamed('/'); // Go back to LoginScreen
                  } catch (e) {
                    Get.snackbar('Error', e.toString(),
                        backgroundColor: Colors.red, colorText: Colors.white);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(83, 127, 231, 1), // Blue button for consistency
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12), // Smaller padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Daftar',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white), // Consistent text size
                ),
              ),
              const SizedBox(height: 20),

              // Text Button to Login Page
              TextButton(
                onPressed: () {
                  Get.offNamed('/login'); // Navigate to LoginScreen
                },
                child: const Text(
                  'Sudah punya akun? Masuk di sini.',
                  style: TextStyle(color: Color.fromRGBO(83, 127, 231, 1)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Custom TextField Builder
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required bool obscureText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label Text with bold style
        Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold, // Bold label text
          ),
        ),
        const SizedBox(height: 5),
        // Container for TextField with shadow effect
        Container(
          decoration: BoxDecoration(
            color: Colors.white, // White background for input box
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color.fromRGBO(83, 127, 231, 1), width: 2), // Blue border
          ),
          child: TextField(
            controller: controller,
            style: const TextStyle(color: Colors.black),
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide.none, // Remove inner border
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            ),
            obscureText: obscureText,
          ),
        ),
      ],
    );
  }
}
