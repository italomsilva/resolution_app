import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:resolution_app/app_theme.dart';
import 'package:resolution_app/dto/solution/get_solutions_reactions.dart';

class MyLineChart extends StatefulWidget {
  final List<StatsCountSolutionsReactionsResponse> data;

  const MyLineChart({super.key, required this.data});

  @override
  State<MyLineChart> createState() => _MyLineChartState();
}

class _MyLineChartState extends State<MyLineChart> {
  int touchedGroupIndex = -1;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final Color likesBarColor = theme.primaryColorDark;
    final Color dislikesBarColor = theme.colorScheme.error;

    if (widget.data.isEmpty) {
      return Center(
        child: Text(
          "Sem dados de soluções para o gráfico.",
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.error,
          ),
        ),
      );
    }
    final maxY = _calculateMaxY();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: AspectRatio(
            aspectRatio: 2,
            child: LineChart(
              LineChartData(
                minX: 0,
                maxX: (widget.data.length - 1).toDouble(),
                minY: 0,
                maxY: maxY,

                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(color: AppTheme.neutralColor, strokeWidth: 1);
                  },
                ),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: getLeftTitles,
                      interval: (maxY / 5).ceilToDouble() > 1
                          ? (maxY / 5).ceilToDouble()
                          : 1,
                    ),
                  ),
                ),
                lineTouchData: LineTouchData(
                  handleBuiltInTouches: true,
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipColor: (touchedSpot) => theme.primaryColor,
                    getTooltipItems: (spots) {
                      if (spots.isEmpty) return [];
                      final touchedSpot = spots.first;
                      final dataPoint = widget.data[touchedSpot.x.toInt()];
                      final String dateLabel =
                          '${dataPoint.createdAt.day.toString().padLeft(2, '0')}/'
                          '${dataPoint.createdAt.month.toString().padLeft(2, '0')}/'
                          '${dataPoint.createdAt.year.toString()}';

                      return [
                        LineTooltipItem(
                          '${dataPoint.solutionTitle}\n'
                          'Data: $dateLabel\n',
                          const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        LineTooltipItem(
                          'Likes: ${dataPoint.likes}\n'
                          'Dislikes: ${dataPoint.dislikes}',
                          const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ];
                    },
                  ),
                  getTouchedSpotIndicator: (barData, spotIndexes) {
                    return spotIndexes.map((spotIndex) {
                      return TouchedSpotIndicatorData(
                        FlLine(color: AppTheme.neutralColor, strokeWidth: 2),
                        FlDotData(
                          getDotPainter: (spot, percent, bar, index) {
                            return FlDotCirclePainter(
                              radius: 8,
                              color: bar.color ?? theme.primaryColor,
                              strokeWidth: 0,
                            );
                          },
                        ),
                      );
                    }).toList();
                  },
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: _buildLikesSpots(),
                    isCurved: false,
                    color: likesBarColor,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(show: true),
                    belowBarData: BarAreaData(show: false),
                  ),
                  LineChartBarData(
                    spots: _buildDislikesSpots(),
                    isCurved: false,
                    color: dislikesBarColor,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(show: true),
                    belowBarData: BarAreaData(show: false),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<FlSpot> _buildLikesSpots() {
    return List.generate(widget.data.length, (index) {
      return FlSpot(index.toDouble(), widget.data[index].likes.toDouble());
    });
  }

  List<FlSpot> _buildDislikesSpots() {
    return List.generate(widget.data.length, (index) {
      return FlSpot(index.toDouble(), widget.data[index].dislikes.toDouble());
    });
  }

  Widget getBottomTitles(double value, TitleMeta meta) {
    final index = value.toInt();
    if (index >= 0 && index < widget.data.length) {
      final DateTime createdAt = widget.data[index].createdAt;
      final String formattedDate =
          '${createdAt.day.toString().padLeft(2, '0')}/${createdAt.month.toString().padLeft(2, '0')}';

      return SideTitleWidget(
        meta: meta,
        space: 10,
        child: Text(
          formattedDate,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
          textAlign: TextAlign.center,
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget getLeftTitles(double value, TitleMeta meta) {
    if (value == 0) return const SizedBox.shrink();
    return SideTitleWidget(
      meta: meta,
      space: 10,
      child: Text(
        value.toInt().toString(),
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }

  double _calculateMaxY() {
    double maxY = 0;
    for (var item in widget.data) {
      if (item.likes > maxY) maxY = item.likes.toDouble();
      if (item.dislikes > maxY) maxY = item.dislikes.toDouble();
    }
    return (maxY * 1.2).ceilToDouble();
  }
}
