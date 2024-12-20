import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Simulasi loading
    Future.delayed(Duration(seconds: 5), () {
      Get.offNamed('/welcomescreen');
    });

    return Scaffold(
      backgroundColor: Colors.white, // Menetapkan background menjadi putih
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Menampilkan logo di atas teks
            Image.asset(
              'assets/anounc.png', // Ganti dengan path ke logo Anda
              height: 80, // Atur tinggi logo sesuai kebutuhan
            ),
            SizedBox(height: 20), // Jarak antara logo dan teks
            Text(
              'CitizenComp',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
