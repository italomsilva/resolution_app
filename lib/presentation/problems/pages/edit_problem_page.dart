import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:resolution_app/models/enums/problem_status.dart';
import 'package:resolution_app/models/problems.dart';
import 'package:resolution_app/presentation/commom_widgets/MyFormButton.dart';
import 'package:resolution_app/presentation/problems/controllers/add_problem_controller.dart';
import 'package:resolution_app/presentation/problems/controllers/edit_problem_controller.dart';

class EditProblemPage extends StatefulWidget {
  const EditProblemPage({super.key});

  @override
  State<EditProblemPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<EditProblemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.keyboard_arrow_left),
        ),
        title: Text("Editar Problema"),
        centerTitle: false,
        actions: [
          Consumer<EditProblemController>(
            builder: (context, controller, child) {
              return IconButton(
                onPressed: controller.clearForm,
                icon: Icon(Icons.cleaning_services_rounded),
              );
            },
          ),
        ],
      ),
      body: Consumer<EditProblemController>(
        builder: (context, controller, child) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(24.0),
            child: Form(
              key: controller.formKey,
              child: Center(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Título'),
                      controller: controller.titleController,
                      validator: controller.validateTitle,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: controller.descriptionController,
                      validator: controller.validateDescription,
                      maxLines: null,
                      minLines: 3,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                        labelText: 'Descrição Detalhada',
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Endereço'),
                      controller: controller.locationController,
                      validator: controller.validateLocation,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Alterar Status do Problema",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    RadioGroup(
                      groupValue: controller.problemStatus,
                      onChanged: controller.changeProblemStatus,
                      child: Column(
                        children: [
                          RadioListTile(
                            title: Text("Aberto"),
                            value: ProblemStatus.open,
                          ),
                          RadioListTile(
                            title: Text("Em Andamento"),
                            value: ProblemStatus.inProgress,
                          ),
                          RadioListTile(
                            title: Text("Resolvido"),
                            value: ProblemStatus.resolved,
                          ),
                          RadioListTile(
                            title: Text("Cancelado"),
                            value: ProblemStatus.canceled,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    MyFormButton(
                      text: "Salvar",
                      onPressed: () async {
                        if (!controller.formKey.currentState!.validate()) {
                          return;
                        }
                        final sucess = await controller.handleSubmit();
                        if (sucess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Problema atualizado com sucesso!"),
                            ),
                          );
                          context.pop();
                          context.pop();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Erro ao atualizar o problema."),
                            ),
                          );
                        }
                      },
                      isLoading: controller.isLoading,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
