class Recipe {
  final String recipeId;
  final String creatorId;
  final String name;
  final String imageUrl;
  final String description;
  final String subtitle;
  final String instructions;
  final int likes;
  final int calories;
  final int time;

  Recipe({
    required this.recipeId,
    required this.creatorId,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.subtitle,
    required this.instructions,
    required this.likes,
    required this.calories,
    required this.time,
  });

  // Factory constructor to create a Recipe instance from JSON
  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      recipeId: json['recipe_id'] as String,
      creatorId: json['creator_id'] as String,
      name: json['name'] as String,
      imageUrl: json['imageurl'] as String,
      description: json['description'] as String,
      subtitle: json['subtitle'] as String,
      instructions: json['instructions'] as String,
      likes: json['likes'] as int,
      calories: json['calories'] as int,
      time: json['time'] as int,
    );
  }

  // Method to convert Recipe instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'recipe_id': recipeId,
      'creator_id': creatorId,
      'name': name,
      'imageurl': imageUrl,
      'description': description,
      'subtitle': subtitle,
      'instructions': instructions,
      'likes': likes,
    };
  }
}
