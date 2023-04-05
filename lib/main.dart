import 'package:flutter/material.dart';
import 'package:login_codelab/view_model/LoginViewModel.dart';
import 'package:provider/provider.dart';

import 'color_scheme.g.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Demo',
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => LoginViewModel(),
      child: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/login_bg.jpg'),
                fit: BoxFit.cover),
          ),
          child: const Scaffold(
              backgroundColor: Colors.transparent,
              body: SafeArea(
                child: LoginForm(),
              ))),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  void showLoginDialog(BuildContext context, bool success) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                success ? const Text("Success") : const Text("Fail"),
                const SizedBox(height: 8),
                FilledButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("close"),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<LoginViewModel>(context); // <-- 요기
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Spacer(),
            const Text(
              'Login을 해봅시다!!!',
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Woodshop'),
            ),
            const Spacer(),
            TextFormField(
              enabled: !viewModel.inProgress,
              controller: viewModel.idController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.account_circle),
                suffixIcon: viewModel.id.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          viewModel.idController.clear();
                        },
                        icon: const Icon(Icons.delete))
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(35),
                ),
                hintText: "User name",
                hintStyle: const TextStyle(fontSize: 14),
                contentPadding: const EdgeInsets.all(10),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              enabled: !viewModel.inProgress,
              controller: viewModel.passwordController,
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.password),
                suffixIcon: viewModel.password.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          viewModel.passwordController.clear();
                        },
                        icon: const Icon(Icons.delete))
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(35),
                ),
                hintText: "Password",
                hintStyle: const TextStyle(fontSize: 14),
                contentPadding: const EdgeInsets.all(10),
              ),
            ),
            const SizedBox(
              height: 36,
            ),
            FractionallySizedBox(
              widthFactor: 1,
              child: FilledButton(
                onPressed:
                    (viewModel.id.isNotEmpty && viewModel.password.isNotEmpty)
                        ? () async {
                            // showLoginDialog(context, await viewModel.login());

                            final isSuccess = await viewModel.login();
                            if (context.mounted) {
                              showLoginDialog(context, isSuccess);
                            }
                          }
                        : null,
                child: (viewModel.inProgress)
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text("Login"),
              ),
            ),
            const Spacer(),
            FilledButton(
              onPressed: () {},
              child: const Text(
                'Create an account.',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
