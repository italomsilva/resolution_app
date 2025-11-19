import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resolution_app/dto/problem/get_home_problems_response.dart';
import 'package:resolution_app/presentation/commom_widgets/my_container_problem_status.dart';
import 'package:resolution_app/presentation/commom_widgets/my_error_widget.dart';
import 'package:resolution_app/presentation/commom_widgets/my_loading_widget.dart';
import 'package:resolution_app/presentation/problems/controllers/home_problems_controller.dart';

class HomeProblemsPage extends StatefulWidget {
  const HomeProblemsPage({super.key});

  @override
  State<HomeProblemsPage> createState() => _HomeProblemsPageState();
}

class _HomeProblemsPageState extends State<HomeProblemsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<HomeProblemsController>(
        context,
        listen: false,
      ).fetchProblems();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Consumer<HomeProblemsController>(
      builder: (context, controller, child) {
        final List<GetHomeProblemsResponseDto> displayList =
            controller.filteredProblems;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(controller.isSearching ? Icons.close : Icons.search),
              onPressed: () {
                setState(() {
                  controller.toggleSearching();
                });
              },
            ),
            title: controller.isSearching
                ? TextField(
                    controller: controller.searchController,
                    autofocus: true,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0),
                      filled: false,
                      hintText: 'Pesquisar problemas...',
                      prefixIcon: Icon(Icons.search),
                    ),
                    style: TextStyle(fontSize: 18),
                  )
                : Text(
                    'Problemas',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
            centerTitle: false,
            actions: [
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: controller.isLoading
                    ? null
                    : () {
                        controller.fetchProblems();
                      },
              ),
            ],
          ),
          body: Consumer<HomeProblemsController>(
            builder: (context, controller, child) {
              if (controller.isLoading) {
                return MyLoadingWidget();
              } else if (controller.errorMessage != null) {
                return MyErrorWidget(
                  baseMessage: "Erro ao encontrar problemas",
                  specificError: controller.errorMessage,
                  redirectPath: "/login",
                  buttonText: "Voltar ao Login",
                );
              } else if (controller.problems.isEmpty) {
                return MyErrorWidget(baseMessage: "Nenhum Problema Encontrado");
              } else {
                return ListView.builder(
                  itemCount: displayList.length,
                  itemBuilder: (context, index) {
                    final GetHomeProblemsResponseDto problem =
                        displayList[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: InkWell(
                        splashColor: theme.splashColor,
                        onTap: () {
                          controller.handleProblemCard(context, problem.id);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                problem.title,
                                style: TextStyle(
                                  color: theme.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Row(
                                children: [
                                  Icon(
                                    Icons.person,
                                    size: 16,
                                    color: theme.primaryColorDark,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    problem.userLogin,
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: theme.primaryColorDark,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.lightbulb_outline,
                                    size: 16,
                                    color: Colors.grey.shade700,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${problem.solutionsCount} soluções',
                                    style: theme.textTheme.bodySmall,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                problem.description,
                                style: theme.textTheme.bodyMedium,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
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
                                  Expanded(
                                    child: Text(
                                      problem.location,
                                      style: theme.textTheme.bodySmall,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  MyContainerProblemStatus(
                                    problemStatus: problem.status,
                                  ),
                                  Text(
                                    'Criado em: ${problem.createdAt.toLocal().toString().split(' ')[0]}',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        );
      },
    );
  }
}
