import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

class TimeSlider extends StatelessWidget {
  final double minTime;
  final double maxTime;
  final List<double> timeValues;
  final Function(int handlerIndex, dynamic lowerValue, dynamic upperValue)
      onChanged;

  const TimeSlider({
    super.key,
    required this.minTime,
    required this.maxTime,
    required this.timeValues,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Time',
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
        //     min: minTime,
        //     max: maxTime,
        //     values: timeValues,
        //     interval: 100,
        //     showLabels: true,
        //     onChanged: onChanged,
        //   ),
        // ),
        FlutterSlider(
          values: timeValues,
          min: minTime,
          max: maxTime,
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
              'Minimum: ${timeValues.first.toStringAsFixed(0)} mins',
              style: const TextStyle(fontSize: 14),
            ),
            Text(
              'Maximum: ${timeValues.last.toStringAsFixed(0)} mins',
              style: const TextStyle(fontSize: 14),
            ),
          ],
        )
      ],
    );
  }
}
