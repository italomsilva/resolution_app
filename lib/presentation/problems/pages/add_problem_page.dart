import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:resolution_app/presentation/commom_widgets/MyFormButton.dart';
import 'package:resolution_app/presentation/problems/controllers/add_problem_controller.dart';

class AddProblemPage extends StatefulWidget {
  const AddProblemPage({super.key});

  @override
  State<AddProblemPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AddProblemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            final navShel = context
                .findAncestorWidgetOfExactType<StatefulNavigationShell>();
            if (navShel != null) {
              navShel.goBranch(0);
            }
          },
          icon: Icon(Icons.keyboard_arrow_left),
        ),
        title: Text("Adicionar Problema"),
        centerTitle: false,
        actions: [
          Consumer<AddProblemController>(
            builder: (context, controller, child) {
              return IconButton(
                onPressed: controller.clearForm,
                icon: Icon(Icons.cleaning_services_rounded),
              );
            },
          ),
        ],
      ),
      body: Consumer<AddProblemController>(
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
                        hintText:
                            'Digite aqui os detalhes completos do problema...',
                        alignLabelWithHint: true,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Endereço',
                        hintText: 'Ex: Número - Rua - Bairro - Cidade - Estado',
                      ),
                      controller: controller.locationController,
                      validator: controller.validateLocation,
                    ),
                    SizedBox(height: 20),
                    MyFormButton(
                      text: "Salvar",
                      onPressed: () async {
                        if (!controller.formKey.currentState!.validate()) {
                          return;
                        }
                        final sucess = await controller.handleCreate(context);
                        if (sucess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Problema criado com sucesso!"),
                            ),
                          );
                          controller.clearForm();
                          context.go('/problems');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Falha ao criar problema. Tente novamente.",
                              ),
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
