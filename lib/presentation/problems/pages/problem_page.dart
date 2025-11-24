import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:resolution_app/models/enums/solution_reaction.dart';
import 'package:resolution_app/models/solution.dart';
import 'package:resolution_app/presentation/commom_widgets/MyFormButton.dart';
import 'package:resolution_app/presentation/commom_widgets/my_clickable_card.dart';
import 'package:resolution_app/presentation/commom_widgets/my_confirm_action.dart';
import 'package:resolution_app/presentation/commom_widgets/my_container_problem_status.dart';
import 'package:resolution_app/presentation/commom_widgets/my_error_widget.dart';
import 'package:resolution_app/presentation/commom_widgets/my_loading_widget.dart';
import 'package:resolution_app/presentation/problems/controllers/problem_controller.dart';

class ProblemPage extends StatefulWidget {
  final String problemId;
  const ProblemPage({super.key, required this.problemId});

  @override
  State<ProblemPage> createState() => _ProblemPageState();
}

class _ProblemPageState extends State<ProblemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Consumer<ProblemController>(
          builder: (context, controller, child) => IconButton(
            icon: Icon(Icons.keyboard_arrow_left),
            onPressed: () {
              if (!controller.isLoading && !controller.solutionsLoading) {
                context.pop();
              }
            },
          ),
        ),
        actions: [
          Consumer<ProblemController>(
            builder: (context, controller, child) =>
                controller.isMyProblem == true
                ? Row(
                    children: [
                      IconButton(icon: Icon(Icons.edit), onPressed: () { 
                        if (!controller.isLoading && !controller.solutionsLoading) {
                          context.push(
                            "/problem/${controller.problem?.id}/edit",
                          );
                        } 
                      },),
                      IconButton(
                        icon: Icon(Icons.delete),
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
                            controller.handleDeleteProblem;
                          }
                        },
                      ),
                    ],
                  )
                : Spacer(),
          ),
        ],
      ),
      body: Consumer<ProblemController>(
        builder: (context, controller, child) {
          final theme = Theme.of(context);
          if (controller.isLoading) {
            return MyLoadingWidget();
          } else if (controller.problem == null) {
            return MyErrorWidget(baseMessage: "Problema não encontrado");
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          size: 16,
                          color: theme.primaryColorDark,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          controller.problem!.userLogin,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.primaryColorDark,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.problem!.title,
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: theme.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          controller.problem!.description,
                          style: theme.textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 18,
                              color: Colors.grey.shade600,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              controller.problem!.location,
                              style: theme.textTheme.bodySmall,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Criado em: ${controller.problem!.createdAt.toLocal().toString().split(' ')[0]}',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.grey.shade700,
                              ),
                            ),
                            Spacer(),
                            MyContainerProblemStatus(
                              problemStatus: controller.problem!.status,
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        controller.isMyProblem
                            ? SizedBox()
                            : MyFormButton(
                                text: "Propor Solução",
                                onPressed: () {
                                  context.push(
                                    "/problem/${controller.problem?.id}/add-solution",
                                  );
                                },
                              ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Soluções Propostas",
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 16),
                    _buildSolutionsList(context, controller),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildSolutionsList(
    BuildContext context,
    ProblemController controller,
  ) {
    if (controller.solutionsLoading) {
      return MyLoadingWidget();
    } else {
      final solutions = controller.solutions;
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: controller.solutions.length ?? 0,
      itemBuilder: (context, index) {
        final solution = controller.solutions[index];
        if (solution == null) {
          return SizedBox();
        }
        final theme = Theme.of(context);
        return MyClickableCard(
          handleClick: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                textAlign: TextAlign.left,
                solution.userLogin,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.primaryColorDark,
                ),
              ),
              Text(
                solution.title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(solution.description),
              Row(
                children: [
                  Text(
                    "Custo estimado: ",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("R\$ ${solution.estimatedCost.toStringAsFixed(2)}"),
                ],
              ),
              Text(
                'Criado em: ${controller.problem!.createdAt.toLocal().toString().split(' ')[0]}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.grey.shade700,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      controller.reactSolution(
                        solution.id,
                        SolutionReaction.like,
                      );
                    },
                    icon: Icon(
                      solution.myReaction == SolutionReaction.like
                          ? Icons.thumb_up_alt
                          : Icons.thumb_up_alt_outlined,
                      color: theme.primaryColor,
                    ),
                  ),
                  Text(solution.likes.toString()),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      controller.reactSolution(
                        solution.id,
                        SolutionReaction.dislike,
                      );
                    },
                    icon: Icon(
                      solution.myReaction == SolutionReaction.dislike
                          ? Icons.thumb_down_alt
                          : Icons.thumb_down_alt_outlined,
                      color: theme.colorScheme.error,
                    ),
                  ),
                  Text(solution.dislikes.toString()),
                ],
              ),
              controller.isMyProblem
                  ? MyFormButton(text: "Aprovar Solução")
                  : SizedBox(),
            ],
          ),
        );
      },
    );
  }
}
