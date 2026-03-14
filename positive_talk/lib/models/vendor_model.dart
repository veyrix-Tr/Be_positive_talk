class Vendor {
  final String id;
  final String name;
  final String gender;
  final int age;
  final String profileImage;
  final double rating;
  final int totalReviews;
  final String description;
  final int experienceHours;
  final bool isOnline;
  final bool verified;
  final int ratePerMinute;

  const Vendor({
    required this.id,
    required this.name,
    required this.gender,
    required this.age,
    required this.profileImage,
    required this.rating,
    required this.totalReviews,
    required this.description,
    required this.experienceHours,
    required this.isOnline,
    required this.verified,
    required this.ratePerMinute,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      id: json['id'] as String,
      name: json['name'] as String,
      gender: json['gender'] as String,
      age: json['age'] as int,
      profileImage: json['profileImage'] as String,
      rating: (json['rating'] as num).toDouble(),
      totalReviews: json['totalReviews'] as int,
      description: json['description'] as String,
      experienceHours: json['experienceHours'] as int,
      isOnline: json['isOnline'] as bool,
      verified: json['verified'] as bool,
      ratePerMinute: json['ratePerMinute'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'gender': gender,
      'age': age,
      'profileImage': profileImage,
      'rating': rating,
      'totalReviews': totalReviews,
      'description': description,
      'experienceHours': experienceHours,
      'isOnline': isOnline,
      'verified': verified,
      'ratePerMinute': ratePerMinute,
    };
  }
}
