import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_notes_app/constants/routes.dart';
import 'package:my_notes_app/views/NotesView.dart';

import 'views/RegisterView.dart';
import 'views/LoginView.dart';
import 'views/VerifyEmailView.dart';

import '../firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: {
        // RegisterView.routeName: (context) => const RegisterView(),
        // LoginView.routeName: (context) => LoginView(),
        // NotesView.routeName: (context) => NotesView(),
        loginRoute: ((context) => const LoginView()),
        registerRoute: ((context) => const RegisterView()),
        notesRoute: ((context) => const NotesView()),
        verifyEmailRoute: ((context) => const VerifyEmailView()),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              if (user.emailVerified) {
                return const NotesView();
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
            }

          default:
            return CircularProgressIndicator();
        }
      },
    );
  }
}
