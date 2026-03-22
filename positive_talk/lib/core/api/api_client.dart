import 'dart:convert';
import 'package:http/http.dart' as http;
import '../storage/token_storage.dart';

class ApiClient {
  static const String baseUrl = 'http://localhost:5000';
  
  // Singleton pattern
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;
  ApiClient._internal();

  // Get headers with token
  Future<Map<String, String>> _getHeaders({bool requireAuth = false}) async {
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };

    if (requireAuth) {
      final token = await TokenStorage.getToken();
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }
    }

    return headers;
  }

  // GET request
  Future<http.Response> get(
    String endpoint, {
    bool requireAuth = false,
    Map<String, String>? queryParams,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint').replace(queryParameters: queryParams);
      final headers = await _getHeaders(requireAuth: requireAuth);
      
      final response = await http.get(uri, headers: headers);
      return response;
    } catch (e) {
      throw ApiException('Network error: $e');
    }
  }

  // POST request
  Future<http.Response> post(
    String endpoint, {
    bool requireAuth = false,
    Map<String, dynamic>? body,
    Map<String, String>? queryParams,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint').replace(queryParameters: queryParams);
      final headers = await _getHeaders(requireAuth: requireAuth);
      
      final response = await http.post(
        uri,
        headers: headers,
        body: body != null ? json.encode(body) : null,
      );
      return response;
    } catch (e) {
      throw ApiException('Network error: $e');
    }
  }

  // PUT request
  Future<http.Response> put(
    String endpoint, {
    bool requireAuth = false,
    Map<String, dynamic>? body,
    Map<String, String>? queryParams,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint').replace(queryParameters: queryParams);
      final headers = await _getHeaders(requireAuth: requireAuth);
      
      final response = await http.put(
        uri,
        headers: headers,
        body: body != null ? json.encode(body) : null,
      );
      return response;
    } catch (e) {
      throw ApiException('Network error: $e');
    }
  }

  // Handle response and parse JSON
  Map<String, dynamic> handleResponse(http.Response response) {
    try {
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return json.decode(response.body);
      } else {
        final errorData = json.decode(response.body);
        throw ApiException(errorData['message'] ?? 'Request failed');
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Response parsing error: $e');
    }
  }

  // Handle response for list data
  List<dynamic> handleListResponse(http.Response response) {
    try {
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return json.decode(response.body);
      } else {
        final errorData = json.decode(response.body);
        throw ApiException(errorData['message'] ?? 'Request failed');
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Response parsing error: $e');
    }
  }
}

// Custom exception for API errors
class ApiException implements Exception {
  final String message;
  
  ApiException(this.message);
  
  @override
  String toString() => message;
}
