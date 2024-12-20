import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatelessWidget {
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
              const SizedBox(height: 50),
              
              // Logo Image
              Image.asset(
                'assets/logo.png',
                height: 150,
              ),
              
              const SizedBox(height: 20),
              const Text(
                'Selamat Datang Kembali!',
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

              // Login Button with Adjusted Size
              ElevatedButton(
                onPressed: () async {
                  try {
                    final email = emailController.text.trim();
                    final password = passwordController.text.trim();

                    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
                      email: email,
                      password: password,
                    );

                    if (userCredential.user != null) {
                      Get.snackbar('Login', 'Login berhasil!', backgroundColor: const Color.fromARGB(255, 255, 255, 255), colorText: const Color.fromARGB(255, 0, 0, 0));
                      Get.offNamed('/home');
                    }
                  } catch (e) {
                    Get.snackbar('Error', e.toString(), backgroundColor: Colors.red, colorText: Colors.white);
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
                  'Login',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white), // Smaller text size
                ),
              ),
              const SizedBox(height: 20),

              // Text Button to Register Page
              TextButton(
                onPressed: () {
                  Get.offNamed('/register');
                },
                child: const Text(
                  'Belum punya akun? Daftar di sini.',
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
        Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color.fromRGBO(83, 127, 231, 1), width: 2),
          ),
          child: TextField(
            controller: controller,
            style: const TextStyle(color: Colors.black),
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide.none,
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
