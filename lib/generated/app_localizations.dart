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
