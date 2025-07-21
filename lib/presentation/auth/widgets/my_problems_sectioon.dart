import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resolution_app/models/problems.dart';
import 'package:resolution_app/presentation/auth/controllers/my_profile_controller.dart';
import 'package:resolution_app/presentation/auth/widgets/donut_chart.dart';
import 'package:resolution_app/presentation/auth/widgets/indicator_graph.dart';
import 'package:resolution_app/presentation/commom_widgets/MyFormButton.dart';
import 'package:resolution_app/presentation/commom_widgets/my_container_problem_status.dart';

class MyProblemsSection extends StatefulWidget {
  const MyProblemsSection({super.key});

  @override
  State<MyProblemsSection> createState() => _MyProblemsSectioonState();
}

class _MyProblemsSectioonState extends State<MyProblemsSection> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyProfileController>(
      builder: (context, controller, child) {
        final theme = Theme.of(context);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Estatísticas de Problemas",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Card(
                  elevation: 3.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 120,
                              width: 120,
                              child: ProblemStatusDonutChart(
                                data: controller.dataProblem,
                                centerText: '55',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 12.0,
                                runSpacing: 8.0,
                                children: controller.dataProblem.map((
                                  dataItem,
                                ) {
                                  return IndicatorGraph(
                                    color: dataItem.color,
                                    text: dataItem.status.textValue,
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                controller.seeProblems == false
                    ? MyFormButton(
                        text: "Ver meus Problemas",
                        onPressed: controller.handleSeeProblems,
                        isLoading: controller.problemsLoading,
                      )
                    : const SizedBox(height: 0),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.problems?.length,
                  itemBuilder: (context, index) {
                    final Problem? problem = controller.problems?[index];
                    if (problem == null) {
                      return null;
                    }
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    problem.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: theme.textTheme.titleMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: controller.deleteProblem,
                                  icon: Icon(Icons.delete_forever),
                                  color: theme.colorScheme.error,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                MyContainerProblemStatus(
                                  problemStatus: problem.status,
                                ),
                                Text(
                                  problem.createdAt
                                      .toLocal()
                                      .toString()
                                      .split(' ')[0],
                                  style: theme.textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
