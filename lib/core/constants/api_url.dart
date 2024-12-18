class ApiUrl {
  static const String baseUrl = 'https://api.glassify.my.id/';

// =============================
//  Authentication API Endpoints
// =============================

  static const String _authApi = 'auth/';
  static const String login = '${_authApi}login';
  static const String register = '${_authApi}register';
  static const String logout = '${_authApi}logout';

// =============================
//  Model API Endpoints
// =============================

  static const String _modelApi = 'model/';
  static const String predict = '${_modelApi}predict';

// =============================
//  Product API Endpoints
// =============================

  static const String _productApi = 'product/';
  static const String products = _productApi;
  static const String latestProducts = '${_productApi}latest';
  static const String bestSellerProducts = '${_productApi}best-seller';
  static const String searchProduct = '${_productApi}search';
  static const String productDetail = _productApi;

  static const String _chatApi = 'api/chat/';
  static const String _reviewApi = 'api/review/';
  static const String _transactionApi = 'api/transaction/';
}
