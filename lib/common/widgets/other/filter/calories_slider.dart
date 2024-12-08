import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

class CaloriesSlider extends StatelessWidget {
  final double minCalories;
  final double maxCalories;
  final List<double> caloriesValues;
  final Function(int handlerIndex, dynamic lowerValue, dynamic upperValue)
      onChanged;

  const CaloriesSlider({
    super.key,
    required this.minCalories,
    required this.maxCalories,
    required this.caloriesValues,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Calories',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        // SfRangeSliderTheme(
        //   data: SfRangeSliderThemeData(
        //     tooltipBackgroundColor: Theme.of(context).primaryColor,
        //     tooltipTextStyle: const TextStyle(fontSize: 14),
        //   ),
        //   child: SfRangeSlider(
        //     activeColor: Theme.of(context).primaryColor,
        //     enableTooltip: true,
        //     tooltipShape: const SfPaddleTooltipShape(),
        //     min: minCalories,
        //     max: maxCalories,
        //     values: caloriesValues,
        //     interval: 100,
        //     showLabels: true,
        //     onChanged: onChanged,
        //   ),
        // ),
        FlutterSlider(
          values: caloriesValues,
          min: minCalories,
          max: maxCalories,
          rangeSlider: true,
          trackBar: FlutterSliderTrackBar(
            activeTrackBarHeight: 5,
            activeTrackBar:
                BoxDecoration(color: Theme.of(context).colorScheme.primary),
          ),
          tooltip: FlutterSliderTooltip(
            textStyle: const TextStyle(fontSize: 14, color: Colors.white),
            boxStyle: FlutterSliderTooltipBox(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          onDragging: onChanged,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Minimum: ${caloriesValues.first.toStringAsFixed(0)} Kcal',
              style: const TextStyle(fontSize: 14),
            ),
            Text(
              'Maximum: ${caloriesValues.last.toStringAsFixed(0)} Kcal',
              style: const TextStyle(fontSize: 14),
            ),
          ],
        )
      ],
    );
  }
}
