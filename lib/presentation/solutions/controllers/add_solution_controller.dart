import 'package:flutter/material.dart';
import 'package:resolution_app/repositories/solution_repository.dart';

class AddSolutionController extends ChangeNotifier {
  final SolutionRepository _solutionRepository;

  AddSolutionController(this._solutionRepository);

  bool _loadingSubmit = false;
  bool get loadingSubmit => _loadingSubmit;
  void setLoadingSubmit(bool value) {
    _loadingSubmit = value;
    notifyListeners();
  }

  final TextEditingController titleController = new TextEditingController();
  final TextEditingController descriptionController =
      new TextEditingController();
  final TextEditingController estimatedCostController =
      new TextEditingController();

  void handleSubmit() async {
    setLoadingSubmit(true);
    await Future.delayed(const Duration(milliseconds: 1500));
    setLoadingSubmit(false);
  }
}
