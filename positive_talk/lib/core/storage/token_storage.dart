import 'package:shared_preferences/shared_preferences.dart';
import 'dart:html' as html;
import 'package:flutter/foundation.dart' show kIsWeb;

class TokenStorage {
  static const String _tokenKey = 'auth_token';

  // Save token to storage
  static Future<void> saveToken(String token) async {
    try {
      // For web, use localStorage
      if (kIsWeb) {
        html.window.localStorage[_tokenKey] = token;
        return;
      }

      // For mobile, use SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_tokenKey, token);
    } catch (e) {
      throw Exception('Failed to save token: $e');
    }
  }

  // Get token from storage
  static Future<String?> getToken() async {
    try {
      // For web, use localStorage
      if (kIsWeb) {
        return html.window.localStorage[_tokenKey];
      }

      // For mobile, use SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_tokenKey);
    } catch (e) {
      throw Exception('Failed to get token: $e');
    }
  }

  // Clear token from storage
  static Future<void> clearToken() async {
    try {
      // For web, use localStorage
      if (kIsWeb) {
        html.window.localStorage.remove(_tokenKey);
        return;
      }

      // For mobile, use SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_tokenKey);
    } catch (e) {
      throw Exception('Failed to clear token: $e');
    }
  }

  // Check if token exists
  static Future<bool> hasToken() async {
    try {
      final token = await getToken();
      return token != null && token.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
}
