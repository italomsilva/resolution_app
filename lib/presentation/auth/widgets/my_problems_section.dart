import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:resolution_app/models/problems.dart';
import 'package:resolution_app/presentation/auth/controllers/my_profile_controller.dart';
import 'package:resolution_app/presentation/auth/widgets/donut_chart.dart';
import 'package:resolution_app/presentation/auth/widgets/indicator_graph.dart';
import 'package:resolution_app/presentation/commom_widgets/MyFormButton.dart';
import 'package:resolution_app/presentation/commom_widgets/my_confirm_action.dart';
import 'package:resolution_app/presentation/commom_widgets/my_container_problem_status.dart';

class MyProblemsSection extends StatefulWidget {
  const MyProblemsSection({super.key});

  @override
  State<MyProblemsSection> createState() => _MyProblemsSectionState();
}

class _MyProblemsSectionState extends State<MyProblemsSection> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyProfileController>(
      builder: (context, controller, child) {
        final theme = Theme.of(context);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
                                data: controller.problemStats,
                                centerText: controller.problemStats.length
                                    .toString(),
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
                                children: controller.problemStats!.map((
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    problem.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: theme.textTheme.titleMedium
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        context.push(
                                          "/problem/${problem.id}/edit",
                                        );
                                      },
                                      icon: Icon(Icons.edit),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete_forever),
                                      color: theme.colorScheme.error,
                                      onPressed: () async {
                                        final Future<bool>
                                        confirmDelete = myConfirmActionMessage(
                                          context,
                                          "Confirmar exclusão",
                                          "Deseja realmente excluir este problema? Esta ação não pode ser desfeita",
                                          "Cancelar",
                                          "Deletar",
                                        );
                                        if (await confirmDelete) {
                                          final sucess = await controller
                                              .deleteProblem(problem.id);
                                          if (sucess) {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  "Problema deletado com sucesso!",
                                                ),
                                              ),
                                            );
                                            controller.handleSeeProblems();
                                            controller.loadProblemStats();
                                          } else {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  "Erro ao deletar o problema. Tente novamente mais tarde.",
                                                ),
                                              ),
                                            );
                                          }
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyContainerProblemStatus(
                                  problemStatus: problem.status,
                                ),
                                Text(
                                  problem.createdAt.toLocal().toString().split(
                                    ' ',
                                  )[0],
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
