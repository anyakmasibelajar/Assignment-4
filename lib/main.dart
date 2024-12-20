import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:myapp/Akun/LoginScreen.dart';
import 'package:myapp/Akun/RegisterScreen.dart';
import 'package:myapp/Screen/HomeScreen.dart';
import 'package:myapp/Controller/HomeController.dart'; 
import 'package:myapp/Screen/SplashScreen.dart';
import 'package:myapp/Screen/WelcomeScreen.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Inisialisasi HomeController dengan Get.put()
  Get.put(HomeController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'CitizenComp',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/', // Tetap ke '/' untuk SplashScreen
      getPages: [
        GetPage(name: '/', page: () => SplashScreen()),
        GetPage(name: '/welcomescreen', page: () => WelcomeScreen()),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/register', page: () => RegisterScreen()),
        GetPage(name: '/home', page: () => HomeScreen()),
      ],
    );
  }
}
