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
  String get select_a_crop => 'Select a Crop';

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

  @override
  String get cropInformation => 'Crop Information';

  @override
  String get commonName => 'Common Name';

  @override
  String get scientificName => 'Scientific Name';

  @override
  String get category => 'Category';

  @override
  String get batchId => 'Batch ID';

  @override
  String get startTime => 'Start Time';

  @override
  String get qualityParameters => 'Quality Parameters';

  @override
  String get approvedCollectionRegions => 'Approved Collection Regions';

  @override
  String get additionalInformation => 'Additional Information';

  @override
  String get allowedHarvestMonths => 'Allowed Harvest Months';

  @override
  String get restrictedMonths => 'Restricted Months';

  @override
  String get maxWildCollection => 'Max Wild Collection';

  @override
  String get recommendedPractice => 'Recommended Practice';

  @override
  String get sustainabilityNotes => 'Sustainability Notes';

  @override
  String get maxMoisturePercent => 'Max Moisture %';

  @override
  String get rootDiameterMinMm => 'Min Root Diameter (mm)';

  @override
  String get withanolideContentMinPercent => 'Min Withanolide %';

  @override
  String get pesticideResidueLimit => 'Pesticide Residue Limit';

  @override
  String get heavyMetalsLimit => 'Heavy Metals Limit';

  @override
  String get dnaAuthentication => 'DNA Authentication';

  @override
  String get bacosideContentMinPercent => 'Min Bacoside %';

  @override
  String get berberineContentMinPercent => 'Min Berberine %';

  @override
  String get essentialOilContentMinPercent => 'Min Essential Oil %';

  @override
  String get tanninsContentMinPercent => 'Min Tannins %';

  @override
  String get onboarding_welcome_subtitle =>
      'Secure and transparent tracking of medicinal plants from farm to pharmacy';

  @override
  String get get_started => 'Get Started';

  @override
  String get track => 'Track';

  @override
  String get verify => 'Verify';

  @override
  String get sustain => 'Sustain';

  @override
  String get choose_your_language => 'Choose Your Language';

  @override
  String get language_selection_subtitle =>
      'Select your preferred language to continue';

  @override
  String get supply_chain_journey => 'Supply Chain Journey';

  @override
  String get supply_chain_subtitle =>
      'See how your medicinal plants move through the supply chain';

  @override
  String get farmer_wild_collector => 'Farmer/Wild Collector';

  @override
  String get transporter => 'Transporter';

  @override
  String get processor => 'Processor';

  @override
  String get laboratory => 'Laboratory';

  @override
  String get manufacturer => 'Manufacturer';

  @override
  String get packer => 'Packer';

  @override
  String get farmer_guidance_title => 'Farmer Guidance';

  @override
  String get farmer_guidance_subtitle =>
      'Learn how to add crops and manage your harvest';

  @override
  String get add_crop_step => 'Add Crop';

  @override
  String get monitor_growth => 'Monitor Growth';

  @override
  String get harvest_time => 'Harvest Time';

  @override
  String get qr_process_title => 'QR Code Process';

  @override
  String get qr_process_subtitle => 'Learn how the handover process works';

  @override
  String get generate_qr => 'Generate QR';

  @override
  String get scan_verify => 'Scan & Verify';

  @override
  String get transfer_complete => 'Transfer Complete';

  @override
  String get ready_to_start => 'Ready to Start Your Journey?';

  @override
  String get get_started_subtitle =>
      'Begin tracking your herbal products through the complete supply chain with transparency and trust.';

  @override
  String get quick_transactions => 'Quick Transactions';

  @override
  String get full_traceability => 'Full Traceability';

  @override
  String get secure_blockchain => 'Secure Blockchain';

  @override
  String get get_started_button => 'Get Started';
}
