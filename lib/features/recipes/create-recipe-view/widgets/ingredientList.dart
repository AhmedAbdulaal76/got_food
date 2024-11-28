import 'package:flutter/material.dart';

class IngredientList extends StatefulWidget {
  const IngredientList({super.key});

  @override
  _IngredientListState createState() => _IngredientListState();
}

class _IngredientListState extends State<IngredientList> {
  List<Widget> ingredients = [];
  Color? primaryColor;

  @override
  void initState() {
    super.initState();
    ingredients.add(buildIngredientRow());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize styling dependent on Theme.of(context)
    primaryColor = Theme.of(context).colorScheme.primary;
  }

  Widget buildIngredientRow() {
    return Column(
      children: [
        Row(
          key: UniqueKey(),
          children: [
            Expanded(
              flex: 2,
              child: DropdownButtonFormField<String>(
                items: ['Sugar', 'Flour', 'Butter'].map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (value) {},
                decoration: const InputDecoration(
                  labelText: 'Ingredient',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            ingredients.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        ingredients.removeLast();
                      });
                    },
                  )
                : const SizedBox.shrink(),
            IconButton(
              icon: Icon(Icons.add, color: primaryColor),
              onPressed: () {
                setState(() {
                  ingredients.add(buildIngredientRow());
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Quantity',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              flex: 1,
              child: DropdownButtonFormField<String>(
                items: ['grams', 'cups', 'tablespoons'].map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (value) {},
                decoration: const InputDecoration(
                  labelText: 'Unit',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: ingredients,
    );
  }
}
