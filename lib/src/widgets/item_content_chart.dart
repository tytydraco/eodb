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

  @override
  Widget build(BuildContext context) {
    final percentages = widget.contentModels.map((model) => model.percentage);
    final maxPercentage = percentages.reduce(max);
    final minPercentage = percentages.reduce(min);

    final sections = widget.contentModels
        .asMap()
        .entries
        .map(
          (entries) => PieChartSectionData(
            cornerRadius: 0,
            radius: 50,
            value: entries.value.percentage,
            showTitle: false,
            color: _colorByIndex(
              index: entries.key,
              percentage: entries.value.percentage,
              minPercentage: minPercentage,
              maxPercentage: maxPercentage,
            ),
          ),
        )
        .toList();

    return Padding(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        width: 200,
        height: 200,
        child: PieChart(
          PieChartData(
            sections: sections,
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
