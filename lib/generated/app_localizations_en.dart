// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get select_this_crop => 'Select This Crop';

  @override
  String get welcome => 'Welcome';

  @override
  String get welcome_to_herbtrace => 'Welcome to herbtrace';

  @override
  String get login => 'Login';

  @override
  String get start => 'Start';

  @override
  String get end => 'End';

  @override
  String get select_language => 'Select Language';

  @override
  String get add_crop => 'Add Crop';

  @override
  String get no_active_transactions => 'No active transactions';

  @override
  String get profile => 'Profile';

  @override
  String get scan => 'Scan';

  @override
  String get home => 'Home';

  @override
  String get transaction_history => 'Transaction History';

  @override
  String get settings => 'Settings';

  @override
  String get change_language => 'Change Language';

  @override
  String get logout => 'Logout';

  @override
  String get cropNameAshwagandha => 'Ashwagandha';

  @override
  String get cropNameBrahmi => 'Brahmi';

  @override
  String get cropNameGiloy => 'Giloy';

  @override
  String get cropNameTulsi => 'Tulsi';

  @override
  String get cropNameArjuna => 'Arjuna';

  @override
  String get supply_chain_transfer => 'Supply Chain Transfer';

  @override
  String get transfer_instructions => 'Transfer Batch to Next Stage';

  @override
  String get scan_qr_instructions =>
      'Ask the next stage handler to scan this QR code to verify and accept the batch transfer';

  @override
  String get batch_id_label => 'Batch ID';

  @override
  String get transfer_confirmation => 'I confirm this transfer';

  @override
  String get endTransaction => 'End Transaction';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get cropLabel => 'Crop';

  @override
  String get durationLabel => 'Duration';

  @override
  String get quantityLabel => 'Quantity';

  @override
  String quantityUnit(double quantity) {
    final intl.NumberFormat quantityNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String quantityString = quantityNumberFormat.format(quantity);

    return '$quantityString kg';
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
      other: '$hoursString hours ',
      one: '1 hour ',
      zero: '',
    );
    String _temp1 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: '$minutesString minutes',
      one: '1 minute',
    );
    return '$_temp0$_temp1';
  }

  @override
  String get transactionDetails => 'Transaction Details';
}
