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
      name: 'Priya',
      gender: 'F',
      age: 28,
      profileImage: 'assets/profile2.png',
      rating: 4.75,
      totalReviews: 2500,
      description: 'Relationship expert specializing in marriage counseling and family therapy.',
      experienceHours: 800,
      isOnline: true,
      verified: true,
      ratePerMinute: 4,
    ),
    Vendor(
      id: '3',
      name: 'Rajesh',
      gender: 'M',
      age: 35,
      profileImage: 'assets/profile3.png',
      rating: 4.68,
      totalReviews: 1800,
      description: 'Business consultant with expertise in startups and entrepreneurship.',
      experienceHours: 1200,
      isOnline: false,
      verified: true,
      ratePerMinute: 6,
    ),
    Vendor(
      id: '4',
      name: 'Neha',
      gender: 'F',
      age: 30,
      profileImage: 'assets/profile4.png',
      rating: 4.90,
      totalReviews: 3200,
      description: 'Mental health professional specializing in anxiety and depression therapy.',
      experienceHours: 1500,
      isOnline: true,
      verified: true,
      ratePerMinute: 7,
    ),
    Vendor(
      id: '5',
      name: 'Amit',
      gender: 'M',
      age: 40,
      profileImage: 'assets/profile5.png',
      rating: 4.55,
      totalReviews: 1200,
      description: 'Life coach focused on personal growth and goal achievement.',
      experienceHours: 600,
      isOnline: true,
      verified: false,
      ratePerMinute: 3,
    ),
  ];

  // Get verified vendors
  Future<List<Vendor>> getVerifiedVendors() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Return only verified vendors
    return _mockVendors.where((vendor) => vendor.verified).toList();
  }

  // Get vendor by ID
  Future<Vendor?> getVendorById(String vendorId) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    try {
      return _mockVendors.firstWhere((vendor) => vendor.id == vendorId);
    } catch (e) {
      return null;
    }
  }
}
