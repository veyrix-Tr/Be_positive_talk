import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/vendor_model.dart';

class VendorService {
  static final VendorService _instance = VendorService._internal();
  factory VendorService() => _instance;
  VendorService._internal();

  List<Vendor> _vendors = [];

  // Load vendors from JSON file
  Future<void> _loadVendors() async {
    if (_vendors.isNotEmpty) return;

    try {
      final String jsonString = await rootBundle.loadString(
        'assets/data/vendors.json',
      );
      final Map<String, dynamic> data = json.decode(jsonString);
      final List<dynamic> vendorsList = data['vendors'];

      _vendors = vendorsList.map((json) => Vendor.fromJson(json)).toList();
    } catch (e) {
      // Fallback to empty list if JSON loading fails
      _vendors = [];
    }
  }

  // Get verified vendors
  Future<List<Vendor>> getVerifiedVendors() async {
    await _loadVendors();

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Return only verified vendors
    return _vendors.where((vendor) => vendor.verified).toList();
  }

  // Get vendor by ID
  Future<Vendor?> getVendorById(String vendorId) async {
    await _loadVendors();

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    try {
      return _vendors.firstWhere((vendor) => vendor.id == vendorId);
    } catch (e) {
      return null;
    }
  }
}
