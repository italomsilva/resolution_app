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

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  String? validateTitle(String? value) {
    return null;
  }
  String? validateDescription(String? value) {
    return null;
  }
  String? validateLocation(String? value) {
    return null;
  }

  Future<void> handleCreate(BuildContext context) async {
    setLoading(true);
    final navshel = context
        .findAncestorWidgetOfExactType<StatefulNavigationShell>();
    await Future.delayed(Duration(seconds: 3));
    setLoading(false);
    navshel!.goBranch(0);
  }
}
