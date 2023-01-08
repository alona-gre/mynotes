import 'package:flutter/material.dart' show immutable;
import 'package:my_notes_app/services/auth/auth_user.dart';

@immutable
abstract class AuthState {
  const AuthState();
}

class AuthStateLoading extends AuthState {
  const AuthStateLoading();
}

class AuthStateLoggedIn extends AuthState {
  final AuthUser user;
  const AuthStateLoggedIn(this.user);
}

class AuthStateLoggedInFailure extends AuthState {
  final Exception exception;
  const AuthStateLoggedInFailure(this.exception);
}

class AuthStateNeedsVerififcation extends AuthState {
  const AuthStateNeedsVerififcation();
}

class AuthStateLoggedOut extends AuthState {
  const AuthStateLoggedOut();
}

class AuthStateLoggedOutFailure extends AuthState {
  final Exception exception;
  const AuthStateLoggedOutFailure(this.exception);
}
