class AppStrings {
  AppStrings._();

// ---- Added: Activity screen ----
  static const String filterToday = 'Today';
  static const String filterThisWeek = 'This Week';
  static const String filterThisMonth = 'This Month';

  // ---- Added: Notifications screen ----
  static const String notificationsTitle = 'Notifications';
  static const String markAllAsRead = 'Mark All as Read';
  static const String filterAll = 'All';
  static const String filterUnread = 'Unread';
  static const String notificationsTip = 'Tip: Swipe left on a notification to archive or configure triggers.';

  // ---- Added: Terms & Privacy screen ----
  static const String termsPrivacyTitle = 'Terms & Privacy';
  static const String termsLastUpdated = 'Last updated: January 15, 2026';
  static const String termsSection1Title = '1. Introduction';
  static const String termsSection1Body =
      'Welcome to EnterpriseSuite. By accessing, deploying, or utilizing our cloud platform '
      'and integrated services, you agree to be bound by these unified terms. Please read '
      'this agreement carefully.';
  static const String termsSection2Title = '2. Data Collection';
  static const String termsSection2Body =
      'To provision high-performance node servers, maintain container security, and '
      'optimize query latency, our system architecture collects secure operational metadata:';
  static const String termsSection3Title = '3. Usage Rights';
  static const String termsSection3Body =
      'EnterpriseSuite grants you a restricted, non-exclusive, revocable license to access '
      'our platform solely for authorized business operations. All dashboard templates, '
      'metadata pipelines, and user provisioning are governed by your subscription '
      'agreement tiers.';
  static const String termsSection4Title = '4. Privacy';
  static const String termsSection4Body =
      'We operate on a zero-trust architecture. All client properties, custom parameters, '
      'database schema descriptions, and system integrations remain your proprietary data. '
      'EnterpriseSuite does not sell, lease, or monetize organizational usage patterns.';
  static const String termsSection5Title = '5. Contact Us';
  static const String termsSection5Body =
      'For policy concerns, data extraction requests, or server security auditing '
      'parameters, please contact our specialized compliance division:';
  static const String termsContactName = 'EnterpriseSuite Compliance';
  static const String termsContactEmail = 'Email: legal@enterprisesuite.com';
  static const String termsContactSla = 'Response SLA: Within 2 business days';

  // ---- Added: Help & Support screen ----
  static const String helpSupportTitle = 'Help & Support';
  static const String searchFaqsHint = 'Search FAQs...';
  static const String faqSectionTitle = 'Frequently Asked Questions';
  static const String submitTicket = 'Submit a Ticket';
  static const String contactSupportTitle = 'Contact Support';
  static const String liveChat = 'Live Chat';
  static const String chatNow = 'Chat Now';
  static const String emailContact = 'Email';
  static const String callContact = 'Call';

  // ---- Added: Not Found screen ----
  static const String notFoundCode = '404';
  static const String notFoundTitle = 'Page Not Found';
  static const String notFoundSubtitle = "The page you're looking for doesn't exist or has been moved.";
  static const String backToHome = 'Back to Home';

  // ---- Added: No Internet screen ----
  static const String noInternetTitle = 'No Internet Connection';
  static const String noInternetSubtitle = 'Please check your network settings and try again.';
  static const String checkConnection = 'Check Connection';
  static const String workOffline = 'Work Offline';

  // ---- Added: Maintenance screen ----
  static const String maintenanceTitle = 'Under Maintenance';
  static const String maintenanceSubtitle = "We're performing scheduled maintenance to improve your experience.";
  static const String notifyMeWhenReady = 'Notify Me When Ready';

  // ---- Added: Error screen ----
  static const String errorTitle = 'Something Went Wrong';
  static const String errorSubtitle = 'An unexpected error occurred. Please try again.';
  static const String retry = 'Retry';
  static const String reportIssue = 'Report Issue';


  static const String exitAppTitle = 'Exit App?';
  static const String exitAppMessage = 'Are you sure you want to exit the app?';
  static const String exitAppConfirm = 'Exit';
  static const String exitAppCancel = 'Cancel';

  static const String noInternetBannerMessage = 'No internet connection';


  static const String salesmanGreeting = 'Assalamu Alaikum,';
  static const String createNewSaleEntry = 'Create New Sale Entry';
  static const String monthlyTarget = 'MONTHLY TARGET';
  static const String achievedLabel = 'ACHIEVED';
  static const String achieved = 'Achieved';
  static const String remaining = 'Remaining';
  static const String todaysSales = "Today's Sales";
  static const String fromYesterdaySuffix = 'from yesterday';
  static const String toReachTarget = 'To reach 100%';
  static const String dailyRunRate = 'Daily Run Rate';
  static const String targetRunRateRequired = 'Target Run Rate Required:';
  static const String currentAvgRunRate = 'Current Avg Run Rate:';
  static const String onTrackToAchieveTarget = 'On track to achieve target this month';
  static const String offTrackForTarget = 'Behind pace to reach target this month';
  static const String perDaySuffix = '/day';

  static String daysLeft(int days) => '$days Days Left';

  static const String newSaleEntryTitle = 'New Sales Entry';
  static const String selectOutlet = 'Select Outlet';
  static const String selectCategory = 'Select Category';
  static const String selectProduct = 'Select Product';
  static const String selectProductPlaceholder = 'Select a product';
  static const String quantityUnits = 'Quantity (Units)';
  static const String discountLabel = 'Discount (৳)';
  static const String calculatedPriceLabel = 'CALCULATED PRICE';
  static const String submitSaleEntry = 'Submit Sale Entry';
  static const String todaysEntries = "Today's Entries";

  static String calculatedPriceBreakdown(
      int quantity,
      String unitPriceFormatted,
      String discountFormatted,
      ) =>
      '$quantity Units × $unitPriceFormatted - $discountFormatted discount';

  static String entryMetaLine(String location, int itemCount, String time) =>
      '$location • $itemCount Items • $time';
}
