// enum ProfileType {
//   farmer,
//   wildCollector,
//   processor,
//   laboratory,
//   manufacturer,
//   packer,
//   storage,
//   transport,
//   testing,
// }

enum TransactionStatus { active, completed, pending, failed }

class AppConstants {
  static const String appName = 'HerbTrace';
  static const String version = '1.0.0';

  static const int apiTimeoutDuration = 30;

  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
}
