import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.onFieldSubmitted,
    required this.searchController,
  });

  final TextEditingController searchController;
  final Function(String) onFieldSubmitted;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.searchController,
      textInputAction: TextInputAction.search,
      // onFieldSubmitted: (value) {
      //   viewModel.searchRecipes(value);
      // },
      onFieldSubmitted: widget.onFieldSubmitted,
      onChanged: (value) {
        if (value.isEmpty) {
          setState(() {
            widget.searchController.clear();
          });
        }
      },
      decoration: InputDecoration(
        hintText: 'Search for recipes',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: widget.searchController.text.isNotEmpty
            ? const Icon(Icons.clear)
            : null,
      ),
    );
  }
}
