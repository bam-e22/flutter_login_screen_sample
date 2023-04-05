import 'package:flutter/cupertino.dart';

class LoginViewModel with ChangeNotifier {
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String id = "";
  String password = "";

  bool inProgress = false;

  LoginViewModel() {
    idController.addListener(() {
      id = idController.text;
      notifyListeners();
    });
    passwordController.addListener(() {
      password = passwordController.text;
      notifyListeners();
    });
  }

  Future<bool> login() async {
    inProgress = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 3));
    inProgress = false;
    notifyListeners();

    return id == 'aaa' && password == 'aaa';
  }
}
