import 'package:flutter/material.dart';
import 'package:resolution_app/app_theme.dart';
import 'package:resolution_app/models/enums/problem_status.dart';

class ProblemStatusChartData {
  final ProblemStatus status;
  final int count;
  final Color color;

  ProblemStatusChartData({
    required this.status,
    required this.count,
    required this.color,
  });
}

List<ProblemStatusChartData> getMockProblemChartData() {
  return [
    ProblemStatusChartData(
      status: ProblemStatus.open,
      count: 9,
      color: AppTheme.lightTheme.primaryColorDark,
    ),
    ProblemStatusChartData(
      status: ProblemStatus.inProgress,
      count: 7,
      color: AppTheme.lightTheme.primaryColorLight,
    ),
    ProblemStatusChartData(
      status: ProblemStatus.resolved,
      count: 3,
      color: AppTheme.lightTheme.primaryColor,
    ),
    ProblemStatusChartData(
      status: ProblemStatus.canceled,
      count: 1,
      color: AppTheme.neutralColor,
    ),
  ];
}
