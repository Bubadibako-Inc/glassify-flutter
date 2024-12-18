part of 'navbar_bloc.dart';

class NavbarEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnPageChanged extends NavbarEvent {
  final int index;

  OnPageChanged({required this.index});

  @override
  List<Object?> get props => [index, ...super.props];
}
