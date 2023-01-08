import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as devtools show log;
import 'package:my_notes_app/constants/routes.dart';
import 'package:my_notes_app/services/auth/bloc/auth_bloc.dart';
import 'package:my_notes_app/services/auth/bloc/auth_event.dart';
import 'package:my_notes_app/services/auth/bloc/auth_state.dart';
import 'package:my_notes_app/services/auth/firebase_auth_provider.dart';
import 'package:my_notes_app/views/notes/notes_view.dart';

import 'views/register_view.dart';
import 'views/login_view.dart';
import 'views/verify_email_view.dart';
import 'views/notes/create_update_note_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(FirebaseAuthProvider()),
        child: const HomePage(),
      ),
      routes: {
        // RegisterView.routeName: (context) => const RegisterView(),
        // LoginView.routeName: (context) => LoginView(),
        // NotesView.routeName: (context) => NotesView(),
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        notesRoute: (context) => const NotesView(),
        verifyEmailRoute: (context) => const VerifyEmailView(),
        createOrUpdateNoteRoute: (context) => const CreateUpdateNoteView(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocBuilder<AuthBloc, AuthState>(
      builder: ((context, state) {
        if (state is AuthStateLoggedIn) {
          return const NotesView();
        }
        if (state is AuthStateNeedsVerififcation) {
          return const VerifyEmailView();
        }

        if (state is AuthStateLoggedOut) {
          return const LoginView();
        } else {
          return const Scaffold(
            body: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}
