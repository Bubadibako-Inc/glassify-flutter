import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glassify_flutter/core/configs/assets/app_images.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/predict/usecases/is_predicted.dart';
import '../../../service_locator.dart';

part 'selfie_state.dart';
part 'selfie_event.dart';

class SelfieBloc extends Bloc<SelfieEvent, SelfieState> {
  SelfieBloc() : super(InitialState()) {
    on<GetPrediction>((event, emit) async {
      late String prediction;
      late List<String> recommendations;
      late String shapeImage;

      final isPredicted = await sl<IsPredictedUseCase>().call();

      if (isPredicted != true) {
        return emit(UnpredictedState());
      }

      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      prediction = sharedPreferences.getString('prediction')!;

      prediction =
          '${prediction[0].toUpperCase()}${prediction.substring(1).toLowerCase()}';

      recommendations = _getRecommendations(prediction);
      shapeImage = _getShapeImage(prediction);

      return emit(PredictedState(
        prediction: prediction,
        recommendations: recommendations,
        shapeImage: shapeImage,
      ));
    });

    on<UpdatePrediction>((event, emit) async {
      late List<String> recommendations;
      late String shapeImage;

      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      sharedPreferences.setString('prediction', event.prediction);

      event.prediction =
          '${event.prediction[0].toUpperCase()}${event.prediction.substring(1).toLowerCase()}';

      recommendations = _getRecommendations(event.prediction);

      shapeImage = _getShapeImage(event.prediction);

      return emit(PredictedState(
        prediction: event.prediction,
        recommendations: recommendations,
        shapeImage: shapeImage,
      ));
    });
  }
}

List<String> _getRecommendations(String prediction) {
  List<String> recommendations = [];
  switch (prediction) {
    case 'Square':
      recommendations = ['Browline', 'Cat-Eye', 'Round', 'Oval'];
      return recommendations;
    case 'Oblong':
      recommendations = ['Square', 'Cat-Eye', 'Aviator', 'Browline'];
      return recommendations;
    case 'Heart':
      recommendations = ['Rectangle', 'Geometric', 'Round', 'Aviator'];
      return recommendations;
    case 'Oval':
      recommendations = ['Rectangle', 'Square', 'Browline', 'Aviator'];
      return recommendations;
    case 'Round':
      recommendations = ['Rectangle', 'Square', 'Round', 'Aviator'];
      return recommendations;
    default:
      return recommendations;
  }
}

String _getShapeImage(String prediction) {
  String shapeImage = '';
  switch (prediction) {
    case 'Square':
      shapeImage = AppImages.square;
      return shapeImage;
    case 'Oblong':
      shapeImage = AppImages.oblong;
      return shapeImage;
    case 'Heart':
      shapeImage = AppImages.heart;
      return shapeImage;
    case 'Oval':
      shapeImage = AppImages.oval;
      return shapeImage;
    case 'Round':
      shapeImage = AppImages.round;
      return shapeImage;
    default:
      return shapeImage;
  }
}
