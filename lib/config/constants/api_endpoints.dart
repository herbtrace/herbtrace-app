class ApiEndpoints {
  static const String baseUrl = 'https://api.herbtrace.com';

  static const String login = '/auth/login';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';

  static const String farmerProfile = '/farmer/profile';
  static const String farmerTransactions = '/farmer/transactions';
  static const String startTransaction = '/farmer/transactions/start';
  static const String endTransaction = '/farmer/transactions/end';

  static const String crops = '/crops';
  static const String validateCrop = '/crops/validate';
}
