class ApiEndpoints {
  static const String baseUrl = 'https://f271fe3f0e47.ngrok-free.app';

  static const String checkProfileExists = '/profiles/check_if_user_exists';
  static const String userLogin = '/profiles/user_login';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';

  static const String farmerProfile = '/farmer/profile';
  static const String farmerTransactions = '/farmer/transactions';
  static const String startTransaction = '/farmer/transactions/start';
  static const String endTransaction = '/farmer/transactions/end';

  static const String crops = '/crops';
  static const String validateCrop = '/crops/validate';
}
