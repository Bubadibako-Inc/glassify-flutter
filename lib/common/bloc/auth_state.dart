part of 'auth_bloc.dart';

abstract class AuthState {}

class InitialState extends AuthState {}

class AuthenticatedState extends AuthState {
  final String name;
  final String email;
  final String role;

  AuthenticatedState({
    required this.name,
    required this.email,
    required this.role,
  });
}

class UnauthenticatedState extends AuthState {}
