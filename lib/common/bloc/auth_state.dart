part of 'auth_bloc.dart';

abstract class AuthState {}

class InitialState extends AuthState {}

class AuthenticatedState extends AuthState {}

class UnauthenticatedState extends AuthState {}
