import 'dart:math';

class UniqueId {
  static final Random _random = Random();
  static final String _chars =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  static const int _defaultLength = 20;

  static String generate([int length = _defaultLength]) {
    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => _chars.codeUnitAt(_random.nextInt(_chars.length)),
      ),
    );
  }
}
