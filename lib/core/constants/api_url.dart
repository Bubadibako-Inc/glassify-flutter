class ApiUrl {
  static const String baseUrl = 'https://api.glassify.my.id/';

  // ================================
  //  Authentication API Endpoints
  // ================================
  static const String _authApi = 'auth/';
  static const String login = '${_authApi}login';
  static const String register = '${_authApi}register';
  static const String logout = '${_authApi}logout';

  // ================================
  //  Model API Endpoints
  // ================================
  static const String _modelApi = 'model/';
  static const String predict = '${_modelApi}predict';

  // ================================
  //  Product API Endpoints
  // ================================
  static const String _productApi = 'product/';
  static const String products = _productApi;
  static const String latestProducts = '${_productApi}latest';
  static const String bestSellerProducts = '${_productApi}best-seller';
  static const String searchProduct = '${_productApi}search';
  static const String productDetail = _productApi;

  // ================================
  //  Transaction API Endpoints
  // ================================
  static const String _transactionApi = 'transaction/';
  static const String transactionDetail = _transactionApi;
  static const String createTransaction = _transactionApi;
  static const String userTransaction = '${_transactionApi}my-transactions';

  // ================================
  //  User API Endpoints
  // ================================
  static const String _userApi = 'user/';
  static const String getUserProfile = '${_userApi}profile';
  static const String updateUser = _userApi;

  // ================================
  //  Cart API Endpoints
  // ================================
  static const String _cartApi = 'cart/';
  static const String addItemToCart = _cartApi;
  static const String getCart = _cartApi;
  static const String deleteCartItem = _cartApi;

  // ================================
  //  Review API Endpoints
  // ================================
  static const String _reviewApi = 'review/';
  static const String addReviewById = _reviewApi;
  static const String getProductReviews = '${_reviewApi}product';
  static const String getUserReviews = '${_reviewApi}my-reviews';

  // ================================
  //  Wishlist API Endpoints
  // ================================
  static const String _wishlistApi = 'wishlist/';
  static const String addWishlist = _wishlistApi;
  static const String getWishlist = _wishlistApi;
  static const String deleteWishlistItem = _wishlistApi;
}
