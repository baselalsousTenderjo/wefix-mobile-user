import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @support.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support;

  /// No description provided for @pleasecontactthedirectengineerorphonenumber.
  ///
  /// In en, this message translates to:
  /// **'Please contact the direct engineer or phone number '**
  String get pleasecontactthedirectengineerorphonenumber;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @continues.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continues;

  /// No description provided for @weFixIndividual.
  ///
  /// In en, this message translates to:
  /// **'WeFix Individual'**
  String get weFixIndividual;

  /// No description provided for @createaccountandjoinustoday.
  ///
  /// In en, this message translates to:
  /// **'Create account and join us today!'**
  String get createaccountandjoinustoday;

  /// No description provided for @welcomebackSignintocontinue.
  ///
  /// In en, this message translates to:
  /// **'Welcome back! Sign in to continue'**
  String get welcomebackSignintocontinue;

  /// No description provided for @forgetPaassword.
  ///
  /// In en, this message translates to:
  /// **'Forget Paassword'**
  String get forgetPaassword;

  /// No description provided for @havingtroubleloggingin.
  ///
  /// In en, this message translates to:
  /// **'Having trouble logging in?'**
  String get havingtroubleloggingin;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @mobile.
  ///
  /// In en, this message translates to:
  /// **'Mobile'**
  String get mobile;

  /// No description provided for @dailyMaterialAndTools.
  ///
  /// In en, this message translates to:
  /// **'Daily Material And Tools'**
  String get dailyMaterialAndTools;

  /// No description provided for @userName.
  ///
  /// In en, this message translates to:
  /// **'User Name'**
  String get userName;

  /// No description provided for @signature.
  ///
  /// In en, this message translates to:
  /// **'Signature'**
  String get signature;

  /// No description provided for @uploadImages.
  ///
  /// In en, this message translates to:
  /// **'Upload Images'**
  String get uploadImages;

  /// No description provided for @uploadFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Upload Images From Gallery'**
  String get uploadFromGallery;

  /// No description provided for @uploadFromCamera.
  ///
  /// In en, this message translates to:
  /// **'Upload Images From Camera'**
  String get uploadFromCamera;

  /// No description provided for @verifycodehasbeenresentcheckyourinbox.
  ///
  /// In en, this message translates to:
  /// **'Verify code has been resent, check your inbox.'**
  String get verifycodehasbeenresentcheckyourinbox;

  /// No description provided for @enteryourusername.
  ///
  /// In en, this message translates to:
  /// **'Enter your username'**
  String get enteryourusername;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @youraccountiscurrentlyunderreviewWewillnotifyyouonceithabeenapprovedThankyoufoyourpatience.
  ///
  /// In en, this message translates to:
  /// **'Your account is currently under review. We will notify you once it has been approved. Thank you for your patience!'**
  String get youraccountiscurrentlyunderreviewWewillnotifyyouonceithabeenapprovedThankyoufoyourpatience;

  /// No description provided for @enteryourAddress.
  ///
  /// In en, this message translates to:
  /// **'Enter your Address'**
  String get enteryourAddress;

  /// No description provided for @tools.
  ///
  /// In en, this message translates to:
  /// **'Tools'**
  String get tools;

  /// No description provided for @viewReport.
  ///
  /// In en, this message translates to:
  /// **'View Report'**
  String get viewReport;

  /// No description provided for @showAll.
  ///
  /// In en, this message translates to:
  /// **'Show All'**
  String get showAll;

  /// No description provided for @profession.
  ///
  /// In en, this message translates to:
  /// **'Profession'**
  String get profession;

  /// No description provided for @enteryourprofession.
  ///
  /// In en, this message translates to:
  /// **'Enter your profession'**
  String get enteryourprofession;

  /// No description provided for @age.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get age;

  /// No description provided for @successfully.
  ///
  /// In en, this message translates to:
  /// **'Successfully'**
  String get successfully;

  /// No description provided for @warning.
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get warning;

  /// No description provided for @returnTicites.
  ///
  /// In en, this message translates to:
  /// **'Return'**
  String get returnTicites;

  /// No description provided for @enteryourAge.
  ///
  /// In en, this message translates to:
  /// **'Enter your Age'**
  String get enteryourAge;

  /// No description provided for @introduceyourself.
  ///
  /// In en, this message translates to:
  /// **'Introduce yourself'**
  String get introduceyourself;

  /// No description provided for @talkaboutyourself.
  ///
  /// In en, this message translates to:
  /// **'Talk about yourself ...'**
  String get talkaboutyourself;

  /// No description provided for @donotreceivethecodeyet.
  ///
  /// In en, this message translates to:
  /// **'Do not receive the code yet?'**
  String get donotreceivethecodeyet;

  /// No description provided for @veirfy.
  ///
  /// In en, this message translates to:
  /// **'Veirfy'**
  String get veirfy;

  /// No description provided for @followAsOnSocialMedia.
  ///
  /// In en, this message translates to:
  /// **'Follow our official social media pages'**
  String get followAsOnSocialMedia;

  /// No description provided for @forgotpasswordResetithereeasily.
  ///
  /// In en, this message translates to:
  /// **'Forgot password? Reset it here easily.'**
  String get forgotpasswordResetithereeasily;

  /// No description provided for @enterOTPtoverifyidentity.
  ///
  /// In en, this message translates to:
  /// **'Enter OTP to verify identity.'**
  String get enterOTPtoverifyidentity;

  /// No description provided for @sendtheverificationcodeagain.
  ///
  /// In en, this message translates to:
  /// **'Send the verification code again'**
  String get sendtheverificationcodeagain;

  /// No description provided for @backTo.
  ///
  /// In en, this message translates to:
  /// **'Back To  '**
  String get backTo;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'back'**
  String get back;

  /// No description provided for @youneedtofinishthisticketfirst.
  ///
  /// In en, this message translates to:
  /// **'You need to finish this ticket first.'**
  String get youneedtofinishthisticketfirst;

  /// No description provided for @signUptobeJoinUs.
  ///
  /// In en, this message translates to:
  /// **'Sign Up to be Join Us'**
  String get signUptobeJoinUs;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @message.
  ///
  /// In en, this message translates to:
  /// **'Message ....'**
  String get message;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @myTickts.
  ///
  /// In en, this message translates to:
  /// **'My Tickts'**
  String get myTickts;

  /// No description provided for @editNorification.
  ///
  /// In en, this message translates to:
  /// **'Edit Norification'**
  String get editNorification;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @termsConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get termsConditions;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logout;

  /// No description provided for @aboutMe.
  ///
  /// In en, this message translates to:
  /// **'About Me'**
  String get aboutMe;

  /// No description provided for @generalNotification.
  ///
  /// In en, this message translates to:
  /// **'General Notification'**
  String get generalNotification;

  /// No description provided for @requestsNotification.
  ///
  /// In en, this message translates to:
  /// **'Requests Notification'**
  String get requestsNotification;

  /// No description provided for @userNotification.
  ///
  /// In en, this message translates to:
  /// **'User Notification'**
  String get userNotification;

  /// No description provided for @reviews.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get reviews;

  /// No description provided for @pendingTicktes.
  ///
  /// In en, this message translates to:
  /// **'Pending Ticktes'**
  String get pendingTicktes;

  /// No description provided for @serviceProviderActions.
  ///
  /// In en, this message translates to:
  /// **'Service Provider Actions'**
  String get serviceProviderActions;

  /// No description provided for @estimatedFixTime.
  ///
  /// In en, this message translates to:
  /// **'Estimated Fix Time'**
  String get estimatedFixTime;

  /// No description provided for @hours.
  ///
  /// In en, this message translates to:
  /// **'hours'**
  String get hours;

  /// No description provided for @partsRequired.
  ///
  /// In en, this message translates to:
  /// **'Parts Required'**
  String get partsRequired;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome  '**
  String get welcome;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @scan.
  ///
  /// In en, this message translates to:
  /// **'Scan'**
  String get scan;

  /// No description provided for @chatBot.
  ///
  /// In en, this message translates to:
  /// **'Chat Bot'**
  String get chatBot;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @scanQRCode.
  ///
  /// In en, this message translates to:
  /// **'Scan QR Code'**
  String get scanQRCode;

  /// No description provided for @scanningaQRcodetoretrievefullcarinformation.
  ///
  /// In en, this message translates to:
  /// **'Scanning a QR code to retrieve full car information'**
  String get scanningaQRcodetoretrievefullcarinformation;

  /// No description provided for @note.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get note;

  /// No description provided for @enterYourNotes.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Notes ....'**
  String get enterYourNotes;

  /// No description provided for @sendyourinquirytooursupportteamandwellassistyouassoonaspossible.
  ///
  /// In en, this message translates to:
  /// **'Send your inquiry to our support team, and we’ll assist you as soon as possible.'**
  String get sendyourinquirytooursupportteamandwellassistyouassoonaspossible;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @attachments.
  ///
  /// In en, this message translates to:
  /// **'Attachments'**
  String get attachments;

  /// No description provided for @ticketAttachments.
  ///
  /// In en, this message translates to:
  /// **'Ticket Attachments'**
  String get ticketAttachments;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @issueDescription.
  ///
  /// In en, this message translates to:
  /// **'Issue Description'**
  String get issueDescription;

  /// No description provided for @completionChecklist.
  ///
  /// In en, this message translates to:
  /// **'Completion Checklist'**
  String get completionChecklist;

  /// No description provided for @diagnosedtheissue.
  ///
  /// In en, this message translates to:
  /// **'Diagnosed the issue'**
  String get diagnosedtheissue;

  /// No description provided for @detectedanalyzedandresolvedcoreproblem.
  ///
  /// In en, this message translates to:
  /// **'Detected, analyzed, and resolved core problem.'**
  String get detectedanalyzedandresolvedcoreproblem;

  /// No description provided for @replacedthecompressor.
  ///
  /// In en, this message translates to:
  /// **'Replaced the compressor'**
  String get replacedthecompressor;

  /// No description provided for @removedfaultyunitinstallednewcompressor.
  ///
  /// In en, this message translates to:
  /// **'Removed faulty unit, installed new compressor.'**
  String get removedfaultyunitinstallednewcompressor;

  /// No description provided for @testedcoolingefficiency.
  ///
  /// In en, this message translates to:
  /// **'Tested cooling efficiency'**
  String get testedcoolingefficiency;

  /// No description provided for @measuredperformanceverifiedoptimalcoolingoutput.
  ///
  /// In en, this message translates to:
  /// **'Measured performance, verified optimal cooling output.'**
  String get measuredperformanceverifiedoptimalcoolingoutput;

  /// No description provided for @customerDetails.
  ///
  /// In en, this message translates to:
  /// **'Customer Details'**
  String get customerDetails;

  /// No description provided for @createdBy.
  ///
  /// In en, this message translates to:
  /// **'Created By'**
  String get createdBy;

  /// No description provided for @technicianAttachment.
  ///
  /// In en, this message translates to:
  /// **'Technician Attachment'**
  String get technicianAttachment;

  /// No description provided for @maintenanceTicketDetails.
  ///
  /// In en, this message translates to:
  /// **'Maintenance Ticket Details'**
  String get maintenanceTicketDetails;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @requiredTools.
  ///
  /// In en, this message translates to:
  /// **'Required Tools'**
  String get requiredTools;

  /// No description provided for @requiredMaterial.
  ///
  /// In en, this message translates to:
  /// **'Required Material'**
  String get requiredMaterial;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @ticket.
  ///
  /// In en, this message translates to:
  /// **'Ticket'**
  String get ticket;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @complete.
  ///
  /// In en, this message translates to:
  /// **'Complete'**
  String get complete;

  /// No description provided for @count.
  ///
  /// In en, this message translates to:
  /// **'Count'**
  String get count;

  /// No description provided for @required.
  ///
  /// In en, this message translates to:
  /// **'required'**
  String get required;

  /// No description provided for @mobilenumbercannotbeempty.
  ///
  /// In en, this message translates to:
  /// **'Mobile number cannot be empty'**
  String get mobilenumbercannotbeempty;

  /// No description provided for @invalidmobilenumberMustbe10digits.
  ///
  /// In en, this message translates to:
  /// **'Invalid mobile number. Must be 10 digits.'**
  String get invalidmobilenumberMustbe10digits;

  /// No description provided for @emailcannotbeempty.
  ///
  /// In en, this message translates to:
  /// **'Email cannot be empty'**
  String get emailcannotbeempty;

  /// No description provided for @iinvalidemailformat.
  ///
  /// In en, this message translates to:
  /// **'Invalid email format'**
  String get iinvalidemailformat;

  /// No description provided for @passwordcannotbeempty.
  ///
  /// In en, this message translates to:
  /// **'Password cannot be empty'**
  String get passwordcannotbeempty;

  /// No description provided for @passwordmustbeatleast8characterslong.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters long'**
  String get passwordmustbeatleast8characterslong;

  /// No description provided for @passwordmustcontainatleast1uppercaseletter.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least 1 uppercase letter'**
  String get passwordmustcontainatleast1uppercaseletter;

  /// No description provided for @passwordmustcontainatleast1lowercaseletter.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least 1 lowercase letter'**
  String get passwordmustcontainatleast1lowercaseletter;

  /// No description provided for @passwordmustcontainatleast1number.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least 1 number'**
  String get passwordmustcontainatleast1number;

  /// No description provided for @passwordmustincludeuppercaselowercaselettersandanumber.
  ///
  /// In en, this message translates to:
  /// **'Password must include uppercase, lowercase letters, and a number'**
  String get passwordmustincludeuppercaselowercaselettersandanumber;

  /// No description provided for @attachCV.
  ///
  /// In en, this message translates to:
  /// **'Attach CV'**
  String get attachCV;

  /// No description provided for @selectYourCV.
  ///
  /// In en, this message translates to:
  /// **'Select Your CV'**
  String get selectYourCV;

  /// No description provided for @recorfing.
  ///
  /// In en, this message translates to:
  /// **'Recorfing ... '**
  String get recorfing;

  /// No description provided for @emergency.
  ///
  /// In en, this message translates to:
  /// **'Emergency'**
  String get emergency;

  /// No description provided for @tomorrow.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get tomorrow;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @pleaseintroduceyourselfasVoice.
  ///
  /// In en, this message translates to:
  /// **'Please introduce yourself as Voice'**
  String get pleaseintroduceyourselfasVoice;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @helpCenterChat.
  ///
  /// In en, this message translates to:
  /// **'Help Center Chat'**
  String get helpCenterChat;

  /// No description provided for @errorWhenGet.
  ///
  /// In en, this message translates to:
  /// **'Error When Get'**
  String get errorWhenGet;

  /// No description provided for @pleasetryagainlater.
  ///
  /// In en, this message translates to:
  /// **'Please try again later'**
  String get pleasetryagainlater;

  /// No description provided for @errorloadingcontent.
  ///
  /// In en, this message translates to:
  /// **'Error loading content'**
  String get errorloadingcontent;

  /// No description provided for @emptyNotification.
  ///
  /// In en, this message translates to:
  /// **'EmptyNotification'**
  String get emptyNotification;

  /// No description provided for @youDontHaveAnyNotificationYet.
  ///
  /// In en, this message translates to:
  /// **'You Don\'t Have Any Notification Yet!'**
  String get youDontHaveAnyNotificationYet;

  /// No description provided for @failedtosendmessagetosupport.
  ///
  /// In en, this message translates to:
  /// **'Failed to send message to support.'**
  String get failedtosendmessagetosupport;

  /// No description provided for @successfullysenttosupportteam.
  ///
  /// In en, this message translates to:
  /// **'Successfully sent to support team'**
  String get successfullysenttosupportteam;

  /// No description provided for @emptyAttachments.
  ///
  /// In en, this message translates to:
  /// **'Empty Attachments !'**
  String get emptyAttachments;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @generateReport.
  ///
  /// In en, this message translates to:
  /// **'Generate Report'**
  String get generateReport;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @request.
  ///
  /// In en, this message translates to:
  /// **'Request'**
  String get request;

  /// No description provided for @statusColorsMeaning.
  ///
  /// In en, this message translates to:
  /// **'Status Colors Meaning'**
  String get statusColorsMeaning;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @inProgress.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get inProgress;

  /// No description provided for @cancelled.
  ///
  /// In en, this message translates to:
  /// **'Canceled'**
  String get cancelled;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @thisrequestwascanceled.
  ///
  /// In en, this message translates to:
  /// **'This request was cancelled.'**
  String get thisrequestwascanceled;

  /// No description provided for @requestiscurrentlyunderway.
  ///
  /// In en, this message translates to:
  /// **'Request is currently underway.'**
  String get requestiscurrentlyunderway;

  /// No description provided for @thisrequestwascompletedsuccessfully.
  ///
  /// In en, this message translates to:
  /// **'This request was completed successfully.'**
  String get thisrequestwascompletedsuccessfully;

  /// No description provided for @awaitinginitiationrequest.
  ///
  /// In en, this message translates to:
  /// **'Awaiting initiation request.'**
  String get awaitinginitiationrequest;

  /// No description provided for @emptyTools.
  ///
  /// In en, this message translates to:
  /// **'Empty Tools'**
  String get emptyTools;

  /// No description provided for @weNotFoundToolsLikeThisName.
  ///
  /// In en, this message translates to:
  /// **'We Not Found Tools Like This Name'**
  String get weNotFoundToolsLikeThisName;

  /// No description provided for @youDontHaveToolsYet.
  ///
  /// In en, this message translates to:
  /// **'You Dont Have Tools Yet!'**
  String get youDontHaveToolsYet;

  /// No description provided for @uploadMaintenance.
  ///
  /// In en, this message translates to:
  /// **'Upload Maintenance'**
  String get uploadMaintenance;

  /// No description provided for @image.
  ///
  /// In en, this message translates to:
  /// **'image'**
  String get image;

  /// No description provided for @selectImage.
  ///
  /// In en, this message translates to:
  /// **'Select Image'**
  String get selectImage;

  /// No description provided for @uploud.
  ///
  /// In en, this message translates to:
  /// **'Uploud'**
  String get uploud;

  /// No description provided for @jobs.
  ///
  /// In en, this message translates to:
  /// **'Jobs'**
  String get jobs;

  /// No description provided for @blockMessage.
  ///
  /// In en, this message translates to:
  /// **'We would like to inform you that your account has been blocked by the administrator.\n\nFor further details and to resolve this issue, please contact us directly as soon as possible.\n\nThank you for your understanding.'**
  String get blockMessage;

  /// No description provided for @nomaterialaddedyet.
  ///
  /// In en, this message translates to:
  /// **'No material added yet!'**
  String get nomaterialaddedyet;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @enterYourName.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Name'**
  String get enterYourName;

  /// No description provided for @selectType.
  ///
  /// In en, this message translates to:
  /// **'Select Type'**
  String get selectType;

  /// No description provided for @b2bTeam.
  ///
  /// In en, this message translates to:
  /// **'B2B Team'**
  String get b2bTeam;

  /// No description provided for @weFixTeam.
  ///
  /// In en, this message translates to:
  /// **'WeFix Team'**
  String get weFixTeam;

  /// No description provided for @userDataNotFoundAccessDenied.
  ///
  /// In en, this message translates to:
  /// **'User data not found. Access denied.'**
  String get userDataNotFoundAccessDenied;

  /// No description provided for @userRoleNotFoundAccessDenied.
  ///
  /// In en, this message translates to:
  /// **'User role not found. Access denied.'**
  String get userRoleNotFoundAccessDenied;

  /// No description provided for @invalidUserRoleAccessDenied.
  ///
  /// In en, this message translates to:
  /// **'Invalid user role. Access denied.'**
  String get invalidUserRoleAccessDenied;

  /// No description provided for @invalidUserRoleIdAccessDenied.
  ///
  /// In en, this message translates to:
  /// **'Invalid user role ID. Access denied.'**
  String get invalidUserRoleIdAccessDenied;

  /// No description provided for @accessDeniedTechniciansOnly.
  ///
  /// In en, this message translates to:
  /// **'Access denied. This app is only available for Technicians.'**
  String get accessDeniedTechniciansOnly;

  /// No description provided for @accessDeniedTechniciansOnlyWithRole.
  ///
  /// In en, this message translates to:
  /// **'Access denied. This app is only available for Technicians. Your role: {roleName}'**
  String accessDeniedTechniciansOnlyWithRole(String roleName);

  /// No description provided for @userDataNotFoundPleaseLoginAgain.
  ///
  /// In en, this message translates to:
  /// **'User data not found. Please login again.'**
  String get userDataNotFoundPleaseLoginAgain;

  /// No description provided for @systemErrorDuringAuthentication.
  ///
  /// In en, this message translates to:
  /// **'System error during authentication. Please try again later.'**
  String get systemErrorDuringAuthentication;

  /// No description provided for @systemErrorDuringAccessVerification.
  ///
  /// In en, this message translates to:
  /// **'System error during access verification. Please try again later.'**
  String get systemErrorDuringAccessVerification;

  /// No description provided for @backendServerError.
  ///
  /// In en, this message translates to:
  /// **'Backend server error. Please try again later.'**
  String get backendServerError;

  /// No description provided for @networkErrorCheckConnection.
  ///
  /// In en, this message translates to:
  /// **'Network error. Please check your connection and try again.'**
  String get networkErrorCheckConnection;

  /// No description provided for @serviceUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Service Unavailable'**
  String get serviceUnavailable;

  /// No description provided for @roleSuperUser.
  ///
  /// In en, this message translates to:
  /// **'Super User'**
  String get roleSuperUser;

  /// No description provided for @roleIndividual.
  ///
  /// In en, this message translates to:
  /// **'Individual'**
  String get roleIndividual;

  /// No description provided for @roleTeamLeader.
  ///
  /// In en, this message translates to:
  /// **'Team Leader'**
  String get roleTeamLeader;

  /// No description provided for @roleTechnician.
  ///
  /// In en, this message translates to:
  /// **'Technician'**
  String get roleTechnician;

  /// No description provided for @roleSubTechnician.
  ///
  /// In en, this message translates to:
  /// **'Sub Technician'**
  String get roleSubTechnician;

  /// No description provided for @roleAdmin.
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get roleAdmin;

  /// No description provided for @roleUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown Role ({roleId})'**
  String roleUnknown(int roleId);

  /// No description provided for @noAssignedTickets.
  ///
  /// In en, this message translates to:
  /// **'No assigned tickets'**
  String get noAssignedTickets;

  /// No description provided for @systemUnavailablePleaseTryAgainLater.
  ///
  /// In en, this message translates to:
  /// **'System unavailable. Please try again later.'**
  String get systemUnavailablePleaseTryAgainLater;

  /// No description provided for @sessionExpiredPleaseLoginAgain.
  ///
  /// In en, this message translates to:
  /// **'Session expired. Please login again.'**
  String get sessionExpiredPleaseLoginAgain;

  /// No description provided for @endpointNotFound.
  ///
  /// In en, this message translates to:
  /// **'Endpoint not found.'**
  String get endpointNotFound;

  /// No description provided for @fullNameArabic.
  ///
  /// In en, this message translates to:
  /// **'Full Name (Arabic)'**
  String get fullNameArabic;

  /// No description provided for @fullNameEnglish.
  ///
  /// In en, this message translates to:
  /// **'Full Name (English)'**
  String get fullNameEnglish;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @selectGender.
  ///
  /// In en, this message translates to:
  /// **'Select Gender'**
  String get selectGender;

  /// No description provided for @ticketAlreadyCompleted.
  ///
  /// In en, this message translates to:
  /// **'Ticket is already completed.'**
  String get ticketAlreadyCompleted;

  /// No description provided for @fileNotFound.
  ///
  /// In en, this message translates to:
  /// **'File not found.'**
  String get fileNotFound;

  /// No description provided for @ticketMustBeStartedFirst.
  ///
  /// In en, this message translates to:
  /// **'Ticket must be started first before completion.'**
  String get ticketMustBeStartedFirst;

  /// No description provided for @signatureRequired.
  ///
  /// In en, this message translates to:
  /// **'Signature is required to complete the ticket.'**
  String get signatureRequired;

  /// No description provided for @attachmentsRequired.
  ///
  /// In en, this message translates to:
  /// **'Adding attachments is required.'**
  String get attachmentsRequired;

  /// No description provided for @completedTicketInfo.
  ///
  /// In en, this message translates to:
  /// **'Completed Ticket Information'**
  String get completedTicketInfo;

  /// No description provided for @technicianAttachments.
  ///
  /// In en, this message translates to:
  /// **'Technician Attachments'**
  String get technicianAttachments;

  /// No description provided for @completionNote.
  ///
  /// In en, this message translates to:
  /// **'Completion Note'**
  String get completionNote;

  /// No description provided for @recordVoice.
  ///
  /// In en, this message translates to:
  /// **'Record Voice'**
  String get recordVoice;

  /// No description provided for @accountDoesNotExist.
  ///
  /// In en, this message translates to:
  /// **'Account does not exist with this phone number'**
  String get accountDoesNotExist;

  /// No description provided for @invalidPhoneNumberFormat.
  ///
  /// In en, this message translates to:
  /// **'Invalid phone number format'**
  String get invalidPhoneNumberFormat;

  /// No description provided for @accountTemporarilyLocked.
  ///
  /// In en, this message translates to:
  /// **'Account temporarily locked'**
  String get accountTemporarilyLocked;

  /// No description provided for @pleaseWaitBeforeRequestingOTP.
  ///
  /// In en, this message translates to:
  /// **'Please wait before requesting a new code'**
  String get pleaseWaitBeforeRequestingOTP;

  /// No description provided for @updateRequired.
  ///
  /// In en, this message translates to:
  /// **'Update Required'**
  String get updateRequired;

  /// No description provided for @updateRequiredDescription.
  ///
  /// In en, this message translates to:
  /// **'A new version of the app is available. Please update to continue using the app.'**
  String get updateRequiredDescription;

  /// No description provided for @updateNow.
  ///
  /// In en, this message translates to:
  /// **'Update Now'**
  String get updateNow;

  /// No description provided for @later.
  ///
  /// In en, this message translates to:
  /// **'Later'**
  String get later;

  /// No description provided for @couldNotOpenStore.
  ///
  /// In en, this message translates to:
  /// **'Could not open store. Please update manually.'**
  String get couldNotOpenStore;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
