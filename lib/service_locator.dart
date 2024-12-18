import 'package:get_it/get_it.dart';
import 'package:glassify_flutter/data/product/repositories/product.dart';
import 'package:glassify_flutter/data/product/sources/product_api_service.dart';
import 'package:glassify_flutter/domain/history/repositories/history.dart';
import 'package:glassify_flutter/domain/history/usecases/get_product_history.dart';
import 'package:glassify_flutter/domain/history/usecases/get_query_history.dart';
import 'package:glassify_flutter/domain/history/usecases/set_product_history.dart';
import 'package:glassify_flutter/domain/history/usecases/set_query_history.dart';
import 'package:glassify_flutter/domain/product/repositories/product.dart';
import 'package:glassify_flutter/domain/product/usecases/get_best_seller_products.dart';
import 'package:glassify_flutter/domain/product/usecases/get_latest_products.dart';
import 'package:glassify_flutter/domain/product/usecases/get_product_by_id.dart';
import 'package:glassify_flutter/domain/product/usecases/get_products.dart';
import 'package:glassify_flutter/domain/product/usecases/search_product.dart';

import '../core/network/dio_client.dart';

import 'data/auth/sources/auth_api_service.dart';
import 'data/auth/repositories/auth.dart';
import 'data/history/repositories/history.dart';
import 'data/predict/repositories/predict.dart';
import 'data/predict/sources/predict_api_service.dart';

import 'domain/auth/repositories/auth.dart';
import 'domain/auth/usecases/is_newcomer.dart';
import 'domain/auth/usecases/login.dart';
import 'domain/auth/usecases/logout.dart';
import 'domain/auth/usecases/set_newcomer.dart';
import 'domain/auth/usecases/is_authenticated.dart';
import 'domain/auth/usecases/register.dart';
import 'domain/predict/respositories/predict.dart';
import 'domain/predict/usecases/model_predict.dart';
import 'domain/predict/usecases/is_predicted.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  // ==========================
  //  Dio Client: Network Handling
  // ==========================
  sl.registerSingleton<DioClient>(DioClient());

  // ==========================
  //  Services: API Services and Business Logic
  // ==========================
  sl.registerSingleton<AuthApiService>(AuthApiServiceImpl());
  sl.registerSingleton<PredictApiService>(PredictApiServiceImpl());
  sl.registerSingleton<ProductService>(ProductServiceImpl());

  // ==========================
  //  Predict Repository: Data Access for Prediction
  // ==========================
  sl.registerSingleton<PredictRepository>(PredictRepositoryImpl());

  // ==========================
  //  Predict Use Cases: Business Logic for Prediction
  // ==========================
  sl.registerSingleton<ModelPredictUseCase>(ModelPredictUseCase());
  sl.registerSingleton<IsPredictedUseCase>(IsPredictedUseCase());

  // ==========================
  //  Auth Repository: Data Access for Authentication
  // ==========================
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  // ==========================
  //  Auth Use Cases: Business Logic for Authentication
  // ==========================
  sl.registerSingleton<LoginUseCase>(LoginUseCase());
  sl.registerSingleton<RegisterUseCase>(RegisterUseCase());
  sl.registerSingleton<LogoutUseCase>(LogoutUseCase());
  sl.registerSingleton<IsAuthenticatedUseCase>(IsAuthenticatedUseCase());
  sl.registerSingleton<IsNewcomerUseCase>(IsNewcomerUseCase());
  sl.registerSingleton<SetNewcomerUseCase>(SetNewcomerUseCase());

  // ==========================
  //  Product Repository: Data Access for Product Information
  // ==========================
  sl.registerSingleton<ProductRepository>(ProductRepositoryImpl());

  // ==========================
  //  Product Use Cases: Business Logic for Product Operations
  // ==========================
  sl.registerSingleton<GetProductsUseCase>(GetProductsUseCase());
  sl.registerSingleton<GetBestSellerProductsUseCase>(
      GetBestSellerProductsUseCase());
  sl.registerSingleton<GetLatestProductsUseCase>(GetLatestProductsUseCase());
  sl.registerSingleton<GetProductByIdUseCase>(GetProductByIdUseCase());
  sl.registerSingleton<SearchProductUseCase>(SearchProductUseCase());

  // ==========================
  //  History Repository: Data Access for History Management
  // ==========================
  sl.registerSingleton<HistoryRepository>(HistoryRepositoryImpl());

  // ==========================
  //  History Use Cases: Business Logic for History Operations
  // ==========================
  sl.registerSingleton<GetProductHistoryUseCase>(GetProductHistoryUseCase());
  sl.registerSingleton<GetQueryHistoryUseCase>(GetQueryHistoryUseCase());
  sl.registerSingleton<SetProductHistoryUseCase>(SetProductHistoryUseCase());
  sl.registerSingleton<SetQueryHistoryUseCase>(SetQueryHistoryUseCase());
}
