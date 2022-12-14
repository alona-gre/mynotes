import 'package:flutter/material.dart';

import 'dart:developer' as devtools show log;

import 'package:my_notes_app/constants/routes.dart';
import 'package:my_notes_app/services/auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify email"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
              "We've sent you an email verification. Please open it to verify."),
          const Text(
              "If you haven't received an email yet, please tap the button below to re-send it"),
          TextButton(
            onPressed: () async {
              final user = AuthService.firebase().currentUser;
              await AuthService.firebase().sendEmailVerification();
              devtools.log(user.toString());
            },
            child: const Text("Send email verificaion"),
          ),
          TextButton(
            onPressed: () async {
              await AuthService.firebase().logOut();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(registerRoute, (route) => false);
            },
            child: const Text("Restart"),
          ),
        ],
      ),
    );
  }
}
