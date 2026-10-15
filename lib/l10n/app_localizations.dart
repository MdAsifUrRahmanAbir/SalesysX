import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_bn.dart';
import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_ur.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
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

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
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
    Locale('bn'),
    Locale('en'),
    Locale('hi'),
    Locale('ur'),
  ];

  /// No description provided for @appTagline.
  ///
  /// In en, this message translates to:
  /// **'Next-Gen Business Platform'**
  String get appTagline;

  /// No description provided for @connectingToServers.
  ///
  /// In en, this message translates to:
  /// **'Connecting to secure servers...'**
  String get connectingToServers;

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'SalesysX'**
  String get appName;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @welcomeToApp.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Advance POS Sales'**
  String get welcomeToApp;

  /// No description provided for @welcomeToAppSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Scan products, search inventory, view stock reports, and invoice history with ease.'**
  String get welcomeToAppSubtitle;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBack;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddress;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'admin@enterprise.com'**
  String get emailHint;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'secret_password'**
  String get passwordHint;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember Me'**
  String get rememberMe;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @orContinueWith.
  ///
  /// In en, this message translates to:
  /// **'or continue with'**
  String get orContinueWith;

  /// No description provided for @google.
  ///
  /// In en, this message translates to:
  /// **'Google'**
  String get google;

  /// No description provided for @apple.
  ///
  /// In en, this message translates to:
  /// **'Apple'**
  String get apple;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get dontHaveAccount;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailRequired;

  /// No description provided for @emailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get emailInvalid;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequired;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @fullNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Full name is required'**
  String get fullNameRequired;

  /// No description provided for @confirmPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get confirmPasswordRequired;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @changePasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePasswordTitle;

  /// No description provided for @currentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get currentPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// No description provided for @currentPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Current password is required'**
  String get currentPasswordRequired;

  /// No description provided for @currentPasswordIncorrect.
  ///
  /// In en, this message translates to:
  /// **'Current password is incorrect.'**
  String get currentPasswordIncorrect;

  /// No description provided for @newPasswordSameAsCurrent.
  ///
  /// In en, this message translates to:
  /// **'New password must be different from current password'**
  String get newPasswordSameAsCurrent;

  /// No description provided for @privacyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get privacyTitle;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'App preferences, account management & security'**
  String get settingsSubtitle;

  /// No description provided for @editProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfileTitle;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @changeProfilePhoto.
  ///
  /// In en, this message translates to:
  /// **'Change Profile Photo'**
  String get changeProfilePhoto;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @designationTitle2.
  ///
  /// In en, this message translates to:
  /// **'Designation / Title'**
  String get designationTitle2;

  /// No description provided for @bio.
  ///
  /// In en, this message translates to:
  /// **'Bio'**
  String get bio;

  /// No description provided for @filterToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get filterToday;

  /// No description provided for @filterThisWeek.
  ///
  /// In en, this message translates to:
  /// **'This Week'**
  String get filterThisWeek;

  /// No description provided for @filterThisMonth.
  ///
  /// In en, this message translates to:
  /// **'This Month'**
  String get filterThisMonth;

  /// No description provided for @notificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsTitle;

  /// No description provided for @markAllAsRead.
  ///
  /// In en, this message translates to:
  /// **'Mark All as Read'**
  String get markAllAsRead;

  /// No description provided for @filterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get filterAll;

  /// No description provided for @filterUnread.
  ///
  /// In en, this message translates to:
  /// **'Unread'**
  String get filterUnread;

  /// No description provided for @notificationsTip.
  ///
  /// In en, this message translates to:
  /// **'Tip: Swipe left on a notification to archive or configure triggers.'**
  String get notificationsTip;

  /// No description provided for @appearanceSection.
  ///
  /// In en, this message translates to:
  /// **'APPEARANCE'**
  String get appearanceSection;

  /// No description provided for @notificationsSection.
  ///
  /// In en, this message translates to:
  /// **'NOTIFICATIONS'**
  String get notificationsSection;

  /// No description provided for @securitySection.
  ///
  /// In en, this message translates to:
  /// **'SECURITY'**
  String get securitySection;

  /// No description provided for @generalSection.
  ///
  /// In en, this message translates to:
  /// **'GENERAL'**
  String get generalSection;

  /// No description provided for @developerSection.
  ///
  /// In en, this message translates to:
  /// **'DEVELOPER'**
  String get developerSection;

  /// No description provided for @resetDemoDataTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset Demo Data'**
  String get resetDemoDataTitle;

  /// No description provided for @resetDemoDataConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'This wipes all users, teams, outlets, products, targets, sales, and notifications, then reseeds fresh demo data dated to the current month. This cannot be undone.'**
  String get resetDemoDataConfirmMessage;

  /// No description provided for @resetDemoDataSuccess.
  ///
  /// In en, this message translates to:
  /// **'Demo data reset. Please sign in again.'**
  String get resetDemoDataSuccess;

  /// No description provided for @legalSection.
  ///
  /// In en, this message translates to:
  /// **'LEGAL'**
  String get legalSection;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @appTheme.
  ///
  /// In en, this message translates to:
  /// **'App Theme'**
  String get appTheme;

  /// No description provided for @pushNotifications.
  ///
  /// In en, this message translates to:
  /// **'Push Notifications'**
  String get pushNotifications;

  /// No description provided for @emailNotifications.
  ///
  /// In en, this message translates to:
  /// **'Email Notifications'**
  String get emailNotifications;

  /// No description provided for @smsAlerts.
  ///
  /// In en, this message translates to:
  /// **'SMS Alerts'**
  String get smsAlerts;

  /// No description provided for @biometricAuth.
  ///
  /// In en, this message translates to:
  /// **'Biometric Auth'**
  String get biometricAuth;

  /// No description provided for @twoFactorAuth.
  ///
  /// In en, this message translates to:
  /// **'Two-Factor Auth'**
  String get twoFactorAuth;

  /// No description provided for @activeSessions.
  ///
  /// In en, this message translates to:
  /// **'Active Sessions'**
  String get activeSessions;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @region.
  ///
  /// In en, this message translates to:
  /// **'Region'**
  String get region;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// No description provided for @openSourceLicenses.
  ///
  /// In en, this message translates to:
  /// **'Open Source Licenses'**
  String get openSourceLicenses;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logOut;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @termsPrivacyTitle.
  ///
  /// In en, this message translates to:
  /// **'Terms & Privacy'**
  String get termsPrivacyTitle;

  /// No description provided for @termsLastUpdated.
  ///
  /// In en, this message translates to:
  /// **'Last updated: January 15, 2026'**
  String get termsLastUpdated;

  /// No description provided for @termsSection1Title.
  ///
  /// In en, this message translates to:
  /// **'1. Introduction'**
  String get termsSection1Title;

  /// No description provided for @termsSection1Body.
  ///
  /// In en, this message translates to:
  /// **'Welcome to EnterpriseSuite. By accessing, deploying, or utilizing our cloud platform and integrated services, you agree to be bound by these unified terms. Please read this agreement carefully.'**
  String get termsSection1Body;

  /// No description provided for @termsSection2Title.
  ///
  /// In en, this message translates to:
  /// **'2. Data Collection'**
  String get termsSection2Title;

  /// No description provided for @termsSection2Body.
  ///
  /// In en, this message translates to:
  /// **'To provision high-performance node servers, maintain container security, and optimize query latency, our system architecture collects secure operational metadata:'**
  String get termsSection2Body;

  /// No description provided for @termsSection3Title.
  ///
  /// In en, this message translates to:
  /// **'3. Usage Rights'**
  String get termsSection3Title;

  /// No description provided for @termsSection3Body.
  ///
  /// In en, this message translates to:
  /// **'EnterpriseSuite grants you a restricted, non-exclusive, revocable license to access our platform solely for authorized business operations. All dashboard templates, metadata pipelines, and user provisioning are governed by your subscription agreement tiers.'**
  String get termsSection3Body;

  /// No description provided for @termsSection4Title.
  ///
  /// In en, this message translates to:
  /// **'4. Privacy'**
  String get termsSection4Title;

  /// No description provided for @termsSection4Body.
  ///
  /// In en, this message translates to:
  /// **'We operate on a zero-trust architecture. All client properties, custom parameters, database schema descriptions, and system integrations remain your proprietary data. EnterpriseSuite does not sell, lease, or monetize organizational usage patterns.'**
  String get termsSection4Body;

  /// No description provided for @termsSection5Title.
  ///
  /// In en, this message translates to:
  /// **'5. Contact Us'**
  String get termsSection5Title;

  /// No description provided for @termsSection5Body.
  ///
  /// In en, this message translates to:
  /// **'For policy concerns, data extraction requests, or server security auditing parameters, please contact our specialized compliance division:'**
  String get termsSection5Body;

  /// No description provided for @termsContactName.
  ///
  /// In en, this message translates to:
  /// **'EnterpriseSuite Compliance'**
  String get termsContactName;

  /// No description provided for @termsContactEmail.
  ///
  /// In en, this message translates to:
  /// **'Email: legal@enterprisesuite.com'**
  String get termsContactEmail;

  /// No description provided for @termsContactSla.
  ///
  /// In en, this message translates to:
  /// **'Response SLA: Within 2 business days'**
  String get termsContactSla;

  /// No description provided for @helpSupportTitle.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpSupportTitle;

  /// No description provided for @searchFaqsHint.
  ///
  /// In en, this message translates to:
  /// **'Search FAQs...'**
  String get searchFaqsHint;

  /// No description provided for @faqSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Frequently Asked Questions'**
  String get faqSectionTitle;

  /// No description provided for @submitTicket.
  ///
  /// In en, this message translates to:
  /// **'Submit a Ticket'**
  String get submitTicket;

  /// No description provided for @contactSupportTitle.
  ///
  /// In en, this message translates to:
  /// **'Contact Support'**
  String get contactSupportTitle;

  /// No description provided for @liveChat.
  ///
  /// In en, this message translates to:
  /// **'Live Chat'**
  String get liveChat;

  /// No description provided for @chatNow.
  ///
  /// In en, this message translates to:
  /// **'Chat Now'**
  String get chatNow;

  /// No description provided for @emailContact.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailContact;

  /// No description provided for @callContact.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get callContact;

  /// No description provided for @notFoundCode.
  ///
  /// In en, this message translates to:
  /// **'404'**
  String get notFoundCode;

  /// No description provided for @notFoundTitle.
  ///
  /// In en, this message translates to:
  /// **'Page Not Found'**
  String get notFoundTitle;

  /// No description provided for @notFoundSubtitle.
  ///
  /// In en, this message translates to:
  /// **'The page you\'re looking for doesn\'t exist or has been moved.'**
  String get notFoundSubtitle;

  /// No description provided for @backToHome.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get backToHome;

  /// No description provided for @noInternetTitle.
  ///
  /// In en, this message translates to:
  /// **'No Internet Connection'**
  String get noInternetTitle;

  /// No description provided for @noInternetSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Please check your network settings and try again.'**
  String get noInternetSubtitle;

  /// No description provided for @checkConnection.
  ///
  /// In en, this message translates to:
  /// **'Check Connection'**
  String get checkConnection;

  /// No description provided for @workOffline.
  ///
  /// In en, this message translates to:
  /// **'Work Offline'**
  String get workOffline;

  /// No description provided for @maintenanceTitle.
  ///
  /// In en, this message translates to:
  /// **'Under Maintenance'**
  String get maintenanceTitle;

  /// No description provided for @maintenanceSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We\'re performing scheduled maintenance to improve your experience.'**
  String get maintenanceSubtitle;

  /// No description provided for @notifyMeWhenReady.
  ///
  /// In en, this message translates to:
  /// **'Notify Me When Ready'**
  String get notifyMeWhenReady;

  /// No description provided for @errorTitle.
  ///
  /// In en, this message translates to:
  /// **'Something Went Wrong'**
  String get errorTitle;

  /// No description provided for @errorSubtitle.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred. Please try again.'**
  String get errorSubtitle;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @reportIssue.
  ///
  /// In en, this message translates to:
  /// **'Report Issue'**
  String get reportIssue;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @exitAppTitle.
  ///
  /// In en, this message translates to:
  /// **'Exit App?'**
  String get exitAppTitle;

  /// No description provided for @exitAppMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to exit the app?'**
  String get exitAppMessage;

  /// No description provided for @exitAppConfirm.
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get exitAppConfirm;

  /// No description provided for @exitAppCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get exitAppCancel;

  /// No description provided for @noInternetBannerMessage.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get noInternetBannerMessage;

  /// No description provided for @dailyTargetSubtitle.
  ///
  /// In en, this message translates to:
  /// **'{achieved} of {target} target achieved'**
  String dailyTargetSubtitle(String achieved, String target);

  /// No description provided for @unitsSoldLabel.
  ///
  /// In en, this message translates to:
  /// **'{units} units sold'**
  String unitsSoldLabel(int units);

  /// No description provided for @saleMetaLabel.
  ///
  /// In en, this message translates to:
  /// **'{items} items • {timeAgo}'**
  String saleMetaLabel(int items, String timeAgo);

  /// No description provided for @skuLabel.
  ///
  /// In en, this message translates to:
  /// **'SKU: {sku}'**
  String skuLabel(String sku);

  /// No description provided for @viewCartLabel.
  ///
  /// In en, this message translates to:
  /// **'View Cart — {total}'**
  String viewCartLabel(String total);

  /// No description provided for @discountLabel.
  ///
  /// In en, this message translates to:
  /// **'Discount ({percent}%)'**
  String discountLabel(int percent);

  /// No description provided for @vatTaxLabel.
  ///
  /// In en, this message translates to:
  /// **'VAT / Tax ({percent}%)'**
  String vatTaxLabel(int percent);

  /// No description provided for @eachPriceLabel.
  ///
  /// In en, this message translates to:
  /// **'{price} each'**
  String eachPriceLabel(String price);

  /// No description provided for @paymentCollectedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Amount received: {amount}'**
  String paymentCollectedSubtitle(String amount);

  /// No description provided for @stockPcsLabel.
  ///
  /// In en, this message translates to:
  /// **'{stock} pcs'**
  String stockPcsLabel(int stock);

  /// No description provided for @productAddedMessage.
  ///
  /// In en, this message translates to:
  /// **'Added: {name}'**
  String productAddedMessage(String name);

  /// No description provided for @productOutOfStockMessage.
  ///
  /// In en, this message translates to:
  /// **'Out of stock: {name}'**
  String productOutOfStockMessage(String name);

  /// No description provided for @productNotFoundMessage.
  ///
  /// In en, this message translates to:
  /// **'No product found for code {code}'**
  String productNotFoundMessage(String code);

  /// No description provided for @salesmanGreeting.
  ///
  /// In en, this message translates to:
  /// **'Assalamu Alaikum,'**
  String get salesmanGreeting;

  /// No description provided for @createNewSaleEntry.
  ///
  /// In en, this message translates to:
  /// **'Create New Sale Entry'**
  String get createNewSaleEntry;

  /// No description provided for @monthlyTarget.
  ///
  /// In en, this message translates to:
  /// **'MONTHLY TARGET'**
  String get monthlyTarget;

  /// No description provided for @achievedLabel.
  ///
  /// In en, this message translates to:
  /// **'ACHIEVED'**
  String get achievedLabel;

  /// No description provided for @achieved.
  ///
  /// In en, this message translates to:
  /// **'Achieved'**
  String get achieved;

  /// No description provided for @remaining.
  ///
  /// In en, this message translates to:
  /// **'Remaining'**
  String get remaining;

  /// No description provided for @todaysSales.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Sales'**
  String get todaysSales;

  /// No description provided for @fromYesterdaySuffix.
  ///
  /// In en, this message translates to:
  /// **'from yesterday'**
  String get fromYesterdaySuffix;

  /// No description provided for @toReachTarget.
  ///
  /// In en, this message translates to:
  /// **'To reach 100%'**
  String get toReachTarget;

  /// No description provided for @dailyRunRate.
  ///
  /// In en, this message translates to:
  /// **'Daily Run Rate'**
  String get dailyRunRate;

  /// No description provided for @targetRunRateRequired.
  ///
  /// In en, this message translates to:
  /// **'Target Run Rate Required:'**
  String get targetRunRateRequired;

  /// No description provided for @currentAvgRunRate.
  ///
  /// In en, this message translates to:
  /// **'Current Avg Run Rate:'**
  String get currentAvgRunRate;

  /// No description provided for @onTrackToAchieveTarget.
  ///
  /// In en, this message translates to:
  /// **'On track to achieve target this month'**
  String get onTrackToAchieveTarget;

  /// No description provided for @offTrackForTarget.
  ///
  /// In en, this message translates to:
  /// **'Behind pace to reach target this month'**
  String get offTrackForTarget;

  /// No description provided for @perDaySuffix.
  ///
  /// In en, this message translates to:
  /// **'/day'**
  String get perDaySuffix;

  /// No description provided for @daysLeft.
  ///
  /// In en, this message translates to:
  /// **'{days} Days Left'**
  String daysLeft(int days);

  /// No description provided for @newSaleEntryTitle.
  ///
  /// In en, this message translates to:
  /// **'New Sales Entry'**
  String get newSaleEntryTitle;

  /// No description provided for @selectOutlet.
  ///
  /// In en, this message translates to:
  /// **'Select Outlet'**
  String get selectOutlet;

  /// No description provided for @selectCategory.
  ///
  /// In en, this message translates to:
  /// **'Select Category'**
  String get selectCategory;

  /// No description provided for @selectProduct.
  ///
  /// In en, this message translates to:
  /// **'Select Product'**
  String get selectProduct;

  /// No description provided for @selectProductPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Select a product'**
  String get selectProductPlaceholder;

  /// No description provided for @quantityUnits.
  ///
  /// In en, this message translates to:
  /// **'Quantity (Units)'**
  String get quantityUnits;

  /// No description provided for @calculatedPriceLabel.
  ///
  /// In en, this message translates to:
  /// **'CALCULATED PRICE'**
  String get calculatedPriceLabel;

  /// No description provided for @submitSaleEntry.
  ///
  /// In en, this message translates to:
  /// **'Submit Sale Entry'**
  String get submitSaleEntry;

  /// No description provided for @saleRecordedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Sale recorded successfully.'**
  String get saleRecordedSuccess;

  /// No description provided for @saleEntryHelpText.
  ///
  /// In en, this message translates to:
  /// **'Pick the outlet and product, set quantity and discount, then submit. The amount is quantity × price minus discount.'**
  String get saleEntryHelpText;

  /// No description provided for @todaysEntries.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Entries'**
  String get todaysEntries;

  /// No description provided for @calculatedPriceBreakdown.
  ///
  /// In en, this message translates to:
  /// **'{quantity} Units × {unitPriceFormatted} - {discountFormatted} discount'**
  String calculatedPriceBreakdown(
    int quantity,
    String unitPriceFormatted,
    String discountFormatted,
  );

  /// No description provided for @entryMetaLine.
  ///
  /// In en, this message translates to:
  /// **'{location} • {itemCount} Items • {time}'**
  String entryMetaLine(String location, int itemCount, String time);

  /// No description provided for @outletsAndCustomersTitle.
  ///
  /// In en, this message translates to:
  /// **'Outlets & Customers'**
  String get outletsAndCustomersTitle;

  /// No description provided for @searchOutletsPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Search outlets, owner name...'**
  String get searchOutletsPlaceholder;

  /// No description provided for @filterActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get filterActive;

  /// No description provided for @filterNew.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get filterNew;

  /// No description provided for @filterPotential.
  ///
  /// In en, this message translates to:
  /// **'Potential'**
  String get filterPotential;

  /// No description provided for @ownerLabel.
  ///
  /// In en, this message translates to:
  /// **'Owner:'**
  String get ownerLabel;

  /// No description provided for @areaRouteLabel.
  ///
  /// In en, this message translates to:
  /// **'Area / Route:'**
  String get areaRouteLabel;

  /// No description provided for @lastVisitLabel.
  ///
  /// In en, this message translates to:
  /// **'Last Visit:'**
  String get lastVisitLabel;

  /// No description provided for @lastOrderAmountLabel.
  ///
  /// In en, this message translates to:
  /// **'Last Order Amount:'**
  String get lastOrderAmountLabel;

  /// No description provided for @addressLabel.
  ///
  /// In en, this message translates to:
  /// **'Address:'**
  String get addressLabel;

  /// No description provided for @phoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone:'**
  String get phoneLabel;

  /// No description provided for @recentSalesTitle.
  ///
  /// In en, this message translates to:
  /// **'Recent Sales'**
  String get recentSalesTitle;

  /// No description provided for @noRecentSalesYet.
  ///
  /// In en, this message translates to:
  /// **'No sales recorded at this outlet yet.'**
  String get noRecentSalesYet;

  /// No description provided for @notVisitedYet.
  ///
  /// In en, this message translates to:
  /// **'Not visited yet'**
  String get notVisitedYet;

  /// No description provided for @recordSaleAction.
  ///
  /// In en, this message translates to:
  /// **'Record Sale'**
  String get recordSaleAction;

  /// No description provided for @callAction.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get callAction;

  /// No description provided for @managedFromAdminPanel.
  ///
  /// In en, this message translates to:
  /// **'Managed from the Web Admin Panel by your company Admin.'**
  String get managedFromAdminPanel;

  /// No description provided for @addOutletTitle.
  ///
  /// In en, this message translates to:
  /// **'Add New Outlet'**
  String get addOutletTitle;

  /// No description provided for @addNewOutletOption.
  ///
  /// In en, this message translates to:
  /// **'+ Add New Outlet / Shop'**
  String get addNewOutletOption;

  /// No description provided for @outletNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Shop Name'**
  String get outletNameLabel;

  /// No description provided for @ownerNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Owner Name'**
  String get ownerNameLabel;

  /// No description provided for @addressFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get addressFieldLabel;

  /// No description provided for @areaRouteFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Area / Route'**
  String get areaRouteFieldLabel;

  /// No description provided for @addOutletAction.
  ///
  /// In en, this message translates to:
  /// **'Add Outlet'**
  String get addOutletAction;

  /// No description provided for @outletAddedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Outlet added.'**
  String get outletAddedSuccess;

  /// No description provided for @newSaleAction.
  ///
  /// In en, this message translates to:
  /// **'New Sale'**
  String get newSaleAction;

  /// No description provided for @teamSalesTitle.
  ///
  /// In en, this message translates to:
  /// **'Team Sales'**
  String get teamSalesTitle;

  /// No description provided for @teamReportsTitle.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get teamReportsTitle;

  /// No description provided for @salesmanRankingTitle.
  ///
  /// In en, this message translates to:
  /// **'Salesman Ranking'**
  String get salesmanRankingTitle;

  /// No description provided for @salesByCategoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Sales by Category'**
  String get salesByCategoryTitle;

  /// No description provided for @targetPerformanceTitle.
  ///
  /// In en, this message translates to:
  /// **'Target Performance'**
  String get targetPerformanceTitle;

  /// No description provided for @statusAtRisk.
  ///
  /// In en, this message translates to:
  /// **'At Risk'**
  String get statusAtRisk;

  /// No description provided for @statusOnTrack.
  ///
  /// In en, this message translates to:
  /// **'On Track'**
  String get statusOnTrack;

  /// No description provided for @benchmarkComparisons.
  ///
  /// In en, this message translates to:
  /// **'Benchmark Comparisons'**
  String get benchmarkComparisons;

  /// No description provided for @periodProgress.
  ///
  /// In en, this message translates to:
  /// **'Period Progress:'**
  String get periodProgress;

  /// No description provided for @expectedAchievement.
  ///
  /// In en, this message translates to:
  /// **'Expected Achievement:'**
  String get expectedAchievement;

  /// No description provided for @requiredDailySales.
  ///
  /// In en, this message translates to:
  /// **'Required Daily Sales:'**
  String get requiredDailySales;

  /// No description provided for @dailyTrendThisWeek.
  ///
  /// In en, this message translates to:
  /// **'Daily Trend (This Week)'**
  String get dailyTrendThisWeek;

  /// No description provided for @workingDaysLeftWarning.
  ///
  /// In en, this message translates to:
  /// **'⚠️ {days} Working Days Left. Run-rate adjustment recommended.'**
  String workingDaysLeftWarning(int days);

  /// No description provided for @dailyTargetLabel.
  ///
  /// In en, this message translates to:
  /// **'Target: {amount}/day'**
  String dailyTargetLabel(String amount);

  /// No description provided for @profileRoleSalesman.
  ///
  /// In en, this message translates to:
  /// **'Salesman'**
  String get profileRoleSalesman;

  /// No description provided for @employeeIdPrefix.
  ///
  /// In en, this message translates to:
  /// **'ID:'**
  String get employeeIdPrefix;

  /// No description provided for @thisMonthLabel.
  ///
  /// In en, this message translates to:
  /// **'THIS MONTH'**
  String get thisMonthLabel;

  /// No description provided for @customersLabel.
  ///
  /// In en, this message translates to:
  /// **'CUSTOMERS'**
  String get customersLabel;

  /// No description provided for @salesTodayLabel.
  ///
  /// In en, this message translates to:
  /// **'SALES TODAY'**
  String get salesTodayLabel;

  /// No description provided for @targetShort.
  ///
  /// In en, this message translates to:
  /// **'Target'**
  String get targetShort;

  /// No description provided for @activeOutlets.
  ///
  /// In en, this message translates to:
  /// **'Active Outlets'**
  String get activeOutlets;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @mySalesReportTitle.
  ///
  /// In en, this message translates to:
  /// **'My Sales Report'**
  String get mySalesReportTitle;

  /// No description provided for @mySalesReportSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View daily orders and stats'**
  String get mySalesReportSubtitle;

  /// No description provided for @myAchievementTitle.
  ///
  /// In en, this message translates to:
  /// **'My Achievement'**
  String get myAchievementTitle;

  /// No description provided for @myAchievementSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Detailed target history'**
  String get myAchievementSubtitle;

  /// No description provided for @logoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logoutTitle;

  /// No description provided for @logoutSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign out of device'**
  String get logoutSubtitle;

  /// No description provided for @teamAndDivision.
  ///
  /// In en, this message translates to:
  /// **'{team} • {division}'**
  String teamAndDivision(String team, String division);

  /// No description provided for @teamSizeLabel.
  ///
  /// In en, this message translates to:
  /// **'Team Size'**
  String get teamSizeLabel;

  /// No description provided for @teamDashboardMenuTitle.
  ///
  /// In en, this message translates to:
  /// **'Team Dashboard'**
  String get teamDashboardMenuTitle;

  /// No description provided for @teamDashboardMenuSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Target, achievement & roster'**
  String get teamDashboardMenuSubtitle;

  /// No description provided for @teamSalesLogMenuTitle.
  ///
  /// In en, this message translates to:
  /// **'Team Sales Log'**
  String get teamSalesLogMenuTitle;

  /// No description provided for @teamSalesLogMenuSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Every team member\'s recorded sales'**
  String get teamSalesLogMenuSubtitle;

  /// No description provided for @teamReportsMenuTitle.
  ///
  /// In en, this message translates to:
  /// **'Team Reports'**
  String get teamReportsMenuTitle;

  /// No description provided for @teamReportsMenuSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Ranking & sales by category'**
  String get teamReportsMenuSubtitle;

  /// No description provided for @membersSuffix.
  ///
  /// In en, this message translates to:
  /// **'Members'**
  String get membersSuffix;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navSales.
  ///
  /// In en, this message translates to:
  /// **'Sales'**
  String get navSales;

  /// No description provided for @navCustomers.
  ///
  /// In en, this message translates to:
  /// **'Customers'**
  String get navCustomers;

  /// No description provided for @navTarget.
  ///
  /// In en, this message translates to:
  /// **'Target'**
  String get navTarget;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @teamTargetAndPerformance.
  ///
  /// In en, this message translates to:
  /// **'TEAM TARGET & PERFORMANCE'**
  String get teamTargetAndPerformance;

  /// No description provided for @totalTargetLabel.
  ///
  /// In en, this message translates to:
  /// **'TOTAL TARGET'**
  String get totalTargetLabel;

  /// No description provided for @totalMembersLabel.
  ///
  /// In en, this message translates to:
  /// **'Total Members'**
  String get totalMembersLabel;

  /// No description provided for @activeTodayLabel.
  ///
  /// In en, this message translates to:
  /// **'Active Today'**
  String get activeTodayLabel;

  /// No description provided for @memberPerformanceTitle.
  ///
  /// In en, this message translates to:
  /// **'Member Performance'**
  String get memberPerformanceTitle;

  /// No description provided for @viewAllReports.
  ///
  /// In en, this message translates to:
  /// **'View All Reports'**
  String get viewAllReports;

  /// No description provided for @targetCapsLabel.
  ///
  /// In en, this message translates to:
  /// **'TARGET'**
  String get targetCapsLabel;

  /// No description provided for @todaysSaleCapsLabel.
  ///
  /// In en, this message translates to:
  /// **'TODAY\'S SALE'**
  String get todaysSaleCapsLabel;

  /// No description provided for @addMember.
  ///
  /// In en, this message translates to:
  /// **'Add Member'**
  String get addMember;

  /// No description provided for @percentReached.
  ///
  /// In en, this message translates to:
  /// **'{percent}% Reached'**
  String percentReached(int percent);

  /// No description provided for @onlineCountLabel.
  ///
  /// In en, this message translates to:
  /// **'{count} Online'**
  String onlineCountLabel(int count);

  /// No description provided for @representativesCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{{count} Representative} other{{count} Representatives}}'**
  String representativesCount(num count);

  /// No description provided for @recentSalesActivity.
  ///
  /// In en, this message translates to:
  /// **'Recent Sales Activity'**
  String get recentSalesActivity;

  /// No description provided for @monthlyTargetLabel.
  ///
  /// In en, this message translates to:
  /// **'MONTHLY TARGET'**
  String get monthlyTargetLabel;

  /// No description provided for @remainingLabel.
  ///
  /// In en, this message translates to:
  /// **'Remaining'**
  String get remainingLabel;

  /// No description provided for @achievedBadge.
  ///
  /// In en, this message translates to:
  /// **'ACHIEVED'**
  String get achievedBadge;

  /// No description provided for @todaysTargetLabel.
  ///
  /// In en, this message translates to:
  /// **'TODAY\'S TARGET'**
  String get todaysTargetLabel;

  /// No description provided for @todaysSalesLabel.
  ///
  /// In en, this message translates to:
  /// **'TODAY\'S SALES'**
  String get todaysSalesLabel;

  /// No description provided for @dailyAssignment.
  ///
  /// In en, this message translates to:
  /// **'Daily assignment'**
  String get dailyAssignment;

  /// No description provided for @call.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get call;

  /// No description provided for @message.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get message;

  /// No description provided for @fullReport.
  ///
  /// In en, this message translates to:
  /// **'Full Report'**
  String get fullReport;

  /// No description provided for @atRiskLabel.
  ///
  /// In en, this message translates to:
  /// **'AT RISK'**
  String get atRiskLabel;

  /// No description provided for @invalidCredentials.
  ///
  /// In en, this message translates to:
  /// **'Incorrect email or password.'**
  String get invalidCredentials;

  /// No description provided for @accountDisabled.
  ///
  /// In en, this message translates to:
  /// **'This account has been disabled. Contact your admin.'**
  String get accountDisabled;

  /// No description provided for @tooManyAttempts.
  ///
  /// In en, this message translates to:
  /// **'Too many attempts. Please wait and try again.'**
  String get tooManyAttempts;

  /// No description provided for @networkErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'No internet connection. Please try again.'**
  String get networkErrorMessage;

  /// No description provided for @genericLoginError.
  ///
  /// In en, this message translates to:
  /// **'Unable to sign in. Please try again.'**
  String get genericLoginError;

  /// No description provided for @adminUseWebPanel.
  ///
  /// In en, this message translates to:
  /// **'Admin accounts use the Web Admin Panel, not this app.'**
  String get adminUseWebPanel;

  /// No description provided for @navDashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get navDashboard;

  /// No description provided for @navReports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get navReports;

  /// No description provided for @reportsComingSoonTitle.
  ///
  /// In en, this message translates to:
  /// **'Reports coming soon'**
  String get reportsComingSoonTitle;

  /// No description provided for @reportsComingSoonMessage.
  ///
  /// In en, this message translates to:
  /// **'Team and company reports will appear here.'**
  String get reportsComingSoonMessage;

  /// No description provided for @logoutConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Log out?'**
  String get logoutConfirmTitle;

  /// No description provided for @logoutConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'You will need to sign in again to access your account.'**
  String get logoutConfirmMessage;
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
      <String>['bn', 'en', 'hi', 'ur'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'bn':
      return AppLocalizationsBn();
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
    case 'ur':
      return AppLocalizationsUr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
