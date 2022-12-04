import 'package:flutter/material.dart';

import 'package:my_notes_app/constants/routes.dart';
import 'package:my_notes_app/services/auth/auth_exceptions.dart';
import 'package:my_notes_app/services/auth/auth_service.dart';

import '../utilities/show-error-dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  static const routeName = '/register/';

  @override
  State<RegisterView> createState() => RegisterViewState();
}

class RegisterViewState extends State<RegisterView> {
  late TextEditingController _email;
  late TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration:
                const InputDecoration(hintText: "Enter your email address"),
          ),
          TextField(
            controller: _password,
            enableSuggestions: false,
            autocorrect: false,
            obscureText: true,
            decoration: const InputDecoration(hintText: "Enter your password"),
          ),
          TextButton(
            child: const Text("Register"),
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                await AuthService.firebase().createUser(
                  email: email,
                  password: password,
                );
                AuthService.firebase().currentUser;
                Navigator.of(context).pushNamed(verifyEmailRoute);
              } on WeakPasswordAuthException {
                await showErrorDialog(
                  context,
                  "Password is too weak",
                );
              } on EmailAlreadyInUseAuthException {
                await showErrorDialog(
                  context,
                  "This email address is already in use",
                );
              } on InvalidEmailAuthException {
                await showErrorDialog(
                  context,
                  "Invalid email address",
                );
              } on GenericAuthException {
                await showErrorDialog(
                  context,
                  "Failed to register",
                );
              }
            },
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(loginRoute, (route) => false);
              },
              child: Text('Already registered? Log in here!')),
        ],
      ),
    );
  }
}
