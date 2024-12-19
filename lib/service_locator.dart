import 'package:get_it/get_it.dart';

import '../core/network/dio_client.dart';

import 'data/auth/repositories/auth.dart';
import 'data/auth/sources/auth_api_service.dart';
import 'data/history/repositories/history.dart';
import 'data/predict/repositories/predict.dart';
import 'data/predict/sources/predict_api_service.dart';
import 'data/product/repositories/product.dart';
import 'data/product/sources/product_api_service.dart';
import 'data/transaction/repositories/transaction.dart';
import 'data/transaction/sources/transaction_api_service.dart';
import 'data/user/repositories/user.dart';
import 'data/user/sources/user_api_service.dart';
import 'domain/auth/repositories/auth.dart';
import 'domain/auth/usecases/is_authenticated.dart';
import 'domain/auth/usecases/is_newcomer.dart';
import 'domain/auth/usecases/login.dart';
import 'domain/auth/usecases/logout.dart';
import 'domain/auth/usecases/register.dart';
import 'domain/auth/usecases/set_newcomer.dart';
import 'domain/history/repositories/history.dart';
import 'domain/history/usecases/get_product_history.dart';
import 'domain/history/usecases/get_query_history.dart';
import 'domain/history/usecases/set_product_history.dart';
import 'domain/history/usecases/set_query_history.dart';
import 'domain/predict/respositories/predict.dart';
import 'domain/predict/usecases/is_predicted.dart';
import 'domain/predict/usecases/model_predict.dart';
import 'domain/product/repositories/product.dart';
import 'domain/product/usecases/get_best_seller_products.dart';
import 'domain/product/usecases/get_latest_products.dart';
import 'domain/product/usecases/get_product_by_id.dart';
import 'domain/product/usecases/get_products.dart';
import 'domain/product/usecases/search_product.dart';
import 'domain/transaction/repositories/transaction.dart';
import 'domain/transaction/usecases/create_transaction.dart';
import 'domain/transaction/usecases/get_transaction_by_id.dart';
import 'domain/transaction/usecases/get_user_transaction.dart';
import 'domain/user/repositories/user.dart';
import 'domain/user/usecases/add_cart.dart';
import 'domain/user/usecases/add_wishlist.dart';
import 'domain/user/usecases/delete_cart_item.dart';
import 'domain/user/usecases/delete_wishlist_item.dart';
import 'domain/user/usecases/get_cart.dart';
import 'domain/user/usecases/get_user_profile.dart';
import 'domain/user/usecases/get_wishlist.dart';
import 'domain/user/usecases/update_user_by_id.dart';

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
  sl.registerSingleton<TransactionService>(TransactionServiceImpl());
  sl.registerSingleton<UserService>(UserServiceImpl());

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

  // ==========================
  //  Transaction Repository: Data Access for Transaction Management
  // ==========================
  sl.registerSingleton<TransactionRepository>(TransactionRepositoryImpl());

  // ==========================
  //  Transaction Use Cases: Business Logic for Transaction Operations
  // ==========================
  sl.registerSingleton<GetUserTransactionUseCase>(GetUserTransactionUseCase());
  sl.registerSingleton<GetTransactionByIdUseCase>(GetTransactionByIdUseCase());
  sl.registerSingleton<CreateTransactionUseCase>(CreateTransactionUseCase());

  // ==========================
  //  User Repository: Data Access for User Management
  // ==========================
  sl.registerSingleton<UserRepository>(UserRepositoryImpl());

  // ==========================
  //  User Use Cases: Business Logic for User Operations
  // ==========================
  sl.registerSingleton<AddCartUseCase>(AddCartUseCase());
  sl.registerSingleton<AddWishlistUseCase>(AddWishlistUseCase());
  sl.registerSingleton<DeleteCartItemUseCase>(DeleteCartItemUseCase());
  sl.registerSingleton<DeleteWishlistItemUseCase>(DeleteWishlistItemUseCase());
  sl.registerSingleton<GetCartUseCase>(GetCartUseCase());
  sl.registerSingleton<GetUserProfileUseCase>(GetUserProfileUseCase());
  sl.registerSingleton<GetWishlistUseCase>(GetWishlistUseCase());
  sl.registerSingleton<UpdateUserByIdUseCase>(UpdateUserByIdUseCase());
}
