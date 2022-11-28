import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'dart:developer' as devtools show log;

import 'package:my_notes_app/constants/routes.dart';

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
                final userCredential =
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email,
                  password: password,
                );
                devtools.log(userCredential.toString());
              } on FirebaseAuthException catch (e) {
                if (e.code == "weak-password") {
                  devtools.log("too weak password");
                } else if (e.code == "email-already-in-use") {
                  devtools.log("email address is in use already");
                } else if (e.code == "invalid-email") {
                  devtools.log("email invalid");
                } else {
                  devtools.log(e.code);
                }
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
