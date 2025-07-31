import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:resolution_app/dto/solution/get_solutions_reactions.dart';
import 'package:resolution_app/presentation/auth/widgets/indicator_graph.dart';

class SolutionFeedbackBarChart extends StatefulWidget {
  final List<SolutionFeedbackChartData> data;

  const SolutionFeedbackBarChart({super.key, required this.data});

  @override
  State<SolutionFeedbackBarChart> createState() =>
      _SolutionFeedbackBarChartState();
}

class _SolutionFeedbackBarChartState extends State<SolutionFeedbackBarChart> {
  int touchedGroupIndex = -1;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (widget.data.isEmpty) {
      return Center(
        child: Text(
          "Sem dados de soluções para o gráfico.",
          style: theme.textTheme.bodyMedium?.copyWith(
            color: Colors.grey.shade500,
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
            aspectRatio: 1.5,
            child: BarChart(
              BarChartData(
                barTouchData: BarTouchData(
                  touchCallback: (FlTouchEvent event, barTouchResponse) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          barTouchResponse == null ||
                          barTouchResponse.spot == null) {
                        touchedGroupIndex = -1;
                        return;
                      }
                      touchedGroupIndex =
                          barTouchResponse.spot!.touchedBarGroupIndex;
                    });
                  },
                  handleBuiltInTouches: true,
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: getBottomTitles,
                      reservedSize: 60,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: getLeftTitles,
                      interval: maxY / 10 <= 10 ? 10 : maxY / 10,
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                barGroups: _buildBarGroups(),
                gridData: FlGridData(show: true, drawHorizontalLine: false),
                alignment: BarChartAlignment.spaceAround,
                maxY: maxY,
              ),
            ),
          ),
        ),
        Row(
          children: [
            IndicatorGraph(color: theme.primaryColor, text: 'Likes'),
            const SizedBox(width: 20),
            IndicatorGraph(color: theme.colorScheme.error, text: 'Dislikes'),
          ],
        ),
      ],
    );
  }

  List<BarChartGroupData> _buildBarGroups() {
    // Removidos parâmetros de cor
    final theme = Theme.of(context); // Pega o tema para cores internas
    final Color likesColor = theme.primaryColor;
    final Color dislikesColor = theme.colorScheme.error;

    return List.generate(widget.data.length, (index) {
      final item = widget.data[index];
      final isTouched = index == touchedGroupIndex;
      final double barWidth = isTouched ? 12 : 10;
      final double barRodRadius = 6;

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: item.likes.toDouble(),
            color: likesColor, // Usa cor local
            width: barWidth,
            borderRadius: BorderRadius.circular(barRodRadius),
          ),
          BarChartRodData(
            toY: item.dislikes.toDouble(),
            color: dislikesColor, // Usa cor local
            width: barWidth,
            borderRadius: BorderRadius.circular(barRodRadius),
          ),
        ],
        showingTooltipIndicators: isTouched ? [0, 1] : [],
      );
    });
  }

  // 💡 getBottomTitles para exibir "Recente" e "Antigo" nas extremidades
  Widget getBottomTitles(double value, TitleMeta meta) {
    final index = value.toInt();
    final int lastIndex = widget.data.length - 1; // Último índice da lista

    // // Se é o primeiro item (mais recente, à esquerda)
    // if (index == 0) {
    //   return SideTitleWidget(
    //     meta: meta,
    //     space: 10,
    //     child: Text(
    //       '${widget.data[index].createdAt.day.toString().padLeft(2, '0')}/${widget.data[index].createdAt.month.toString().padLeft(2, '0')}',
    //       style: Theme.of(context).textTheme.bodySmall?.copyWith(
    //         color: Theme.of(context).colorScheme.onSurface,
    //         fontWeight: FontWeight.bold,
    //       ),
    //       textAlign: TextAlign.center,
    //     ),
    //   );
    // }
    // // Se é o último item (mais antigo, à direita)
    // else if (index == lastIndex) {
    //   return SideTitleWidget(
    //     meta: meta,
    //     space: 10,
    //     child: Text(
    //       '${widget.data[index].createdAt.day.toString().padLeft(2, '0')}/${widget.data[index].createdAt.month.toString().padLeft(2, '0')}',
    //       style: Theme.of(context).textTheme.bodySmall?.copyWith(
    //         color: Theme.of(context).colorScheme.onSurface,
    //         fontWeight: FontWeight.bold,
    //       ),
    //       textAlign: TextAlign.center,
    //     ),
    //   );
    // }
    // // Para todos os outros itens, não exibe nada
    return SideTitleWidget(
      meta: meta,
      space: 10,
      child: Text(
        '${widget.data[index].createdAt.day.toString().padLeft(2, '0')}/${widget.data[index].createdAt.month.toString().padLeft(2, '0')}',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
          fontWeight: FontWeight.bold,
          fontSize: 8,
        ),
        textAlign: TextAlign.center,
      ),
    );
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
