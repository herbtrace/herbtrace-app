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

  @override
  String get cropInformation => 'फसल की जानकारी';

  @override
  String get commonName => 'सामान्य नाम';

  @override
  String get scientificName => 'वैज्ञानिक नाम';

  @override
  String get category => 'श्रेणी';

  @override
  String get batchId => 'बैच आईडी';

  @override
  String get startTime => 'प्रारंभ समय';

  @override
  String get qualityParameters => 'गुणवत्ता मापदंड';

  @override
  String get approvedCollectionRegions => 'अनुमोदित संग्रह क्षेत्र';

  @override
  String get additionalInformation => 'अतिरिक्त जानकारी';

  @override
  String get allowedHarvestMonths => 'अनुमतित फसल के महीने';

  @override
  String get restrictedMonths => 'प्रतिबंधित महीने';

  @override
  String get maxWildCollection => 'अधिकतम जंगली संग्रह';

  @override
  String get recommendedPractice => 'अनुशंसित अभ्यास';

  @override
  String get sustainabilityNotes => 'स्थिरता नोट्स';

  @override
  String get maxMoisturePercent => 'अधिकतम नमी %';

  @override
  String get rootDiameterMinMm => 'न्यूनतम जड़ व्यास (मिमी)';

  @override
  String get withanolideContentMinPercent => 'न्यूनतम विथानोलाइड %';

  @override
  String get pesticideResidueLimit => 'कीटनाशक अवशेष सीमा';

  @override
  String get heavyMetalsLimit => 'भारी धातु सीमा';

  @override
  String get dnaAuthentication => 'डीएनए प्रामाणिकता';

  @override
  String get bacosideContentMinPercent => 'न्यूनतम बैकोसाइड %';

  @override
  String get berberineContentMinPercent => 'न्यूनतम बर्बेरिन %';

  @override
  String get essentialOilContentMinPercent => 'न्यूनतम आवश्यक तेल %';

  @override
  String get tanninsContentMinPercent => 'न्यूनतम टैनिन %';

  @override
  String get onboarding_welcome_subtitle =>
      'खेत से फार्मेसी तक औषधीय पौधों की सुरक्षित और पारदर्शी ट्रैकिंग';

  @override
  String get get_started => 'शुरू करें';

  @override
  String get track => 'ट्रैक';

  @override
  String get verify => 'सत्यापित';

  @override
  String get sustain => 'स्थिरता';

  @override
  String get choose_your_language => 'अपनी भाषा चुनें';

  @override
  String get language_selection_subtitle =>
      'जारी रखने के लिए अपनी पसंदीदा भाषा चुनें';

  @override
  String get supply_chain_journey => 'आपूर्ति श्रृंखला यात्रा';

  @override
  String get supply_chain_subtitle =>
      'देखें कि आपके औषधीय पौधे आपूर्ति श्रृंखला में कैसे आगे बढ़ते हैं';

  @override
  String get farmer_wild_collector => 'किसान/जंगली संग्रहकर्ता';

  @override
  String get transporter => 'परिवहनकर्ता';

  @override
  String get processor => 'प्रोसेसर';

  @override
  String get laboratory => 'प्रयोगशाला';

  @override
  String get manufacturer => 'निर्माता';

  @override
  String get packer => 'पैकर';

  @override
  String get farmer_guidance_title => 'किसान मार्गदर्शन';

  @override
  String get farmer_guidance_subtitle =>
      'फसल जोड़ना और अपनी फसल का प्रबंधन करना सीखें';

  @override
  String get add_crop_step => 'फसल जोड़ें';

  @override
  String get monitor_growth => 'वृद्धि निगरानी';

  @override
  String get harvest_time => 'फसल का समय';

  @override
  String get qr_process_title => 'QR कोड प्रक्रिया';

  @override
  String get qr_process_subtitle =>
      'जानें कि हैंडओवर प्रक्रिया कैसे काम करती है';

  @override
  String get generate_qr => 'QR जेनरेट करें';

  @override
  String get scan_verify => 'स्कैन और सत्यापित';

  @override
  String get transfer_complete => 'स्थानांतरण पूर्ण';

  @override
  String get ready_to_start => 'अपनी यात्रा शुरू करने के लिए तैयार हैं?';

  @override
  String get get_started_subtitle =>
      'पारदर्शिता और विश्वास के साथ पूरी आपूर्ति श्रृंखला के माध्यम से अपने हर्बल उत्पादों को ट्रैक करना शुरू करें।';

  @override
  String get quick_transactions => 'त्वरित लेन-देन';

  @override
  String get full_traceability => 'पूर्ण अनुरेखणीयता';

  @override
  String get secure_blockchain => 'सुरक्षित ब्लॉकचेन';

  @override
  String get get_started_button => 'शुरू करें';
}
