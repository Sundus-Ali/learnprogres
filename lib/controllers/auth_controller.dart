import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var token = ''.obs;
  var userName = ''.obs;

  final ApiService _apiService = ApiService();

  // Login Logic (Habka Galitaanka)
  Future<void> login(String email, String password) async {
    try {
      isLoading(true);
      final data = await _apiService.login(email, password);
      
      // Save Token Locally
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', data['token']);
      await prefs.setString('userName', data['name']);

      token.value = data['token'];
      userName.value = data['name'];

      Get.offAllNamed('/home'); // Go to Dashboard and remove history
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }

  // Register Logic (Is-diiwaangelin)
  Future<void> register(String name, String email, String password) async {
    try {
      isLoading(true);
      final data = await _apiService.register(name, email, password);
      
      // Save Token Locally
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', data['token']);
      await prefs.setString('userName', data['name']);

      token.value = data['token'];
      userName.value = data['name'];

      Get.offAllNamed('/home'); // Success -> Dashboard
    } catch (e) {
      Get.snackbar('Registration Error', e.toString(), snackPosition: SnackPosition.BOTTOM, backgroundColor: Get.theme.colorScheme.error, colorText: Get.theme.colorScheme.onError);
    } finally {
      isLoading(false);
    }
  }

  // Logout Logic
  void logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Get.offAllNamed('/login');
  }
}
