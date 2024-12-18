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
  final List<String> recommendations;

  const PredictedState({
    required this.prediction,
    required this.recommendations,
  });

  @override
  List<Object?> get props => [prediction, recommendations];
}

class UnpredictedState extends SelfieState {}
