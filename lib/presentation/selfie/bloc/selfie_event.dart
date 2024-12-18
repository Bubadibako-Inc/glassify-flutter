// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'selfie_bloc.dart';

abstract class SelfieEvent {}

class GetPrediction extends SelfieEvent {}

class UpdatePrediction extends SelfieEvent {
  String prediction;

  UpdatePrediction({
    required this.prediction,
  });
}
