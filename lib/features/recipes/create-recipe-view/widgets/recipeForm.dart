import 'package:flutter/material.dart';

import 'categoriesList.dart';
import 'imagePicker.dart';
import 'ingredientList.dart';

class RecipeForm extends StatelessWidget {
  RecipeForm({super.key});

  // form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Picker Section
          const Center(child: ImagePickerWidget()),
          const SizedBox(height: 16.0),

          // Recipe Name
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Recipe Name',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a recipe name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),

          // Subtitle
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Subtitle',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a subtitle';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),

          // Description
          TextFormField(
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'Description',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a description';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),

          // Instructions
          TextFormField(
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'Instructions',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter instructions';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),

          // Calories and Time
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Calories (Kcal)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter calories';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Time (mins)',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter time';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),

          // Ingredients Section
          Text(
            'Ingredients',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12.0),
          const IngredientList(),

          // Categories Section
          Text(
            'Categories',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12.0),
          const CategoryList(),
          const SizedBox(height: 16.0),

          // Submit Button
          Center(
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                }
              },
              child: const Text('Save Recipe'),
            ),
          ),
        ],
      ),
    );
  }
}
