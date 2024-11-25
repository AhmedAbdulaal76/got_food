class Ingredient {
  String name;
  double? quantity;
  String? unit;
  String imageUrl = '';

  Ingredient({required this.name, this.quantity, this.unit, required imageUrl});

  factory Ingredient.fromJson(Map<String, dynamic> json,
      {double? quantity, String? unit}) {
    return Ingredient(
      name: json['name'],
      imageUrl: json['imageurl'],
      quantity: quantity,
      unit: unit,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'imageurl': imageUrl,
        // 'quantity': quantity,
        // 'unit': unit,
      };
}
