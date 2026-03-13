import 'dart:async';
import '../models/vendor_model.dart';

class VendorService {
  static final VendorService _instance = VendorService._internal();
  factory VendorService() => _instance;
  VendorService._internal();

  // Mock vendor data
  final List<Vendor> _mockVendors = [
    Vendor(
      id: '1',
      name: 'Aashna',
      gender: 'F',
      age: 25,
      profileImage: 'assets/profile1.png',
      rating: 4.82,
      totalReviews: 3000,
      description: 'Professional counselor with 5+ years experience in career guidance and personal development.',
      experienceHours: 1000,
      isOnline: true,
      verified: true,
      ratePerMinute: 5,
    ),
    Vendor(
      id: '2',
      name: 'Mike Chen',
      gender: 'M',
      age: 32,
      profileImage: 'assets/profile1.png',
      rating: 4.75,
      totalReviews: 2500,
      description: 'Tech career coach specializing in software engineering interviews and resume building.',
      experienceHours: 800,
      isOnline: true,
      verified: true,
      ratePerMinute: 6,
    ),
    Vendor(
      id: '3',
      name: 'Emma Davis',
      gender: 'F',
      age: 28,
      profileImage: 'assets/profile1.png',
      rating: 4.90,
      totalReviews: 1800,
      description: 'Life coach focused on work-life balance and personal growth strategies.',
      experienceHours: 600,
      isOnline: false,
      verified: true,
      ratePerMinute: 4,
    ),
    Vendor(
      id: '4',
      name: 'Lisa Wang',
      gender: 'F',
      age: 30,
      profileImage: 'assets/profile1.png',
      rating: 4.65,
      totalReviews: 1200,
      description: 'Financial advisor helping with budget planning and investment strategies.',
      experienceHours: 750,
      isOnline: true,
      verified: false,
      ratePerMinute: 7,
    ),
    Vendor(
      id: '5',
      name: 'Robert Johnson',
      gender: 'M',
      age: 35,
      profileImage: 'assets/profile1.png',
      rating: 4.55,
      totalReviews: 900,
      description: 'Business consultant specializing in startup strategy and growth hacking.',
      experienceHours: 500,
      isOnline: false,
      verified: true,
      ratePerMinute: 8,
    ),
  ];

  Future<List<Vendor>> getVerifiedVendors() async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 800));
    
    // Return only verified vendors
    return _mockVendors.where((vendor) => vendor.verified).toList();
  }

  Future<Vendor?> getVendorById(String vendorId) async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    try {
      return _mockVendors.firstWhere((vendor) => vendor.id == vendorId);
    } catch (e) {
      return null;
    }
  }

  Future<List<Vendor>> getAllVendors() async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 800));
    
    return _mockVendors;
  }

  Future<List<Vendor>> getVendorsByCategory(String category) async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 600));
    
    // Mock category filtering
    switch (category.toLowerCase()) {
      case 'counseling':
        return _mockVendors.where((v) => v.name.contains('Aashna') || v.name.contains('Emma')).toList();
      case 'tech':
        return _mockVendors.where((v) => v.name.contains('Mike')).toList();
      case 'business':
        return _mockVendors.where((v) => v.name.contains('Robert') || v.name.contains('Lisa')).toList();
      default:
        return _mockVendors;
    }
  }

  Future<void> updateVendorOnlineStatus(String vendorId, bool isOnline) async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 300));
    
    // Update mock data
    final vendorIndex = _mockVendors.indexWhere((v) => v.id == vendorId);
    if (vendorIndex != -1) {
      _mockVendors[vendorIndex] = _mockVendors[vendorIndex].copyWith(isOnline: isOnline);
    }
  }
}
