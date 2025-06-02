// Placeholder for Authentication Controller
import 'package:flutter/material.dart';
import '../services/mock_usuario_service.dart'; // Adjust path as needed
import '../models/usuario_models.dart';

class AuthController with ChangeNotifier {
  final MockUsuarioService _usuarioService = MockUsuarioService();
  Usuario? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  Usuario? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // In mock, password is not checked by the services
      _currentUser = await _usuarioService.login(email, password);
      _isLoading = false;
      if (_currentUser == null) {
        _errorMessage = 'Usuário ou senha inválidos.';
        notifyListeners();
        return false;
      }
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Erro ao fazer login: ${e.toString()}';
      notifyListeners();
      return false;
    }
  }

  Future<bool> cadastrarAluno(Aluno aluno, String password) async {
    // Add password handling if needed for mock
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      bool success = await _usuarioService.cadastrarAluno(aluno);
      _isLoading = false;
      if (!success) {
        _errorMessage = 'Erro ao cadastrar: E-mail já existe.';
        notifyListeners();
        return false;
      }
      // Optionally login after registration
      // _currentUser = aluno;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Erro ao cadastrar: ${e.toString()}';
      notifyListeners();
      return false;
    }
  }

  Future<bool> cadastrarEspecialista(Especialista especialista, String password) async {
    // Add password handling if needed for mock
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      bool success = await _usuarioService.cadastrarEspecialista(especialista);
      _isLoading = false;
      if (!success) {
        _errorMessage = 'Erro ao cadastrar: E-mail já existe.';
        notifyListeners();
        return false;
      }
      // Optionally login after registration
      // _currentUser = especialista;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Erro ao cadastrar: ${e.toString()}';
      notifyListeners();
      return false;
    }
  }


  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}

