import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:resolution_app/presentation/auth/controllers/auth_controller.dart';
import 'package:resolution_app/repositories/problem_repository.dart';

class AddProblemController extends ChangeNotifier {
  final ProblemRepository _problemRepository;
  final AuthController _authController;
  AddProblemController(this._problemRepository, this._authController);

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  String? validateTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Preencha este campo';
    }

    return null;
  }

  String? validateDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Preencha este campo';
    }

    return null;
  }

  String? validateLocation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Preencha este campo';
    }

    return null;
  }

  Future<bool> handleCreate(BuildContext context) async {
    setLoading(true);
    final createProblem = await _problemRepository.createProblem(
      _authController.currentUser!.token,
      titleController.text,
      descriptionController.text,
      locationController.text,
    );
    setLoading(false);
    return createProblem;
  }

  void clearForm() {
    titleController.clear();
    descriptionController.clear();
    locationController.clear();
    notifyListeners();
  }
}
