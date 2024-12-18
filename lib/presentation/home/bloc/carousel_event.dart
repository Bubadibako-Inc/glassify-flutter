part of 'carousel_bloc.dart';

class CarouselEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnPageChanged extends CarouselEvent {
  final int index;

  OnPageChanged({required this.index});

  @override
  List<Object?> get props => [index, ...super.props];
}
