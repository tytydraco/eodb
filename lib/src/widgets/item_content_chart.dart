import 'dart:math';

import 'package:eodb/src/model/content_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

/// A chart to display an item's compound or oil content.
class ItemContentChart extends StatefulWidget {
  /// Creates a new [ItemContentChart].
  const ItemContentChart({
    required this.contentModels,
    super.key,
  });

  /// The item content models.
  final List<ContentModel> contentModels;

  @override
  State<ItemContentChart> createState() => _ItemContentChartState();
}

class _ItemContentChartState extends State<ItemContentChart> {
  Color _colorByIndex({
    required int index,
    required double percentage,
    required double minPercentage,
    required double maxPercentage,
  }) {
    // If there's a single item, return Red.
    if (maxPercentage == minPercentage) {
      return const HSLColor.fromAHSL(1, 0, 1, 0.6).toColor();
    }

    final normalizedPercentage =
        (percentage - minPercentage) / (maxPercentage - minPercentage);
    final hue = (1 - normalizedPercentage) * 300;

    return HSLColor.fromAHSL(1, hue, 1, 0.6).toColor();
  }

  /// Returns a list of included percentages and the excluded percentage.
  (List<double>, double) _getPercentages() {
    final percentages = widget.contentModels
        .map((model) => model.percentage)
        .toList();

    // Consolidate percentages after the first 100.
    if (percentages.length > 100) {
      final includedPercentages = percentages.take(100).toList();
      final excludedPercentage = percentages
          .skip(100)
          .fold<double>(0, (a, b) => a + b);
      return (includedPercentages, excludedPercentage);
    } else {
      return (percentages, 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final percentages = widget.contentModels.map((model) => model.percentage);
    final maxPercentage = percentages.reduce(max);
    final minPercentage = percentages.reduce(min);

    final (includedPercentages, excludedPercentage) = _getPercentages();

    final sections =
        // Add the included percentages.
        includedPercentages
            .asMap()
            .entries
            .map(
              (entry) => PieChartSectionData(
                value: entry.value,
                showTitle: false,
                radius: 100,
                color: _colorByIndex(
                  index: entry.key,
                  percentage: entry.value,
                  minPercentage: minPercentage,
                  maxPercentage: maxPercentage,
                ),
              ),
            )
            .toList();

    // Add "Other" category if there is data to present.
    if (excludedPercentage != 0) {
      sections.add(
        PieChartSectionData(
          value: excludedPercentage,
          showTitle: false,
          radius: 100,
          color: Colors.brown.shade900,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        width: 200,
        height: 200,
        child: PieChart(
          PieChartData(
            sections: sections,
            centerSpaceRadius: 0,
            sectionsSpace: 0,
            pieTouchData: PieTouchData(
              enabled: true,
            ),
          ),
        ),
      ),
    );
  }
}
