import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dio/dio.dart';

class ModelPredictReqParams {
  final XFile picture;

  ModelPredictReqParams({
    required this.picture,
  });

  Future<FormData> toFormData() async {
    final file = File(picture.path);
    return FormData.fromMap(
      <String, MultipartFile>{
        'picture': await MultipartFile.fromFile(
          file.path,
          filename: file.uri.pathSegments.last,
        ),
      },
    );
  }
}
