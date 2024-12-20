import 'package:flutter/material.dart';
import 'package:myapp/Akun/LoginScreen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/welcome.jpg',
                      height: 180, // Atur tinggi gambar
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: 30),
                    Text(
                      "Halo, selamat datang di CitizenComp!",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Aplikasi warga Blimbing only. Di sini, kamu bisa langsung laporin masalah yang kamu temui, dari yang kecil sampai yang besar! Yuk, jadi bagian dari perubahan positif dan bareng-bareng bikin lingkungan kita lebih aman dan nyaman!",
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.5, // Jarak antar baris
                        color: Colors.grey[700], // Warna abu lebih lembut
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Lanjutkan',
                        style: TextStyle(
                          color: const Color.fromRGBO(83, 127, 231, 1),
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(
                        Icons.arrow_forward,
                        color: const Color.fromRGBO(83, 127, 231, 1),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
