import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _tokenKey = 'auth_token';
  final SharedPreferences _prefs;

  AuthService(this._prefs);

  Future<String?> login(String email) async {
    try {
      // Mock API call
      await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
      
      // Mock successful response
      const mockToken = 'mock_jwt_token_123456';
      
      // Save token
      await _prefs.setString(_tokenKey, mockToken);
      
      return mockToken;
    } catch (e) {
      return null;
    }
  }

  Future<void> logout() async {
    await _prefs.remove(_tokenKey);
  }

  String? getToken() {
    return _prefs.getString(_tokenKey);
  }

  bool isLoggedIn() {
    return getToken() != null;
  }
} 