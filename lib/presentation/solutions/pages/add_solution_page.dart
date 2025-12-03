import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:resolution_app/presentation/commom_widgets/MyFormButton.dart';
import 'package:resolution_app/presentation/solutions/controllers/add_solution_controller.dart';

class AddSolutionPage extends StatefulWidget {
  const AddSolutionPage({super.key});

  @override
  State<AddSolutionPage> createState() => _AddSolutionPageState();
}

class _AddSolutionPageState extends State<AddSolutionPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AddSolutionController>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Propor Solução"),
            actions: [
              IconButton(
                onPressed: controller.clearForm,
                icon: Icon(Icons.cleaning_services_rounded),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.titleController,
                    validator: controller.validateField,
                    decoration: InputDecoration(labelText: "Titulo"),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: controller.descriptionController,
                    validator: controller.validateField,
                    decoration: InputDecoration(labelText: "Descrição"),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: controller.estimatedCostController,
                    validator: controller.validateEstimatedCost,
                    decoration: InputDecoration(labelText: "Custo estimado"),
                  ),
                  SizedBox(height: 16),
                  MyFormButton(
                    text: "Salvar",
                    onPressed: () {
                      if (!controller.formKey.currentState!.validate()) {
                        return;
                      }
                      controller.handleSubmit();
                      context.pop();
                    },
                    isLoading: controller.loadingSubmit,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
