class Vendor {
  final String id;
  final String name;
  final String image;
  final int ratePerMinute;
  final bool isOnline;
  final String description;
  final String gender;
  final int age;
  final double rating;
  final int reviewCount;
  final int experienceHours;

  Vendor({
    required this.id,
    required this.name,
    required this.image,
    required this.ratePerMinute,
    required this.isOnline,
    this.description = '',
    this.gender = 'F',
    this.age = 25,
    this.rating = 4.5,
    this.reviewCount = 120,
    this.experienceHours = 1000,
  });
}
