// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kannada (`kn`).
class AppLocalizationsKn extends AppLocalizations {
  AppLocalizationsKn([String locale = 'kn']) : super(locale);

  @override
  String get select_this_crop => 'ಈ ಬೆಳೆಯನ್ನು ಆಯ್ಕೆ ಮಾಡಿ';

  @override
  String get select_a_crop => 'ಒಂದು ಬೆಳೆಯನ್ನು ಆಯ್ಕೆ ಮಾಡಿ';

  @override
  String get welcome => 'ಸ್ವಾಗತ';

  @override
  String get welcome_to_herbtrace => 'ಹರ್ಬ್‌ಟ್ರೇಸ್‌ಗೆ ಸ್ವಾಗತ';

  @override
  String get login => 'ಲಾಗಿನ್';

  @override
  String get start => 'ಪ್ರಾರಂಭಿಸಿ';

  @override
  String get end => 'ಅಂತ್ಯ';

  @override
  String get select_language => 'ಭಾಷೆಯನ್ನು ಆಯ್ಕೆ ಮಾಡಿ';

  @override
  String get add_crop => 'ಬೆಳೆ ಸೇರಿಸಿ';

  @override
  String get no_active_transactions => 'ಯಾವುದೇ ಸಕ್ರಿಯ ವಹಿವಾಟುಗಳಿಲ್ಲ';

  @override
  String get profile => 'ಪ್ರೊಫೈಲ್';

  @override
  String get scan => 'ಸ್ಕ್ಯಾನ್';

  @override
  String get home => 'ಮುಖಪುಟ';

  @override
  String get transaction_history => 'ವಹಿವಾಟು ಇತಿಹಾಸ';

  @override
  String get settings => 'ಸೆಟ್ಟಿಂಗ್‌ಗಳು';

  @override
  String get change_language => 'ಭಾಷೆ ಬದಲಾಯಿಸಿ';

  @override
  String get logout => 'ಲಾಗ್ ಔಟ್';

  @override
  String get cropNameAshwagandha => 'ಅಶ್ವಗಂಧ';

  @override
  String get cropNameBrahmi => 'ಬ್ರಾಹ್ಮಿ';

  @override
  String get cropNameGiloy => 'ಗಿಲೋಯ';

  @override
  String get cropNameTulsi => 'ತುಳಸಿ';

  @override
  String get cropNameArjuna => 'ಅರ್ಜುನ';

  @override
  String get supply_chain_transfer => 'ಸರಬರಾಜು ಸರಪಳಿ ವರ್ಗಾವಣೆ';

  @override
  String get transfer_instructions => 'ಮುಂದಿನ ಹಂತಕ್ಕೆ ಬ್ಯಾಚ್ ವರ್ಗಾವಣೆ';

  @override
  String get scan_qr_instructions =>
      'ಮುಂದಿನ ಹಂತದ ನಿರ್ವಾಹಕರು ಈ QR ಕೋಡ್ ಅನ್ನು ಸ್ಕ್ಯಾನ್ ಮಾಡಿ ಬ್ಯಾಚ್ ವರ್ಗಾವಣೆಯನ್ನು ಪರಿಶೀಲಿಸಿ ಮತ್ತು ಸ್ವೀಕರಿಸಲು ಕೇಳಿ';

  @override
  String get batch_id_label => 'ಬ್ಯಾಚ್ ID';

  @override
  String get transfer_confirmation => 'ನಾನು ಈ ವರ್ಗಾವಣೆಯನ್ನು ದೃಢೀಕರಿಸುತ್ತೇನೆ';

  @override
  String get endTransaction => 'ವಹಿವಾಟು ಅಂತ್ಯ';

  @override
  String get cancel => 'ರದ್ದುಗೊಳಿಸಿ';

  @override
  String get confirm => 'ದೃಢೀಕರಿಸಿ';

  @override
  String get cropLabel => 'ಬೆಳೆ';

  @override
  String get durationLabel => 'ಅವಧಿ';

  @override
  String get quantityLabel => 'ಪ್ರಮಾಣ';

  @override
  String quantityUnit(double quantity) {
    final intl.NumberFormat quantityNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String quantityString = quantityNumberFormat.format(quantity);

    return '$quantityString ಕಿಗ್ರಾ';
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
      other: '$hoursString ಗಂಟೆಗಳು ',
      one: '1 ಗಂಟೆ ',
      zero: '',
    );
    String _temp1 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: '$minutesString ನಿಮಿಷಗಳು',
      one: '1 ನಿಮಿಷ',
    );
    return '$_temp0$_temp1';
  }

  @override
  String get transactionDetails => 'ವಹಿವಾಟು ವಿವರಗಳು';

  @override
  String get cropInformation => 'ಬೆಳೆ ಮಾಹಿತಿ';

  @override
  String get commonName => 'ಸಾಮಾನ್ಯ ಹೆಸರು';

  @override
  String get scientificName => 'ವೈಜ್ಞಾನಿಕ ಹೆಸರು';

  @override
  String get category => 'ವರ್ಗ';

  @override
  String get batchId => 'ಬ್ಯಾಚ್ ಐಡಿ';

  @override
  String get startTime => 'ಪ್ರಾರಂಭ ಸಮಯ';

  @override
  String get qualityParameters => 'ಗುಣಮಟ್ಟದ ಮಾನದಂಡಗಳು';

  @override
  String get approvedCollectionRegions => 'ಅನುಮೋದಿತ ಸಂಗ್ರಹಣೆ ಪ್ರದೇಶಗಳು';

  @override
  String get additionalInformation => 'ಹೆಚ್ಚುವರಿ ಮಾಹಿತಿ';

  @override
  String get allowedHarvestMonths => 'ಅನುಮತಿಸಲಾದ ಸುಗ್ಗಿ ತಿಂಗಳುಗಳು';

  @override
  String get restrictedMonths => 'ನಿರ್ಬಂಧಿತ ತಿಂಗಳುಗಳು';

  @override
  String get maxWildCollection => 'ಗರಿಷ್ಠ ಕಾಡು ಸಂಗ್ರಹಣೆ';

  @override
  String get recommendedPractice => 'ಶಿಫಾರಸು ಮಾಡಿದ ಅಭ್ಯಾಸ';

  @override
  String get sustainabilityNotes => 'ಸಮರ್ಥನೀಯತೆ ಟಿಪ್ಪಣಿಗಳು';

  @override
  String get maxMoisturePercent => 'ಗರಿಷ್ಠ ತೇವಾಂಶ %';

  @override
  String get rootDiameterMinMm => 'ಕನಿಷ್ಠ ಬೇರು ವ್ಯಾಸ (ಮಿಮಿ)';

  @override
  String get withanolideContentMinPercent => 'ಕನಿಷ್ಠ ವಿಥಾನೋಲೈಡ್ %';

  @override
  String get pesticideResidueLimit => 'ಕೀಟನಾಶಕ ಶೇಷ ಮಿತಿ';

  @override
  String get heavyMetalsLimit => 'ಭಾರೀ ಲೋಹಗಳ ಮಿತಿ';

  @override
  String get dnaAuthentication => 'ಡಿಎನ್ಎ ದೃಢೀಕರಣ';

  @override
  String get bacosideContentMinPercent => 'ಕನಿಷ್ಠ ಬ್ಯಾಕೋಸೈಡ್ %';

  @override
  String get berberineContentMinPercent => 'ಕನಿಷ್ಠ ಬರ್ಬೆರಿನ್ %';

  @override
  String get essentialOilContentMinPercent => 'ಕನಿಷ್ಠ ಅತ್ಯಂತ ತೈಲ %';

  @override
  String get tanninsContentMinPercent => 'ಕನಿಷ್ಠ ಟ್ಯಾನಿನ್ಸ್ %';

  @override
  String get onboarding_welcome_subtitle =>
      'ಕೃಷಿಭೂಮಿಯಿಂದ ಫಾರ್ಮಸಿವರೆಗೆ ಔಷಧೀಯ ಸಸ್ಯಗಳ ಸುರಕ್ಷಿತ ಮತ್ತು ಪಾರದರ್ಶಕ ಟ್ರ್ಯಾಕಿಂಗ್';

  @override
  String get get_started => 'ಪ್ರಾರಂಭಿಸಿ';

  @override
  String get track => 'ಟ್ರ್ಯಾಕ್';

  @override
  String get verify => 'ಪರಿಶೀಲಿಸಿ';

  @override
  String get sustain => 'ಸಮರ್ಥನೀಯತೆ';

  @override
  String get choose_your_language => 'ನಿಮ್ಮ ಭಾಷೆಯನ್ನು ಆರಿಸಿ';

  @override
  String get language_selection_subtitle =>
      'ಮುಂದುವರಿಯಲು ನಿಮ್ಮ ಆದ್ಯತೆಯ ಭಾಷೆಯನ್ನು ಆಯ್ಕೆ ಮಾಡಿ';

  @override
  String get supply_chain_journey => 'ಸರಬರಾಜು ಸರಪಳಿ ಪ್ರಯಾಣ';

  @override
  String get supply_chain_subtitle =>
      'ನಿಮ್ಮ ಔಷಧೀಯ ಸಸ್ಯಗಳು ಸರಬರಾಜು ಸರಪಳಿಯಲ್ಲಿ ಹೇಗೆ ಚಲಿಸುತ್ತವೆ ಎಂಬುದನ್ನು ನೋಡಿ';

  @override
  String get farmer_wild_collector => 'ಕೃಷಿಕ/ಕಾಡು ಸಂಗ್ರಾಹಕ';

  @override
  String get transporter => 'ಸಾರಿಗೆದಾರ';

  @override
  String get processor => 'ಸಂಸ್ಕಾರಕ';

  @override
  String get laboratory => 'ಪ್ರಯೋಗಾಲಯ';

  @override
  String get manufacturer => 'ತಯಾರಕ';

  @override
  String get packer => 'ಪ್ಯಾಕರ್';

  @override
  String get farmer_guidance_title => 'ಕೃಷಿಕ ಮಾರ್ಗದರ್ಶನ';

  @override
  String get farmer_guidance_subtitle =>
      'ಬೆಳೆಗಳನ್ನು ಸೇರಿಸುವುದು ಮತ್ತು ನಿಮ್ಮ ಸುಗ್ಗಿಯನ್ನು ನಿರ್ವಹಿಸುವುದು ಹೇಗೆಂದು ಕಲಿಯಿರಿ';

  @override
  String get add_crop_step => 'ಬೆಳೆ ಸೇರಿಸಿ';

  @override
  String get monitor_growth => 'ಬೆಳವಣಿಗೆ ಮೇಲ್ವಿಚಾರಣೆ';

  @override
  String get harvest_time => 'ಸುಗ್ಗಿ ಸಮಯ';

  @override
  String get qr_process_title => 'QR ಕೋಡ್ ಪ್ರಕ್ರಿಯೆ';

  @override
  String get qr_process_subtitle =>
      'ಹ್ಯಾಂಡ್‌ಓವರ್ ಪ್ರಕ್ರಿಯೆ ಹೇಗೆ ಕೆಲಸ ಮಾಡುತ್ತದೆ ಎಂಬುದನ್ನು ಕಲಿಯಿರಿ';

  @override
  String get generate_qr => 'QR ಜನರೇಟ್ ಮಾಡಿ';

  @override
  String get scan_verify => 'ಸ್ಕ್ಯಾನ್ ಮತ್ತು ಪರಿಶೀಲಿಸಿ';

  @override
  String get transfer_complete => 'ವರ್ಗಾವಣೆ ಪೂರ್ಣ';

  @override
  String get ready_to_start => 'ನಿಮ್ಮ ಪ್ರಯಾಣ ಪ್ರಾರಂಭಿಸಲು ಸಿದ್ಧರೇ?';

  @override
  String get get_started_subtitle =>
      'ಪಾರದರ್ಶಕತೆ ಮತ್ತು ನಂಬಿಕೆಯೊಂದಿಗೆ ಸಂಪೂರ್ಣ ಪೂರೈಕೆ ಸರಪಳಿಯ ಮೂಲಕ ನಿಮ್ಮ ಔಷಧೀಯ ಉತ್ಪನ್ನಗಳನ್ನು ಟ್ರ್ಯಾಕ್ ಮಾಡಲು ಪ್ರಾರಂಭಿಸಿ।';

  @override
  String get quick_transactions => 'ತ್ವರಿತ ವಹಿವಾಟುಗಳು';

  @override
  String get full_traceability => 'ಸಂಪೂರ್ಣ ಪತ್ತೆಹಚ್ಚುವಿಕೆ';

  @override
  String get secure_blockchain => 'ಸುರಕ್ಷಿತ ಬ್ಲಾಕ್‌ಚೈನ್';

  @override
  String get get_started_button => 'ಪ್ರಾರಂಭಿಸಿ';
}
