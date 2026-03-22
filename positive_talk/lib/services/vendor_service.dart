import '../models/vendor_model.dart';
import '../core/api/api_client.dart';

class VendorService {
  static final VendorService _instance = VendorService._internal();
  factory VendorService() => _instance;
  VendorService._internal();

  // Get all vendors
  Future<List<Vendor>> getAllVendors() async {
    try {
      final apiClient = ApiClient();
      final response = await apiClient.get('/vendors');

      final vendorsData = apiClient.handleListResponse(response);
      return vendorsData.map((json) => Vendor.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load vendors: $e');
    }
  }

  // Get verified vendors
  Future<List<Vendor>> getVerifiedVendors() async {
    try {
      final vendors = await getAllVendors();
      return vendors.where((vendor) => vendor.verified).toList();
    } catch (e) {
      throw Exception('Failed to load verified vendors: $e');
    }
  }

  // Get vendor by ID
  Future<Vendor?> getVendorById(String vendorId) async {
    try {
      final apiClient = ApiClient();
      final response = await apiClient.get('/vendors/$vendorId');

      final vendorData = apiClient.handleResponse(response);
      return Vendor.fromJson(vendorData);
    } catch (e) {
      // Return null if vendor not found (404)
      if (e.toString().contains('not found')) {
        return null;
      }
      throw Exception('Failed to load vendor: $e');
    }
  }
}
