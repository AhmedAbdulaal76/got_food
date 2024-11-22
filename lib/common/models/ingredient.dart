class Ingredient {
  String name;
  double quantity;
  String unit;
  String imageUrl = '';

  Ingredient(
      {required this.name,
      required this.quantity,
      required this.unit,
      required imageUrl});

  factory Ingredient.fromJson(Map<String, dynamic> json,
      {required double quantity, required String unit}) {
    return Ingredient(
      name: json['name'],
      imageUrl: json['imageurl'],
      quantity: quantity,
      unit: unit,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'quantity': quantity,
        'unit': unit,
      };
}
