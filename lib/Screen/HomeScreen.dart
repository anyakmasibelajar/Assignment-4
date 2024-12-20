import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/Controller/HomeController.dart';
import 'package:myapp/Galeri/GalleryScreen.dart';
import 'package:myapp/Jadwal/MusyawarahScheduleScreen.dart';
import 'package:myapp/Laporan/LaporPage.dart';
import 'package:myapp/Laporan/ReportFormScreen.dart';
import 'package:myapp/Pengumuman/AnnouncementScreen.dart';
import 'package:myapp/Screen/splashscreen.dart';

class HomeScreen extends StatelessWidget {
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Beranda',
          style: TextStyle(
            fontWeight: FontWeight.bold, // Make the title bold
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          // Logout button on the top right
          IconButton(
            icon: const Icon(Icons.exit_to_app, color: Colors.black),
            onPressed: () {
              // Show a logout confirmation message
              Get.snackbar("Logout", "You have logged out successfully!");

              // Navigate to the splash screen
              Get.offAll(() => SplashScreen()); // Navigate to SplashScreen
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with rounded corners
            ClipRRect(
              borderRadius: BorderRadius.circular(12), // Set corner radius here
              child: Image.asset(
                'assets/banner.png',
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10), // Removed space between the banner and the arrows

            // "Coming Soon!" indicator with three upward arrows side by side
            Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center, // Center the arrows horizontally
                    children: const [
                      Icon(
                        Icons.arrow_upward,
                        size: 30, // Arrow size
                        color: Colors.black,
                      ),
                      Icon(
                        Icons.arrow_upward,
                        size: 30, // Arrow size
                        color: Colors.black,
                      ),
                      Icon(
                        Icons.arrow_upward,
                        size: 30, // Arrow size
                        color: Colors.black,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4), // Small space below the arrows
                  const Text(
                    'Coming Soon!',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18, // Text size
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16), // Space after the arrows and text

            Text(
              'Fitur',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildServiceOption(
                    icon: Icons.notifications,
                    title: 'Pengumuman',
                    onTap: () {
                      Get.to(() => AnnouncementScreen());
                    },
                  ),
                  _buildServiceOption(
                    icon: Icons.report_problem,
                    title: 'Laporan Warga',
                    onTap: () {
                      Get.to(() => LaporPage());
                    },
                  ),
                  _buildServiceOption(
                    icon: Icons.calendar_today,
                    title: 'Jadwal Musyawarah',
                    onTap: () {
                      Get.to(() => MusyawarahScheduleScreen());
                    },
                  ),
                  _buildServiceOption(
                    icon: Icons.photo_library,
                    title: 'Galeri Kita',
                    onTap: () {
                      Get.to(() => GalleryScreen());
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => ReportFormScreen());
        },
        child: ClipOval(
          child: Image.asset(
            'assets/add.png',
            width: 40,
            height: 40,
            fit: BoxFit.cover,
          ),
        ),
        backgroundColor: const Color.fromRGBO(83, 127, 231, 1),
        shape: CircleBorder(),
        elevation: 0,
      ),
    );
  }

  Widget _buildServiceOption({required IconData icon, required String title, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: const Color.fromRGBO(83, 127, 231, 1)),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: Colors.black87,
        ),
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }
}
