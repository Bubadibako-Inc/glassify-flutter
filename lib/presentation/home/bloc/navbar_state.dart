part of 'navbar_bloc.dart';

class NavbarState extends Equatable {
  final int index;

  const NavbarState({required this.index});

  @override
  List<Object?> get props => [index];
}
