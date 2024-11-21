import 'package:flutter/material.dart';

class IngredientsTab extends StatelessWidget {
  const IngredientsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 400,
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            "Ingredients",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _ingredientItem("Ingredient 1", "2 cups"),
          _ingredientItem("Ingredient 2", "1 spoon"),
          _ingredientItem("Ingredient 3", "3 teaspoons"),
          _ingredientItem("Ingredient 4", "500 grams"),
        ],
      ),
    );
  }

  Widget _ingredientItem(String name, String quantity) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          color: Colors.grey[300],
        ),
        title: Text(name),
        trailing: Text(quantity),
      ),
    );
  }
}
