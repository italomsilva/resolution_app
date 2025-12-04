import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:resolution_app/app_theme.dart';
import 'package:resolution_app/dto/problem/stats_count_problem_status_response.dart';

class ProblemStatusDonutChart extends StatefulWidget {
  final List<StatsCountProblemStatusResponse> data;
  final String centerText;
  final TextStyle? centerTextStyle;

  const ProblemStatusDonutChart({
    super.key,
    required this.data,
    required this.centerText,
    this.centerTextStyle,
  });

  @override
  State<ProblemStatusDonutChart> createState() =>
      _ProblemStatusDonutChartState();
}

class _ProblemStatusDonutChartState extends State<ProblemStatusDonutChart> {
  int _touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (widget.data.isEmpty) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          Center(
            child: Text(
              "Sem dados",
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.grey.shade500,
              ),
            ),
          ),
        ],
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest.shortestSide;

        return Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: size,
              height: size,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          _touchedIndex = -1;
                          return;
                        }
                        _touchedIndex = pieTouchResponse
                            .touchedSection!
                            .touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 2,
                  centerSpaceRadius: size * 0.2, // central "furo"
                  sections: _buildChartSections(context, size),
                ),
              ),
            ),
            Text(
              widget.centerText,
              style: widget.centerTextStyle ??
                  theme.textTheme.bodyLarge?.copyWith(
                    fontSize: size * 0.2, // Tamanho proporcional
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
            ),
          ],
        );
      },
    );
  }

  List<PieChartSectionData> _buildChartSections(
      BuildContext context, double size) {
    final totalValue =
        widget.data.fold(0.0, (sum, item) => sum + item.count);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return List.generate(widget.data.length, (i) {
      final isTouched = i == _touchedIndex;
      final double radius = isTouched ? size * 0.35 : size * 0.30;
      final double fontSize = isTouched ? size * 0.12 : size * 0.09;

      final dataItem = widget.data[i];

      return PieChartSectionData(
        color: dataItem.color,
        value: dataItem.count.toDouble(),
        title: dataItem.count.toString(),
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: dataItem.color == AppTheme.neutralColor && !isDark
              ? const Color.fromARGB(117, 0, 0, 0)
              : AppTheme.whiteColor,
        ),
      );
    });
  }
}
