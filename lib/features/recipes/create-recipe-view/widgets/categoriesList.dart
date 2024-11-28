import 'package:flutter/material.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  List<Widget> categories = [];
  Color? primaryColor;

  @override
  void initState() {
    super.initState();
    categories.add(buildCategoryRow());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize styling dependent on Theme.of(context)
    primaryColor = Theme.of(context).colorScheme.primary;
  }

  Widget buildCategoryRow() {
    return Column(
      children: [
        Row(
          key: UniqueKey(),
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                items: ['Dessert', 'Snack', 'Main Course'].map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (value) {},
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            categories.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        categories.removeLast();
                      });
                    },
                  )
                : const SizedBox.shrink(),
            IconButton(
              icon: Icon(Icons.add, color: primaryColor),
              onPressed: () {
                setState(() {
                  categories.add(buildCategoryRow());
                });
              },
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
      children: categories,
    );
  }
}
