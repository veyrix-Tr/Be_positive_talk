class Vendor {
  final String id;
  final String name;
  final String image;
  final int ratePerMinute;
  final bool isOnline;
  final String description;

  Vendor({
    required this.id,
    required this.name,
    required this.image,
    required this.ratePerMinute,
    required this.isOnline,
    this.description = '',
  });
}
