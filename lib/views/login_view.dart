import 'package:flutter/material.dart';
import 'package:my_notes_app/constants/routes.dart';
import 'package:my_notes_app/services/auth/auth_exceptions.dart';
import 'package:my_notes_app/services/auth/auth_service.dart';

import 'dart:developer' as devtools show log;

import '../utilities/show-error-dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  static const routeName = '/login/';

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
        title: const Text("Login"),
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
            child: const Text("Log in"),
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                final userCredential = await AuthService.firebase().logIn(
                  email: email,
                  password: password,
                );
                final user = AuthService.firebase().currentUser;
                if (user?.isEmailVerified ?? false) {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(notesRoute, (route) => false);
                  devtools.log(userCredential.toString());
                } else {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      verifyEmailRoute, (route) => false);
                  devtools.log(userCredential.toString());
                }
              } on UserNotFoundAuthException {
                await showErrorDialog(
                  context,
                  "User not found",
                );
              } on WrongPasswordAuthException {
                await showErrorDialog(
                  context,
                  "Wrong password",
                );
              } on GenericAuthException {
                await showErrorDialog(
                  context,
                  'Authentication error',
                );
              }
            },
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(registerRoute, (route) => false);
            },
            child: const Text('Haven\'t registered yet? Register here!'),
          ),
        ],
      ),
    );
  }
}
