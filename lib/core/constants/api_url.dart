class ApiUrl {
  static const String baseUrl = 'http://192.168.1.10:5000/';

  static const String _userApi = 'api/users/';
  static const String login = '${_userApi}login';
  static const String register = '${_userApi}register';

  static const String _productApi = 'api/product/';
  static const String _chatApi = 'api/chat/';
  static const String _reviewApi = 'api/review/';
  static const String _transactionApi = 'api/transaction/';
}
