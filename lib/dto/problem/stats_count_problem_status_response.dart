import 'package:flutter/material.dart';
import 'package:resolution_app/app_theme.dart';
import 'package:resolution_app/models/enums/problem_status.dart';

class StatsCountProblemStatusResponse {
  final ProblemStatus status;
  final int count;
  final Color color;

  StatsCountProblemStatusResponse({
    required this.status,
    required this.count,
    required this.color,
  });

  factory StatsCountProblemStatusResponse.fromJson(Map<String, dynamic> json) {
    final ProblemStatus problemStatus = ProblemStatus.fromInt(
      json['status'] as int,
    );
    Color colorChart;
    switch (problemStatus) {
      case ProblemStatus.open:
        colorChart = AppTheme.lightTheme.primaryColorDark;
      case ProblemStatus.inProgress:
        colorChart = AppTheme.lightTheme.primaryColorLight;
      case ProblemStatus.resolved:
        colorChart = AppTheme.lightTheme.primaryColor;
      case ProblemStatus.canceled:
        colorChart = AppTheme.neutralColor;
        break;
    }
    return StatsCountProblemStatusResponse(
      status: problemStatus,
      count: json['count'] as int,
      color: colorChart,
    );
  }
}
