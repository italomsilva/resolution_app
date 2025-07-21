import 'package:flutter/material.dart';
import 'package:resolution_app/models/enums/problem_status.dart';

class MyContainerProblemStatus extends StatelessWidget {
  final ProblemStatus problemStatus;
  const MyContainerProblemStatus({super.key, required this.problemStatus});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: _getStatusColor(problemStatus),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Text(
        problemStatus.textValue,
        style: TextStyle(
          color: _getStatusTextColor(problemStatus),
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Color _getStatusColor(ProblemStatus status) {
    switch (status) {
      case ProblemStatus.open:
        return Colors.blue.shade100;
      case ProblemStatus.inProgress:
        return Colors.orange.shade100;
      case ProblemStatus.resolved:
        return Colors.green.shade100;
      case ProblemStatus.canceled:
        return Colors.red.shade100;
    }
  }

  Color _getStatusTextColor(ProblemStatus status) {
    switch (status) {
      case ProblemStatus.open:
        return Colors.blue.shade700;
      case ProblemStatus.inProgress:
        return Colors.orange.shade700;
      case ProblemStatus.resolved:
        return Colors.green.shade700;
      case ProblemStatus.canceled:
        return Colors.red.shade700;
    }
  }
}
