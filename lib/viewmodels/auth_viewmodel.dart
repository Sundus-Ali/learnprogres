import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // -- Somali Comments --
  // Habka gelitaanka (Login function)
  // Halkan waxaa lagu maamulayaa xaaladda loading-ka iyo wicitaanka API-ga.
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    // TODO: Connect to Real Backend later
    await Future.delayed(const Duration(seconds: 2)); // Simulating network delay

    _isLoading = false;
    notifyListeners();
    return true; // Mock success
  }

  // Habka diiwaangelinta (Registration function)
  Future<bool> register(String name, String email, String password) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    _isLoading = false;
    notifyListeners();
    return true;
  }
}
