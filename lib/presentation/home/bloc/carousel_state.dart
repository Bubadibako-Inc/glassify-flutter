part of 'carousel_bloc.dart';

class CarouselState extends Equatable {
  final int index;

  const CarouselState({required this.index});

  @override
  List<Object?> get props => [index];
}
