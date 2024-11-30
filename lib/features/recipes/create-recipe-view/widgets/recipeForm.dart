import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'categoriesList.dart';
import 'ingredientList.dart';

class RecipeForm extends StatefulWidget {
  const RecipeForm({super.key});

  @override
  State<RecipeForm> createState() => _RecipeFormState();
}

class _RecipeFormState extends State<RecipeForm> {
  // form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> get formKey => _formKey;

  // Supabase client
  final SupabaseClient supabase = Supabase.instance.client;

  // Image file
  File? _image;

  // TextEditingControllers for the form fields
  final TextEditingController recipeNameController = TextEditingController();
  final TextEditingController subtitleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController instructionsController = TextEditingController();
  final TextEditingController caloriesController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  // List of controllers for the ingredients list
  List<Widget> ingredients = [];
  List<TextEditingController> ingredientControllers = [];
  List<TextEditingController> quantityControllers = [];
  Map<int, String> unitsController = {};

  // list of controllers for the categories list
  List<Widget> categories = [];
  List<TextEditingController> categoryControllers = [];

  @override
  void dispose() {
    recipeNameController.dispose();
    subtitleController.dispose();
    descriptionController.dispose();
    instructionsController.dispose();
    caloriesController.dispose();
    timeController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _saveRecipe(BuildContext context) async {
    try {
      // Upload image to Supabase Storage
      final filePath = 'recipe-${recipeNameController.text}.jpg';
      await supabase.storage.from('recipes').upload(
            filePath,
            _image!,
          );
      final url = supabase.storage.from('recipes').getPublicUrl(
            filePath,
          );
      _onUpload(url);
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading image: $e')),
      );
    }
  }

  Future<void> _onUpload(String imageUrl) async {
    try {
      // Insert data into the 'recipes' table in Supabase
      final userId = supabase.auth.currentUser!.id;
      final response = await supabase.from('recipes').upsert({
        'name': recipeNameController.text,
        'creator_id': userId,
        'imageurl': imageUrl,
        'subtitle': subtitleController.text,
        'description': descriptionController.text,
        'instructions': instructionsController.text,
        'calories': int.tryParse(caloriesController.text),
        'time': int.tryParse(timeController.text),
      }).select('recipe_id');

      List<dynamic> ingredientsTest = [];
      List<dynamic> ingTemp = [];
      List<dynamic> categoryTemp = [];

      for (var i = 0; i < ingredientControllers.length; i++) {
        // insert the ingredients into the 'ingredients' table in Supabase
        final ingredient = ingredientControllers[i].text;
        final Map<String, dynamic> ingobj = {
          'name': ingredient,
        };
        ingTemp.add(ingobj);
      }

      // insert the ingredients into the 'ingredients' table in Supabase
      var ingIDs = [];
      try {
        // ingIDs = await supabase
        //     .from('ingredients')
        //     .upsert(ingTemp, onConflict: 'name', ignoreDuplicates: true)
        //     .select('ingredient_id');
        // print('ingIDs: $ingIDs');
        final values = ingTemp.map((e) => '${e['name']}');
        final dynamic res = await supabase
            .rpc('upsert_bs', params: {'p_values': values.toList()});
        print("rpc response: $res");
        print(
            'printing the map: ${res.map((e) => e['ingredient_id']).toList()}');
        // ingIDs = res.map((e) => e['ingredient_id']).toList();
        ingIDs = res;
        print('ingIDs: $ingIDs');
      } catch (e) {
        // if code is 23505, it means there is a duplicate entry, and we can ignore it and continue, otherwise rethrow the error
        if (e.toString().contains('23505')) {
          print('Duplicate entry');
        } else {
          rethrow;
        }
      }

      for (var i = 0; i < ingIDs.length; i++) {
        final recipeId = response.first['recipe_id'] as String;
        final ingredientId = ingIDs[i]['ingredient_id'] as String;
        Map<String, dynamic> ingredientMap = {
          'recipe_id': recipeId,
          'ingredient_id': ingredientId,
          'quantity': double.tryParse(quantityControllers[i].text),
          'unit': unitsController[i],
        };
        ingredientsTest.add(ingredientMap);
      }

      // insert ingredients into the 'recipe_ingredients' table in Supabase
      await supabase.from('recipe_ingredients').upsert(ingredientsTest);

      for (var i = 0; i < categoryControllers.length; i++) {
        // insert the categories into the 'categories' table in Supabase
        final category = categoryControllers[i].text;
        final Map<String, dynamic> catobj = {
          'name': category,
        };
        categoryTemp.add(catobj);
      }

      var catIDs = [];
      try {
        // insert the categories into the 'categories' table in Supabase
        final values = categoryTemp.map((e) => '${e['name']}');
        final dynamic res = await supabase
            .rpc('upsert_data', params: {'p_values': values.toList()});
        print("rpc response: $res");
        // catIDs = res.map((e) => e['category_id']).toList();
        catIDs = res;
        print('catIDs: $catIDs');
      } catch (e) {
        // if code is 23505, it means there is a duplicate entry, and we can ignore it and continue, otherwise rethrow the error
        if (e.toString().contains('23505')) {
          print('Duplicate entry');
        } else {
          rethrow;
        }
      }

      List<dynamic> categoriesTest = [];
      for (var i = 0; i < catIDs.length; i++) {
        final recipeId = response.first['recipe_id'] as String;
        final categoryId = catIDs[i]['category_id'] as String;
        Map<String, dynamic> categoryMap = {
          'recipe_id': recipeId,
          'category_id': categoryId,
        };
        categoriesTest.add(categoryMap);
      }

      // insert categories into the 'recipe_categories' table in Supabase
      await supabase.from('recipes_categories').upsert(categoriesTest);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Recipe saved successfully!')),
      );

      // Optionally, clear the form after submission
      // _formKey.currentState!.reset();
      // recipeNameController.clear();
      // subtitleController.clear();
      // descriptionController.clear();
      // instructionsController.clear();
      // caloriesController.clear();
      // timeController.clear();
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error saving recipe: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Picker Section
          // const Center(child: ImagePickerWidget()),
          Center(
            child: GestureDetector(
              onTap: _pickImage,
              child: _image != null
                  ? CircleAvatar(
                      radius: 90,
                      backgroundImage: FileImage(_image!),
                    )
                  : CircleAvatar(
                      radius: 50,
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.5),
                      child: const Icon(Icons.camera_alt, size: 30),
                    ),
            ),
          ),
          const SizedBox(height: 16.0),

          // Recipe Name
          TextFormField(
            controller: recipeNameController,
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
            controller: subtitleController,
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
            controller: descriptionController,
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
            controller: instructionsController,
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
                  controller: caloriesController,
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
                  controller: timeController,
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
          IngredientList(
            ingredientControllers: ingredientControllers,
            quantityControllers: quantityControllers,
            units: unitsController,
          ),

          // Categories Section
          Text(
            'Categories',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12.0),
          CategoryList(categoryControllers: categoryControllers),
          const SizedBox(height: 16.0),

          // Submit Button
          Center(
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate() && _image != null) {
                  await _saveRecipe(context);
                } else if (_image == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please add an image'),
                    ),
                  );
                } else {
                  // print('test img: ${const ImagePickerWidget.image}');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'Please fill all required fields & add an image'),
                    ),
                  );
                }
              },
              child: Text(
                'Save Recipe',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.brightness ==
                            Brightness.light
                        ? Colors.white
                        : Colors.black),
                // : Theme.of(context).colorScheme.onSecondary),
                // color:  Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
