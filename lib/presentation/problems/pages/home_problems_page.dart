import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resolution_app/dtos/problems/get_home_problems_response.dart';
import 'package:resolution_app/presentation/problems/controllers/home_problems_controller.dart';
import 'package:resolution_app/models/enums/problem_status.dart';

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

  bool _isSearching = false;
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(_isSearching ? Icons.close : Icons.search),
          onPressed: () {
            setState(() {
              _isSearching = !_isSearching;
              if (!_isSearching) {
                _searchController.clear();
              }
            });
          },
        ),
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  filled: false,
                  hintText: 'Pesquisar problemas...',
                  prefixIcon: Icon(Icons.search),
                ),
                style: TextStyle(fontSize: 18),
              )
            : Text('Problemas', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: false,
        actions: [
          Consumer<HomeProblemsController>(
            builder: (context, controller, child) {
              return IconButton(
                icon: Icon(Icons.refresh),
                onPressed: controller.isLoading
                    ? null
                    : () {
                        controller.fetchProblems();
                        _searchController.clear();
                        _isSearching = false;
                      },
              );
            },
          ),
        ],
      ),
      body: Consumer<HomeProblemsController>(
        builder: (context, controller, child) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.errorMessage != null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, color: Colors.red, size: 50),
                    const SizedBox(height: 10),
                    Text(
                      controller.errorMessage!,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => controller.fetchProblems(),
                      child: const Text('Tentar Novamente'),
                    ),
                  ],
                ),
              ),
            );
          } else if (controller.problems.isEmpty) {
            return const Center(child: Text('Nenhum problema encontrado.'));
          } else {
            return ListView.builder(
              itemCount: controller.problems.length,
              itemBuilder: (context, index) {
                final GetHomeProblemsResponseDto problem =
                    controller.problems[index];
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
                      print("Idclicado");
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 4.0,
                                ),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(problem.status),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Text(
                                  problem.status.textValue,
                                  style: TextStyle(
                                    color: _getStatusTextColor(problem.status),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
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
