part of 'selfie_bloc.dart';

abstract class SelfieState extends Equatable {
  const SelfieState();

  @override
  List<Object?> get props => [];
}

class InitialState extends SelfieState {}

class LoadingState extends SelfieState {}

class PredictedState extends SelfieState {
  final String prediction;
  final String shapeImage;
  final List<String> recommendations;

  const PredictedState({
    required this.prediction,
    required this.recommendations,
    required this.shapeImage,
  });

  @override
  List<Object?> get props => [prediction, recommendations, shapeImage];
}

class UnpredictedState extends SelfieState {}
