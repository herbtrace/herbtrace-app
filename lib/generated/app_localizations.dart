import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_kn.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi'),
    Locale('kn'),
  ];

  /// No description provided for @select_this_crop.
  ///
  /// In en, this message translates to:
  /// **'Select This Crop'**
  String get select_this_crop;

  /// Label for crop selection dropdown
  ///
  /// In en, this message translates to:
  /// **'Select a Crop'**
  String get select_a_crop;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @welcome_to_herbtrace.
  ///
  /// In en, this message translates to:
  /// **'Welcome to herbtrace'**
  String get welcome_to_herbtrace;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @end.
  ///
  /// In en, this message translates to:
  /// **'End'**
  String get end;

  /// No description provided for @select_language.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get select_language;

  /// No description provided for @add_crop.
  ///
  /// In en, this message translates to:
  /// **'Add Crop'**
  String get add_crop;

  /// No description provided for @no_active_transactions.
  ///
  /// In en, this message translates to:
  /// **'No active transactions'**
  String get no_active_transactions;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @scan.
  ///
  /// In en, this message translates to:
  /// **'Scan'**
  String get scan;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @transaction_history.
  ///
  /// In en, this message translates to:
  /// **'Transaction History'**
  String get transaction_history;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @change_language.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get change_language;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// The common name for Withania somnifera
  ///
  /// In en, this message translates to:
  /// **'Ashwagandha'**
  String get cropNameAshwagandha;

  /// The common name for Bacopa monnieri
  ///
  /// In en, this message translates to:
  /// **'Brahmi'**
  String get cropNameBrahmi;

  /// The common name for Tinospora cordifolia
  ///
  /// In en, this message translates to:
  /// **'Giloy'**
  String get cropNameGiloy;

  /// The common name for Ocimum sanctum
  ///
  /// In en, this message translates to:
  /// **'Tulsi'**
  String get cropNameTulsi;

  /// The common name for Terminalia arjuna
  ///
  /// In en, this message translates to:
  /// **'Arjuna'**
  String get cropNameArjuna;

  /// Title for the supply chain transfer screen
  ///
  /// In en, this message translates to:
  /// **'Supply Chain Transfer'**
  String get supply_chain_transfer;

  /// Instructions for transferring batch in supply chain
  ///
  /// In en, this message translates to:
  /// **'Transfer Batch to Next Stage'**
  String get transfer_instructions;

  /// Instructions for QR code scanning
  ///
  /// In en, this message translates to:
  /// **'Ask the next stage handler to scan this QR code to verify and accept the batch transfer'**
  String get scan_qr_instructions;

  /// Label for batch identifier
  ///
  /// In en, this message translates to:
  /// **'Batch ID'**
  String get batch_id_label;

  /// Button text for confirming transfer
  ///
  /// In en, this message translates to:
  /// **'I confirm this transfer'**
  String get transfer_confirmation;

  /// Title for end transaction dialog
  ///
  /// In en, this message translates to:
  /// **'End Transaction'**
  String get endTransaction;

  /// Cancel button text
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Confirm button text
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// Label for crop name
  ///
  /// In en, this message translates to:
  /// **'Crop'**
  String get cropLabel;

  /// Label for duration
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get durationLabel;

  /// Label for quantity
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantityLabel;

  /// Quantity with unit
  ///
  /// In en, this message translates to:
  /// **'{quantity} kg'**
  String quantityUnit(double quantity);

  /// Duration format string
  ///
  /// In en, this message translates to:
  /// **'{hours, plural, =0{} =1{1 hour } other{{hours} hours }}{minutes, plural, =1{1 minute} other{{minutes} minutes}}'**
  String durationFormat(num hours, num minutes);

  /// Title for transaction details screen
  ///
  /// In en, this message translates to:
  /// **'Transaction Details'**
  String get transactionDetails;

  /// Section title for crop information
  ///
  /// In en, this message translates to:
  /// **'Crop Information'**
  String get cropInformation;

  /// Label for crop common name
  ///
  /// In en, this message translates to:
  /// **'Common Name'**
  String get commonName;

  /// Label for scientific name
  ///
  /// In en, this message translates to:
  /// **'Scientific Name'**
  String get scientificName;

  /// Label for crop category
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// Label for batch identifier
  ///
  /// In en, this message translates to:
  /// **'Batch ID'**
  String get batchId;

  /// Label for start time
  ///
  /// In en, this message translates to:
  /// **'Start Time'**
  String get startTime;

  /// Section title for quality parameters
  ///
  /// In en, this message translates to:
  /// **'Quality Parameters'**
  String get qualityParameters;

  /// Section title for approved collection regions
  ///
  /// In en, this message translates to:
  /// **'Approved Collection Regions'**
  String get approvedCollectionRegions;

  /// Section title for additional information
  ///
  /// In en, this message translates to:
  /// **'Additional Information'**
  String get additionalInformation;

  /// Label for allowed harvest months
  ///
  /// In en, this message translates to:
  /// **'Allowed Harvest Months'**
  String get allowedHarvestMonths;

  /// Label for restricted months
  ///
  /// In en, this message translates to:
  /// **'Restricted Months'**
  String get restrictedMonths;

  /// Label for maximum wild collection
  ///
  /// In en, this message translates to:
  /// **'Max Wild Collection'**
  String get maxWildCollection;

  /// Label for recommended practice
  ///
  /// In en, this message translates to:
  /// **'Recommended Practice'**
  String get recommendedPractice;

  /// Section title for sustainability notes
  ///
  /// In en, this message translates to:
  /// **'Sustainability Notes'**
  String get sustainabilityNotes;

  /// Label for maximum moisture percentage
  ///
  /// In en, this message translates to:
  /// **'Max Moisture %'**
  String get maxMoisturePercent;

  /// Label for minimum root diameter in millimeters
  ///
  /// In en, this message translates to:
  /// **'Min Root Diameter (mm)'**
  String get rootDiameterMinMm;

  /// Label for minimum withanolide content percentage
  ///
  /// In en, this message translates to:
  /// **'Min Withanolide %'**
  String get withanolideContentMinPercent;

  /// Label for pesticide residue limit
  ///
  /// In en, this message translates to:
  /// **'Pesticide Residue Limit'**
  String get pesticideResidueLimit;

  /// Label for heavy metals limit
  ///
  /// In en, this message translates to:
  /// **'Heavy Metals Limit'**
  String get heavyMetalsLimit;

  /// Label for DNA authentication
  ///
  /// In en, this message translates to:
  /// **'DNA Authentication'**
  String get dnaAuthentication;

  /// Label for minimum bacoside content percentage
  ///
  /// In en, this message translates to:
  /// **'Min Bacoside %'**
  String get bacosideContentMinPercent;

  /// Label for minimum berberine content percentage
  ///
  /// In en, this message translates to:
  /// **'Min Berberine %'**
  String get berberineContentMinPercent;

  /// Label for minimum essential oil content percentage
  ///
  /// In en, this message translates to:
  /// **'Min Essential Oil %'**
  String get essentialOilContentMinPercent;

  /// Label for minimum tannins content percentage
  ///
  /// In en, this message translates to:
  /// **'Min Tannins %'**
  String get tanninsContentMinPercent;

  /// Subtitle text for welcome onboarding page
  ///
  /// In en, this message translates to:
  /// **'Secure and transparent tracking of medicinal plants from farm to pharmacy'**
  String get onboarding_welcome_subtitle;

  /// Button text to begin onboarding
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get get_started;

  /// Feature label for tracking
  ///
  /// In en, this message translates to:
  /// **'Track'**
  String get track;

  /// Feature label for verification
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// Feature label for sustainability
  ///
  /// In en, this message translates to:
  /// **'Sustain'**
  String get sustain;

  /// Title for language selection screen
  ///
  /// In en, this message translates to:
  /// **'Choose Your Language'**
  String get choose_your_language;

  /// Subtitle for language selection screen
  ///
  /// In en, this message translates to:
  /// **'Select your preferred language to continue'**
  String get language_selection_subtitle;

  /// Title for supply chain overview page
  ///
  /// In en, this message translates to:
  /// **'Supply Chain Journey'**
  String get supply_chain_journey;

  /// Subtitle for supply chain overview page
  ///
  /// In en, this message translates to:
  /// **'See how your medicinal plants move through the supply chain'**
  String get supply_chain_subtitle;

  /// Label for farmer/wild collector role
  ///
  /// In en, this message translates to:
  /// **'Farmer/Wild Collector'**
  String get farmer_wild_collector;

  /// Label for transporter role
  ///
  /// In en, this message translates to:
  /// **'Transporter'**
  String get transporter;

  /// Label for processor role
  ///
  /// In en, this message translates to:
  /// **'Processor'**
  String get processor;

  /// Label for laboratory role
  ///
  /// In en, this message translates to:
  /// **'Laboratory'**
  String get laboratory;

  /// Label for manufacturer role
  ///
  /// In en, this message translates to:
  /// **'Manufacturer'**
  String get manufacturer;

  /// Label for packer role
  ///
  /// In en, this message translates to:
  /// **'Packer'**
  String get packer;

  /// Title for farmer guidance page
  ///
  /// In en, this message translates to:
  /// **'Farmer Guidance'**
  String get farmer_guidance_title;

  /// Subtitle for farmer guidance page
  ///
  /// In en, this message translates to:
  /// **'Learn how to add crops and manage your harvest'**
  String get farmer_guidance_subtitle;

  /// Step label for adding crop
  ///
  /// In en, this message translates to:
  /// **'Add Crop'**
  String get add_crop_step;

  /// Step label for monitoring growth
  ///
  /// In en, this message translates to:
  /// **'Monitor Growth'**
  String get monitor_growth;

  /// Step label for harvest time
  ///
  /// In en, this message translates to:
  /// **'Harvest Time'**
  String get harvest_time;

  /// Title for QR process page
  ///
  /// In en, this message translates to:
  /// **'QR Code Process'**
  String get qr_process_title;

  /// Subtitle for QR process page
  ///
  /// In en, this message translates to:
  /// **'Learn how the handover process works'**
  String get qr_process_subtitle;

  /// Step label for generating QR code
  ///
  /// In en, this message translates to:
  /// **'Generate QR'**
  String get generate_qr;

  /// Step label for scanning and verifying
  ///
  /// In en, this message translates to:
  /// **'Scan & Verify'**
  String get scan_verify;

  /// Step label for completed transfer
  ///
  /// In en, this message translates to:
  /// **'Transfer Complete'**
  String get transfer_complete;

  /// Title for get started page
  ///
  /// In en, this message translates to:
  /// **'Ready to Start Your Journey?'**
  String get ready_to_start;

  /// Subtitle for get started page
  ///
  /// In en, this message translates to:
  /// **'Begin tracking your herbal products through the complete supply chain with transparency and trust.'**
  String get get_started_subtitle;

  /// Feature highlight for quick transactions
  ///
  /// In en, this message translates to:
  /// **'Quick Transactions'**
  String get quick_transactions;

  /// Feature highlight for full traceability
  ///
  /// In en, this message translates to:
  /// **'Full Traceability'**
  String get full_traceability;

  /// Feature highlight for secure blockchain
  ///
  /// In en, this message translates to:
  /// **'Secure Blockchain'**
  String get secure_blockchain;

  /// Button text for get started
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get get_started_button;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'hi', 'kn'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
    case 'kn':
      return AppLocalizationsKn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
