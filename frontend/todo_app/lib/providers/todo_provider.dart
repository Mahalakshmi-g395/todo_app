import 'package:flutter/foundation.dart';
import '../models/todo.dart';
import '../services/api_service.dart';

class TodoProvider with ChangeNotifier {
  List<Todo> _todos = [];
  bool _isLoading = false;
  String? _error;

  List<Todo> get todos => _todos;
  bool get isLoading => _isLoading;
  String? get error => _error;

  List<Todo> get completedTodos => _todos.where((todo) => todo.completed).toList();
  List<Todo> get pendingTodos => _todos.where((todo) => !todo.completed).toList();

  Future<void> fetchTodos() async {
    _setLoading(true);
    try {
      _todos = await ApiService.getAllTodos();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> addTodo(String title, String description) async {
    _setLoading(true);
    try {
      final newTodo = Todo(title: title, description: description);
      final createdTodo = await ApiService.createTodo(newTodo);
      _todos.insert(0, createdTodo);
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updateTodo(Todo todo) async {
    _setLoading(true);
    try {
      final updatedTodo = await ApiService.updateTodo(todo);
      final index = _todos.indexWhere((t) => t.id == todo.id);
      if (index != -1) {
        _todos[index] = updatedTodo;
      }
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> deleteTodo(int id) async {
    _setLoading(true);
    try {
      await ApiService.deleteTodo(id);
      _todos.removeWhere((todo) => todo.id == id);
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> toggleTodoStatus(int id) async {
    try {
      final updatedTodo = await ApiService.toggleTodoStatus(id);
      final index = _todos.indexWhere((t) => t.id == id);
      if (index != -1) {
        _todos[index] = updatedTodo;
      }
      notifyListeners();
      _error = null;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}