import 'package:flutter/material.dart';
import 'package:resolution_app/dto/solution/update_solution_request_dto.dart';
import 'package:resolution_app/models/solution.dart';
import 'package:resolution_app/presentation/auth/controllers/auth_controller.dart';
import 'package:resolution_app/repositories/solution_repository.dart';

class EditSolutionController extends ChangeNotifier {
  final AuthController _authController;
  final SolutionRepository _solutionRepository;
  EditSolutionController(this._authController, this._solutionRepository);

  Solution? _solution;
  Solution? get solution => _solution;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setLoading(bool value) {
    _isLoading = value;
    initControllers();
    notifyListeners();
  }

  bool _isLoadingSubmit = false;
  bool get isLoadingSubmit => _isLoadingSubmit;
  void setLoadingSubmit(bool value) {
    _isLoadingSubmit = value;
    notifyListeners();
  }

  void fetchSolution(String solutionId) async {
    setLoading(true);
    try {
      final fetchedSolution = await _solutionRepository.fetchSolutionById(
        solutionId,
      );
      _solution = fetchedSolution;
      notifyListeners();
    } catch (e) {
      print(e);
    } finally {
      setLoading(false);
    }
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController estimatedCostController = TextEditingController();

  Future<bool> handleDelete(String solutionId) async {
    final sucess = await this._solutionRepository.deleteSolution(
      _authController.currentUser!.token,
      solutionId,
    );
    return sucess;
  }

  void initControllers() {
    titleController.text = solution?.title ?? "";
    descriptionController.text = solution?.description ?? "";
    estimatedCostController.text =
        solution?.estimatedCost.toStringAsFixed(2) ?? "";
    notifyListeners();
  }

  void clearForm() {
    titleController.clear();
    descriptionController.clear();
    estimatedCostController.clear();
  }

  Future<bool> handleSubmit() async {
    String titleInput = titleController.text;
    String descriptionInput = descriptionController.text;
    String estimatedCostInput = estimatedCostController.text;
    UpdateSolutionRequestDto updateRequest = UpdateSolutionRequestDto(
      id: solution!.id,
    );
    if (titleController.text != solution!.title ||
        titleController.text.isNotEmpty) {
      updateRequest.title = titleController.text;
    }
    if (descriptionController.text != solution!.description ||
        descriptionController.text.isNotEmpty) {
      updateRequest.description = descriptionController.text;
    }
    if (estimatedCostController.text != solution!.estimatedCost) {
      updateRequest.estimatedCost = double.parse(estimatedCostInput);
    }

    final bool sucess = await this._solutionRepository.updateSolution(
      _authController.currentUser!.token,
      updateRequest,
    );
    return sucess;
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
