// Filter bottom modal sheet to filter recipes based on subcategory and calories range

import 'package:flutter/material.dart';
import 'package:got_food/common/models/recipe.dart';
import 'package:got_food/features/search/search-view/searchViewModel.dart';
import 'package:provider/provider.dart';

import 'apply_filter_button.dart';
import 'calories_slider.dart';
import 'clear_filter_button.dart';
import 'filter_header.dart';
import 'time_slider.dart';

class Filter extends StatefulWidget {
  final Function(List<Recipe>, {bool isFilterApplied}) onApplyFilter;
  final bool isFilterApplied;

  const Filter({
    super.key,
    required this.onApplyFilter,
    required this.isFilterApplied,
  });

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  // late SfRangeValues caloriesValues;
  late List<double> caloriesValues;
  double minCalories = 0;
  double maxCalories = 2000;

  late List<double> timeValues;
  double minTime = 0;
  double maxTime = 500;

  @override
  void initState() {
    super.initState();
    caloriesValues = [
      minCalories,
      maxCalories
    ]; // Initialize calories range values (default to min & max)

    timeValues = [
      minTime,
      maxTime
    ]; // Initialize time range values (default to min & max)
  }

  void _submitFilter(SearchViewModel viewModel,
      {bool isFilterApplied = true}) async {
    viewModel.fetchFilteredRecipes(
      caloriesValues.first,
      caloriesValues.last,
      timeValues.first,
      timeValues.last,
    ); // Fetch filtered recipes based on selected criteria
    widget.onApplyFilter(viewModel.filteredRecipes,
        isFilterApplied:
            isFilterApplied); // Call onApplyFilter in the parent widget to update the recipes list
    Navigator.pop(context); // Close the filter page after applying the filter
  }

  void _clearFilter(SearchViewModel viewModel) {
    setState(() {
      caloriesValues = [minCalories, maxCalories];
      viewModel.setCaloriesValues = caloriesValues;
      timeValues = [minTime, maxTime];
      viewModel.setTimeValues = timeValues;
    });
    _submitFilter(viewModel,
        isFilterApplied: false); // Submit the cleared filter
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SearchViewModel>(context);

    // determine whether calories range values were set before or not, if not set default values (min & max)
    if (viewModel.caloriesValues != null) {
      caloriesValues = viewModel.caloriesValues!;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const FilterHeader(),
          const SizedBox(height: 16),
          CaloriesSlider(
            // Calories range slider
            minCalories: minCalories,
            maxCalories: maxCalories,
            caloriesValues: caloriesValues,
            onChanged:
                (int handlerIndex, dynamic lowerValue, dynamic upperValue) {
              setState(() {
                caloriesValues = [
                  lowerValue,
                  upperValue
                ]; // Update calories range values
                viewModel.setCaloriesValues =
                    caloriesValues; // Set calories range values in view model for future reference
              });
            },
          ),
          const SizedBox(height: 16),
          // Time range slider
          TimeSlider(
            minTime: 0,
            maxTime: 500,
            timeValues: timeValues,
            onChanged:
                (int handlerIndex, dynamic lowerValue, dynamic upperValue) {
              setState(() {
                timeValues = [
                  lowerValue,
                  upperValue
                ]; // Update time range values
                viewModel.setTimeValues =
                    timeValues; // Set time range values in view model for future reference
              });
            },
          ),
          const SizedBox(height: 32),
          ClearFilterButton(
              onTap: () => _clearFilter(viewModel)), // Clear filter button
          const SizedBox(height: 20),
          ApplyFilterButton(
              onPressed: () => _submitFilter(viewModel)), // Apply filter button
        ],
      ),
    );
  }
}
