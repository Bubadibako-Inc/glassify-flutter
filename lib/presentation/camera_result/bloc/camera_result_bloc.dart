import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/predict/models/model_predict_req_params.dart';
import '../../../domain/predict/usecases/model_predict.dart';

import '../../../service_locator.dart';

part 'camera_result_state.dart';
part 'camera_result_event.dart';

class CameraResultBloc extends Bloc<CameraResultEvent, CameraResultState> {
  CameraResultBloc() : super(InitialState()) {
    on<OnConfirmPressed>((event, emit) async {
      emit(LoadingState());

      XFile picture = event.picture;

      final response = await sl<ModelPredictUseCase>().call(
        params: ModelPredictReqParams(
          picture: picture,
        ),
      );

      response.fold(
        (error) => emit(UploadFailedState(message: error)),
        (data) => emit(UploadSuccessState(prediction: data['prediction'])),
      );
    });
  }
}
