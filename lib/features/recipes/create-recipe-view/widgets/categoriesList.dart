import 'package:flutter/material.dart';

class CategoryList extends StatefulWidget {
  CategoryList({super.key, required this.categoryControllers});

  @override
  List<TextEditingController> categoryControllers;

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  List<Widget> categories = [];
  Color? primaryColor;

  @override
  void initState() {
    super.initState();
    widget.categoryControllers.add(TextEditingController());
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
              child: TextFormField(
                controller: widget.categoryControllers.last,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a category';
                  }
                  return null;
                },
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
                        widget.categoryControllers.removeLast();
                      });
                    },
                  )
                : const SizedBox.shrink(),
            IconButton(
              icon: Icon(Icons.add, color: primaryColor),
              onPressed: () {
                setState(() {
                  widget.categoryControllers.add(TextEditingController());
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
