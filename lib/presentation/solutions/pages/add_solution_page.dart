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
    return Scaffold(
      appBar: AppBar(title: Text("Propor Solução")),
      body: Consumer<AddSolutionController>(
        builder: (context, controller, child) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              TextFormField(
                controller: controller.titleController,
                decoration: InputDecoration(labelText: "Titulo"),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: controller.descriptionController,
                decoration: InputDecoration(labelText: "Descrição"),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: controller.estimatedCostController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9,]+')),
                ],
                decoration: InputDecoration(labelText: "Custo estimado"),
              ),
              SizedBox(height: 16),
              MyFormButton(
                text: "Salvar",
                onPressed: (){
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
  }
}
