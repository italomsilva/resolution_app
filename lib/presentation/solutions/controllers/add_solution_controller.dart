import 'package:flutter/material.dart';
import 'package:resolution_app/dto/solution/create_solution_request_dto.dart';
import 'package:resolution_app/presentation/auth/controllers/auth_controller.dart';
import 'package:resolution_app/repositories/solution_repository.dart';

class AddSolutionController extends ChangeNotifier {
  final SolutionRepository _solutionRepository;
  final AuthController _authController;
  final String problemId;

  AddSolutionController(
    this._solutionRepository,
    this._authController,
    this.problemId,
  );

  bool _loadingSubmit = false;
  bool get loadingSubmit => _loadingSubmit;
  void setLoadingSubmit(bool value) {
    _loadingSubmit = value;
    notifyListeners();
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController estimatedCostController = TextEditingController();

  void handleSubmit() async {
    setLoadingSubmit(true);
    final requestData = new CreateSolutionRequestDto(
      title: titleController.text,
      description: descriptionController.text,
      estimatedCost: double.parse(estimatedCostController.text),
      problemId: problemId,
    );
    await _solutionRepository.createSolution(
      _authController.currentUser!.token,
      requestData,
    );
    setLoadingSubmit(false);
  }

  void clearForm() {
    titleController.clear();
    descriptionController.clear();
    estimatedCostController.clear();
  }

  String? validateEstimatedCost(String? value) {
    if (value == null || value.isEmpty) {
      return 'Preencha este campo';
    }
    final String trimmedValue = value.trim();
    final RegExp numericRegex = RegExp(r'^\d+(\.\d+)?$');
    if (!numericRegex.hasMatch(trimmedValue)) {
      return 'Formato inválido. Use apenas números e ponto (ex: 12.50).';
    }

    if (trimmedValue.startsWith('.') || trimmedValue.endsWith('.')) {
      return 'O valor deve começar e terminar com um dígito.';
    }
    return null;
  }
}
