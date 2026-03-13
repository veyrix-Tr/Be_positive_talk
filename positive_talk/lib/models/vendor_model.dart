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

  Vendor copyWith({
    String? id,
    String? name,
    String? gender,
    int? age,
    String? profileImage,
    double? rating,
    int? totalReviews,
    String? description,
    int? experienceHours,
    bool? isOnline,
    bool? verified,
    int? ratePerMinute,
  }) {
    return Vendor(
      id: id ?? this.id,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      profileImage: profileImage ?? this.profileImage,
      rating: rating ?? this.rating,
      totalReviews: totalReviews ?? this.totalReviews,
      description: description ?? this.description,
      experienceHours: experienceHours ?? this.experienceHours,
      isOnline: isOnline ?? this.isOnline,
      verified: verified ?? this.verified,
      ratePerMinute: ratePerMinute ?? this.ratePerMinute,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Vendor &&
        other.id == id &&
        other.name == name &&
        other.gender == gender &&
        other.age == age &&
        other.profileImage == profileImage &&
        other.rating == rating &&
        other.totalReviews == totalReviews &&
        other.description == description &&
        other.experienceHours == experienceHours &&
        other.isOnline == isOnline &&
        other.verified == verified &&
        other.ratePerMinute == ratePerMinute;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        gender.hashCode ^
        age.hashCode ^
        profileImage.hashCode ^
        rating.hashCode ^
        totalReviews.hashCode ^
        description.hashCode ^
        experienceHours.hashCode ^
        isOnline.hashCode ^
        verified.hashCode ^
        ratePerMinute.hashCode;
  }

  @override
  String toString() {
    return 'Vendor(id: $id, name: $name, gender: $gender, age: $age, profileImage: $profileImage, rating: $rating, totalReviews: $totalReviews, description: $description, experienceHours: $experienceHours, isOnline: $isOnline, verified: $verified, ratePerMinute: $ratePerMinute)';
  }
}
