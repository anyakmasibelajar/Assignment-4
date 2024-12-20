import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var isLoading = false.obs;

  Future<void> registerUser(String email, String password) async {
    try {
      isLoading.value = true;

      // Mendaftar pengguna dengan email dan password
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      Get.snackbar('Pendaftaran', 'Registrasi berhasil! Silakan login.');
      Get.back();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}