import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:resolution_app/dto/problem/get_home_problems_response.dart';
import 'package:resolution_app/dto/problem/update_problem_request.dart';
import 'package:resolution_app/models/enums/problem_status.dart';
import 'package:resolution_app/presentation/auth/controllers/auth_controller.dart';
import 'package:resolution_app/repositories/problem_repository.dart';

class EditProblemController extends ChangeNotifier {
  final ProblemRepository _problemRepository;
  final AuthController _authController;
  EditProblemController(this._problemRepository, this._authController);

  GetHomeProblemsResponseDto? _problem;
  GetHomeProblemsResponseDto? get problem => _problem;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void fetchProblem(String problemId) async {
    try {
      final fetchedProblem = await _problemRepository.fetchProblemById(
        problemId,
      );
      _problem = fetchedProblem;
      initControllers();
      notifyListeners();
    } finally {
      setLoading(false);
    }

    notifyListeners();
  }

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  ProblemStatus _problemStatus = ProblemStatus.open;
  ProblemStatus get problemStatus => _problemStatus;

  void initControllers() {
    final problem = _problem;
    if (problem != null) {
      titleController.text = problem.title;
      descriptionController.text = problem.description;
      locationController.text = problem.location;
      _problemStatus = problem.status;
    }
    notifyListeners();
  }

  void changeProblemStatus(ProblemStatus? value) {
    if (value != null) {
      _problemStatus = value;
      notifyListeners();
    }
  }

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

  Future<bool> handleSubmit() async {
    setLoading(true);
    final problemUpdated = new UpdateProblemRequest(
      id: problem!.id,
      title: titleController.text,
      description: descriptionController.text,
      location: locationController.text,
      status: _problemStatus,
    );

    final updateProblem = await _problemRepository.updateProblem(
      _authController.currentUser!.token,
      problemUpdated,
    );
    setLoading(false);
    return updateProblem;
  }

  void clearForm() {
    titleController.clear();
    descriptionController.clear();
    locationController.clear();
    notifyListeners();
  }
}
