import 'package:bloc/bloc.dart';
import 'package:my_notes_app/services/auth/bloc/auth_event.dart';
import 'package:my_notes_app/services/auth/bloc/auth_state.dart';

import '../auth_provider.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider) : super(const AuthStateLoading()) {
    //initialize
    on<AuthEventInitialize>((event, emit) async {
      await provider.initialize();
      final user = provider.currentUser;

      if (user == null) {
        emit(const AuthStateLoggedOut());
      } else if (!user.isEmailVerified) {
        emit(const AuthStateNeedsVerififcation());
      } else {
        emit(AuthStateLoggedIn(user));
      }
    });

    //login
    on<AuthEventLogIn>((event, emit) async {
      emit(const AuthStateLoading());
      final email = event.email;
      final password = event.password;
      try {
        final user = await provider.logIn(
          email: email,
          password: password,
        );
        emit(AuthStateLoggedIn(user));
      } on Exception catch (e) {
        emit(AuthStateLoggedInFailure(e));
      }
    });

    //log out
    on<AuthEventLogOut>(
      (event, emit) async {
        try {
          emit(const AuthStateLoading());
          await provider.logOut();
          emit(const AuthStateLoggedOut());
        } on Exception catch (e) {
          emit(AuthStateLoggedOutFailure(e));
        }
      },
    );
  }
}
