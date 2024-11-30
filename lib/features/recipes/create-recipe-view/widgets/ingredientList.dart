import 'package:flutter/material.dart';

class IngredientList extends StatefulWidget {
  IngredientList({
    super.key,
    required this.ingredientControllers,
    required this.quantityControllers,
    required this.units,
  });

  List<TextEditingController> ingredientControllers;
  List<TextEditingController> quantityControllers;
  Map<int, String> units;

  @override
  _IngredientListState createState() => _IngredientListState();
}

class _IngredientListState extends State<IngredientList> {
  List<Widget> ingredients = [];
  Color? primaryColor;

  @override
  void initState() {
    super.initState();
    widget.ingredientControllers.add(TextEditingController());
    widget.quantityControllers.add(TextEditingController());
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
              child: TextFormField(
                controller: widget.ingredientControllers.last,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an ingredient';
                  }
                  return null;
                },
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
                        widget.ingredientControllers.removeLast();
                        widget.units
                            .remove(widget.quantityControllers.length - 1);
                        widget.quantityControllers.removeLast();
                      });
                    },
                  )
                : const SizedBox.shrink(),
            IconButton(
              icon: Icon(Icons.add, color: primaryColor),
              onPressed: () {
                setState(() {
                  widget.ingredientControllers.add(TextEditingController());
                  widget.quantityControllers.add(TextEditingController());
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
                controller: widget.quantityControllers.last,
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
                onChanged: (value) {
                  // widget.units.add(value!);
                  widget.units
                      .addAll({widget.quantityControllers.length - 1: value!});
                },
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
