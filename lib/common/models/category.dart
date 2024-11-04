class Category {
  final String categoryId;
  final String name;
  final String imageUrl;

  Category({
    required this.categoryId,
    required this.name,
    required this.imageUrl,
  });

  // Factory constructor to create a Category instance from JSON
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categoryId: json['category_id'] as String,
      name: json['name'] as String,
      imageUrl: json['imageurl'] as String,
    );
  }

  // Method to convert Category instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'category_id': categoryId,
      'name': name,
      'imageurl': imageUrl,
    };
  }
}
