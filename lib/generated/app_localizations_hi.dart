// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get select_this_crop => 'इस फसल का चयन करें';

  @override
  String get select_a_crop => 'एक फसल का चयन करें';

  @override
  String get welcome => 'स्वागत है';

  @override
  String get welcome_to_herbtrace => 'हर्बट्रेस में आपका स्वागत है';

  @override
  String get login => 'लॉगिन';

  @override
  String get start => 'शुरू करें';

  @override
  String get end => 'समाप्त करें';

  @override
  String get select_language => 'भाषा चुनें';

  @override
  String get add_crop => 'फसल जोड़ें';

  @override
  String get no_active_transactions => 'कोई सक्रिय लेनदेन नहीं';

  @override
  String get profile => 'प्रोफ़ाइल';

  @override
  String get scan => 'स्कैन';

  @override
  String get home => 'होम';

  @override
  String get transaction_history => 'लेन-देन का इतिहास';

  @override
  String get settings => 'सेटिंग्स';

  @override
  String get change_language => 'भाषा बदलें';

  @override
  String get logout => 'लॉग आउट';

  @override
  String get cropNameAshwagandha => 'अश्वगंधा';

  @override
  String get cropNameBrahmi => 'ब्राह्मी';

  @override
  String get cropNameGiloy => 'गिलोय';

  @override
  String get cropNameTulsi => 'तुलसी';

  @override
  String get cropNameArjuna => 'अर्जुन';

  @override
  String get supply_chain_transfer => 'आपूर्ति श्रृंखला स्थानांतरण';

  @override
  String get transfer_instructions => 'अगले चरण में बैच स्थानांतरण';

  @override
  String get scan_qr_instructions =>
      'अगले चरण के हैंडलर से इस QR कोड को स्कैन करके बैच स्थानांतरण सत्यापित और स्वीकार करने के लिए कहें';

  @override
  String get batch_id_label => 'बैच आईडी';

  @override
  String get transfer_confirmation =>
      'मैं इस स्थानांतरण की पुष्टि करता/करती हूँ';

  @override
  String get endTransaction => 'लेन-देन समाप्त करें';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get confirm => 'पुष्टि करें';

  @override
  String get cropLabel => 'फसल';

  @override
  String get durationLabel => 'अवधि';

  @override
  String get quantityLabel => 'मात्रा';

  @override
  String quantityUnit(double quantity) {
    final intl.NumberFormat quantityNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String quantityString = quantityNumberFormat.format(quantity);

    return '$quantityString किग्रा';
  }

  @override
  String durationFormat(num hours, num minutes) {
    final intl.NumberFormat hoursNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String hoursString = hoursNumberFormat.format(hours);
    final intl.NumberFormat minutesNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String minutesString = minutesNumberFormat.format(minutes);

    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hoursString घंटे ',
      one: '1 घंटा ',
      zero: '',
    );
    String _temp1 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: '$minutesString मिनट',
      one: '1 मिनट',
    );
    return '$_temp0$_temp1';
  }

  @override
  String get transactionDetails => 'लेन-देन का विवरण';
}
