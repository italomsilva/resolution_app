import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:resolution_app/models/solution.dart';
import 'package:resolution_app/presentation/commom_widgets/MyFormButton.dart';
import 'package:resolution_app/presentation/commom_widgets/my_confirm_action.dart';
import 'package:resolution_app/presentation/commom_widgets/my_error_widget.dart';
import 'package:resolution_app/presentation/solutions/controllers/edit_solution_controller.dart';

class EditSolutionPage extends StatefulWidget {
  @override
  State<EditSolutionPage> createState() => _EditSolutionPageState();
}

class _EditSolutionPageState extends State<EditSolutionPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EditSolutionController>(
      builder: (context, controller, child) {
        if (controller.solution != null) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Editar Solução'),
              actions: [
                IconButton(
                  onPressed: controller.clearForm,
                  icon: Icon(Icons.cleaning_services_rounded),
                ),
                IconButton(
                  onPressed: () async {
                    final bool confirmDelete = await myConfirmActionMessage(
                      context,
                      "Deletar Solução?",
                      "Deseja ralmente excluir esta solução?",
                      "cancelar",
                      "confirmar",
                    );
                    if (confirmDelete) {
                      bool isDeleted = await controller.handleDelete(
                        controller.solution?.id ?? "",
                      );
                      if (isDeleted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Problema deletado com sucesso"),
                          ),
                        );
                        context.pop();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Erro ao deletar. Faça login novamente",
                            ),
                          ),
                        );
                      }
                    }
                  },
                  icon: Icon(Icons.delete),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(label: Text('Titulo')),
                      maxLines: null,
                      controller: controller.titleController,
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(label: Text('Titulo')),
                      maxLines: null,
                      controller: controller.descriptionController,
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(label: Text('Titulo')),
                      controller: controller.estimatedCostController,
                      validator: controller.validateEstimatedCost,
                    ),
                    SizedBox(height: 16),
                    MyFormButton(
                      text: 'Salvar',
                      isLoading: controller.isLoadingSubmit,
                      onPressed: () async {
                        if (!controller.formKey.currentState!.validate()) {
                          return;
                        }

                        bool sucess = await controller.handleSubmit();
                        if (sucess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Alterações salvas")),
                          );
                          context.pop();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Erro ao alterar. Faça login novamente",
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return MyErrorWidget(
          baseMessage: "Erro, tente novamente",
          buttonText: 'Voltar',
          redirectPath: '/problems',
        );
      },
    );
  }
}
