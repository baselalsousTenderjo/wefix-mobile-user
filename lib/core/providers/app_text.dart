import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'language_provider/l10n_provider.dart';
import 'domain/model/language_model.dart';

class AppText {
  BuildContext context;
  bool? isFunction;
  AppText(this.context, {this.isFunction = false});

  LanguageProvider get languageProvider => Provider.of<LanguageProvider>(context, listen: isFunction == false ? true : false);

  String get langCode => languageProvider.lang ?? 'en';

  String getTranslation(String key) {
    try {
      // Check if languages are loaded
      if (languageProvider.allLanguage.isEmpty) {
        return '';
      }
      
      final languageList = languageProvider.allLanguage
          .where((element) => element.key == langCode)
          .toList();
      
      if (languageList.isEmpty) {
        return '';
      }
      
      final languages = languageList.first.languages;
      if (languages == null || languages.isEmpty) {
        return '';
      }
      
      final translation = languages.firstWhere(
        (element) => element.wordKey == key,
        orElse: () => SubLanguage(wordKey: key, value: ''),
      );
      
      return translation.value ?? '';
    } catch (e) {
      return '';
    }
  }

  String get youMustBeSelectedImages => getTranslation('youMustBeSelectedImages');
  String get deleteAccount => getTranslation('deleteAccount');
  String get name => getTranslation('name');
  String get deleteAccountMessage => getTranslation('deleteAccountMessage');
  String get delete => getTranslation('delete');
  String get advantageTickets => getTranslation('advantageTickets');
  String get female => getTranslation('female');
  String get serviceProviderAttachment => getTranslation('serviceProviderAttachment');
  String get technicianAttachment => getTranslation('technicianAttachment');
  String get services => getTranslation('services');
  String get enterYourName => getTranslation('enterYourName');
  String get selectType => getTranslation('selectType');
  String get quantity => getTranslation('quantity');
  String get uploadImages => getTranslation('uploadImages');
  String get uploadFromGallery => getTranslation('uploadFromGallery');
  String get signature => getTranslation('signature');
  String get uploadFromCamera => getTranslation('uploadFromCamera');
  String get recordVoice => getTranslation('recordVoice');
  String get uploadMaintenance => getTranslation('uploadMaintenance');
  String get blockMessage => getTranslation('blockMessage');
  String get image => getTranslation('image');
  String get nomaterialaddedyet => getTranslation('nomaterialaddedyet');
  String get uploud => getTranslation('uploud');
  String get selectImage => getTranslation('selectImage');
  String get jobs => getTranslation('jobs');
  String get statusColorsMeaning => getTranslation('statusColorsMeaning');
  String get pending => getTranslation('pending');
  String get inProgress => getTranslation('inProgress');
  String get cancelled => getTranslation('cancelled');
  String get completed => getTranslation('completed');
  String get thisrequestwascanceled => getTranslation('thisrequestwascanceled');
  String get requestiscurrentlyunderway => getTranslation('requestiscurrentlyunderway');
  String get thisrequestwascompletedsuccessfully => getTranslation('thisrequestwascompletedsuccessfully');
  String get awaitinginitiationrequest => getTranslation('awaitinginitiationrequest');
  String get youDontHaveToolsYet => getTranslation('youDontHaveToolsYet');
  String get emptyTools => getTranslation('emptyTools');
  String get weNotFoundToolsLikeThisName => getTranslation('weNotFoundToolsLikeThisName');
  String get support => getTranslation('support');
  String get pleasecontactthedirectengineerorphonenumber => getTranslation('pleasecontactthedirectengineerorphonenumber');
  String get cancel => getTranslation('cancel');
  String get viewReport => getTranslation('viewReport');
  String get continues => getTranslation('continues');
  String get weFixIndividual => getTranslation('weFixIndividual');
  String get createaccountandjoinustoday => getTranslation('createaccountandjoinustoday');
  String get welcomebackSignintocontinue => getTranslation('welcomebackSignintocontinue');
  String get forgetPaassword => getTranslation('forgetPaassword');
  String get havingtroubleloggingin => getTranslation('havingtroubleloggingin');
  String get email => getTranslation('email');
  String get mobile => getTranslation('mobile');
  String get dailyMaterialAndTools => getTranslation('dailyMaterialAndTools');
  String get userName => getTranslation('userName');
  String get verifycodehasbeenresentcheckyourinbox => getTranslation('verifycodehasbeenresentcheckyourinbox');
  String get enteryourusername => getTranslation('enteryourusername');
  String get address => getTranslation('address');
  String get youraccountiscurrentlyunderreviewWewillnotifyyouonceithabeenapprovedThankyoufoyourpatience =>
      getTranslation('youraccountiscurrentlyunderreviewWewillnotifyyouonceithabeenapprovedThankyoufoyourpatience');
  String get enteryourAddress => getTranslation('enteryourAddress');
  String get tools => getTranslation('tools');
  String get showAll => getTranslation('showAll');
  String get profession => getTranslation('profession');
  String get enteryourprofession => getTranslation('enteryourprofession');
  String get age => getTranslation('age');
  String get successfully => getTranslation('successfully');
  String get warning => getTranslation('warning');
  String get returnTicites => getTranslation('returnTicites');
  String get enteryourAge => getTranslation('enteryourAge');
  String get introduceyourself => getTranslation('introduceyourself');
  String get talkaboutyourself => getTranslation('talkaboutyourself');
  String get donotreceivethecodeyet => getTranslation('donotreceivethecodeyet');
  String get veirfy => getTranslation('veirfy');
  String get followAsOnSocialMedia => getTranslation('followAsOnSocialMedia');
  String get forgotpasswordResetithereeasily => getTranslation('forgotpasswordResetithereeasily');
  String get enterOTPtoverifyidentity => getTranslation('enterOTPtoverifyidentity');
  String get otpRequired => getTranslation('otpRequired');
  String get sendtheverificationcodeagain => getTranslation('sendtheverificationcodeagain');
  String get backTo => getTranslation('backTo');
  String get back => getTranslation('back');
  String get youneedtofinishthisticketfirst => getTranslation('youneedtofinishthisticketfirst');
  String get signUptobeJoinUs => getTranslation('signUptobeJoinUs');
  String get login => getTranslation('login');
  String get signUp => getTranslation('signUp');
  String get message => getTranslation('message');
  String get profile => getTranslation('profile');
  String get myTickts => getTranslation('myTickts');
  String get mostBeSelectedRate => getTranslation('mostBeSelectedRate');
  String get editNorification => getTranslation('editNorification');
  String get language => getTranslation('language');
  String get privacyPolicy => getTranslation('privacyPolicy');
  String get termsConditions => getTranslation('termsConditions');
  String get logout => getTranslation('logout');
  String get theticketstartedat => getTranslation('theticketstartedat');
  String get aboutMe => getTranslation('aboutMe');
  String get generalNotification => getTranslation('generalNotification');
  String get requestsNotification => getTranslation('requestsNotification');
  String get userNotification => getTranslation('userNotification');
  String get reviews => getTranslation('reviews');
  String get pendingTicktes => getTranslation('pendingTicktes');
  String get serviceProviderActions => getTranslation('serviceProviderActions');
  String get technicianActions => getTranslation('technicianActions');
  String get estimatedFixTime => getTranslation('estimatedFixTime');
  String get hours => getTranslation('hours');
  String get partsRequired => getTranslation('partsRequired');
  String get welcome => getTranslation('welcome');
  String get home => getTranslation('home');
  String get scan => getTranslation('scan');
  String get chatBot => getTranslation('chatBot');
  String get notifications => getTranslation('notifications');
  String get scanQRCode => getTranslation('scanQRCode');
  String get scanningaQRcodetoretrievefullcarinformation => getTranslation('scanningaQRcodetoretrievefullcarinformation');
  String get note => getTranslation('note');
  String get enterYourNotes => getTranslation('enterYourNotes');
  String get sendyourinquirytooursupportteamandwellassistyouassoonaspossible =>
      getTranslation('sendyourinquirytooursupportteamandwellassistyouassoonaspossible');
  String get send => getTranslation('send');
  String get attachments => getTranslation('attachments');
  String get ticketAttachments => getTranslation('ticketAttachments');
  String get close => getTranslation('close');
  String get confirm => getTranslation('confirm');
  String get issueDescription => getTranslation('issueDescription');
  String get ticketTitle => getTranslation('ticketTitle');
  String get problemDescription => getTranslation('problemDescription');
  String get serviceDescription => getTranslation('serviceDescription');
  String get completionChecklist => getTranslation('completionChecklist');
  String get diagnosedtheissue => getTranslation('diagnosedtheissue');
  String get detectedanalyzedandresolvedcoreproblem => getTranslation('detectedanalyzedandresolvedcoreproblem');
  String get replacedthecompressor => getTranslation('replacedthecompressor');
  String get removedfaultyunitinstallednewcompressor => getTranslation('removedfaultyunitinstallednewcompressor');
  String get testedcoolingefficiency => getTranslation('testedcoolingefficiency');
  String get measuredperformanceverifiedoptimalcoolingoutput => getTranslation('measuredperformanceverifiedoptimalcoolingoutput');
  String get customerDetails => getTranslation('customerDetails');
  String get createdBy => getTranslation('createdBy');
  String get maintenanceTicketDetails => getTranslation('maintenanceTicketDetails');
  String get title => getTranslation('title');
  String get status => getTranslation('status');
  String get date => getTranslation('date');
  String get type => getTranslation('type');
  String get add => getTranslation('add');
  String get requiredTools => getTranslation('requiredTools');
  String get requiredMaterial => getTranslation('requiredMaterial');
  String get search => getTranslation('search');
  String get ticket => getTranslation('ticket');
  String get start => getTranslation('start');
  String get complete => getTranslation('complete');
  String get count => getTranslation('count');
  String get required => getTranslation('required');
  String get mobilenumbercannotbeempty => getTranslation('mobilenumbercannotbeempty');
  String get invalidmobilenumberMustbe10digits => getTranslation('invalidmobilenumberMustbe10digits');
  String get emailcannotbeempty => getTranslation('emailcannotbeempty');
  String get iinvalidemailformat => getTranslation('iinvalidemailformat');
  String get passwordcannotbeempty => getTranslation('passwordcannotbeempty');
  String get passwordmustbeatleast8characterslong => getTranslation('passwordmustbeatleast8characterslong');
  String get passwordmustcontainatleast1uppercaseletter => getTranslation('passwordmustcontainatleast1uppercaseletter');
  String get passwordmustcontainatleast1lowercaseletter => getTranslation('passwordmustcontainatleast1lowercaseletter');
  String get passwordmustcontainatleast1number => getTranslation('passwordmustcontainatleast1number');
  String get passwordmustincludeuppercaselowercaselettersandanumber => getTranslation('passwordmustincludeuppercaselowercaselettersandanumber');
  String get attachCV => getTranslation('attachCV');
  String get selectYourCV => getTranslation('selectYourCV');
  String get recorfing => getTranslation('recorfing');
  String get emergency => getTranslation('emergency');
  String get tomorrow => getTranslation('tomorrow');
  String get today => getTranslation('today');
  String get pleaseintroduceyourselfasVoice => getTranslation('pleaseintroduceyourselfasVoice');
  String get loading => getTranslation('loading');
  String get helpCenterChat => getTranslation('helpCenterChat');
  String get errorWhenGet => getTranslation('errorWhenGet');
  String get pleasetryagainlater => getTranslation('pleasetryagainlater');
  String get errorloadingcontent => getTranslation('errorloadingcontent');
  String get emptyNotification => getTranslation('emptyNotification');
  String get youDontHaveAnyNotificationYet => getTranslation('youDontHaveAnyNotificationYet');
  String get failedtosendmessagetosupport => getTranslation('failedtosendmessagetosupport');
  String get successfullysenttosupportteam => getTranslation('successfullysenttosupportteam');
  String get emptyAttachments => getTranslation('emptyAttachments');
  String get next => getTranslation('next');
  String get generateReport => getTranslation('generateReport');
  String get yes => getTranslation('yes');
  String get no => getTranslation('no');
  String get request => getTranslation('request');
  String get b2bTeam => getTranslation('b2bTeam');
  String get weFixTeam => getTranslation('weFixTeam');
  
  // Role-based access control translations
  String get userDataNotFoundAccessDenied => getTranslation('userDataNotFoundAccessDenied');
  String get userRoleNotFoundAccessDenied => getTranslation('userRoleNotFoundAccessDenied');
  String get invalidUserRoleAccessDenied => getTranslation('invalidUserRoleAccessDenied');
  String get invalidUserRoleIdAccessDenied => getTranslation('invalidUserRoleIdAccessDenied');
  String get accessDeniedTechniciansOnly => getTranslation('accessDeniedTechniciansOnly');
  String accessDeniedTechniciansOnlyWithRole(String roleName) => getTranslation('accessDeniedTechniciansOnlyWithRole').replaceAll('{roleName}', roleName);
  String get userDataNotFoundPleaseLoginAgain => getTranslation('userDataNotFoundPleaseLoginAgain');
  String get systemErrorDuringAuthentication => getTranslation('systemErrorDuringAuthentication');
  String get systemErrorDuringAccessVerification => getTranslation('systemErrorDuringAccessVerification');
  String get backendServerError => getTranslation('backendServerError');
  String get networkErrorCheckConnection => getTranslation('networkErrorCheckConnection');
  String get serviceUnavailable => getTranslation('serviceUnavailable');
  String get roleSuperUser => getTranslation('roleSuperUser');
  String get roleIndividual => getTranslation('roleIndividual');
  String get roleTeamLeader => getTranslation('roleTeamLeader');
  String get roleTechnician => getTranslation('roleTechnician');
  String get roleSubTechnician => getTranslation('roleSubTechnician');
  String get roleAdmin => getTranslation('roleAdmin');
  String roleUnknown(int roleId) => getTranslation('roleUnknown').replaceAll('{roleId}', roleId.toString());
  String get noAssignedTickets => getTranslation('noAssignedTickets');
  String get systemUnavailablePleaseTryAgainLater => getTranslation('systemUnavailablePleaseTryAgainLater');
  String get sessionExpiredPleaseLoginAgain => getTranslation('sessionExpiredPleaseLoginAgain');
  String get endpointNotFound => getTranslation('endpointNotFound');
  String get fullNameArabic => getTranslation('fullNameArabic');
  String get fullNameEnglish => getTranslation('fullNameEnglish');
  String get gender => getTranslation('gender');
  String get male => getTranslation('male');
  String get selectGender => getTranslation('selectGender');
  String get accountDoesNotExist => getTranslation('accountDoesNotExist');
  String get invalidPhoneNumberFormat => getTranslation('invalidPhoneNumberFormat');
  String get accountTemporarilyLocked => getTranslation('accountTemporarilyLocked');
  String get pleaseWaitBeforeRequestingOTP => getTranslation('pleaseWaitBeforeRequestingOTP');
  String get pleaseEnterPhoneWithCountryCode => getTranslation('pleaseEnterPhoneWithCountryCode');
  String get internalServerError => getTranslation('internalServerError');
  String get anErrorOccurred => getTranslation('anErrorOccurred');
  String get badRequest => getTranslation('badRequest');
  String get unauthorized => getTranslation('unauthorized');
  String get forbidden => getTranslation('forbidden');
  String get notFound => getTranslation('notFound');
  String get connectionError => getTranslation('connectionError');
  String get connectionTimeout => getTranslation('connectionTimeout');
  String get unknownError => getTranslation('unknownError');
  String get failedToSendOTP => getTranslation('failedToSendOTP');
  String get ticketAlreadyCompleted => getTranslation('ticketAlreadyCompleted');
  String get fileNotFound => getTranslation('fileNotFound');
  String get ticketMustBeStartedFirst => getTranslation('ticketMustBeStartedFirst');
  String get signatureRequired => getTranslation('signatureRequired');
  String get attachmentsRequired => getTranslation('attachmentsRequired');
  String get completedTicketInfo => getTranslation('completedTicketInfo');
  String get technicianAttachments => getTranslation('technicianAttachments');
  String get completionNote => getTranslation('completionNote');
  String get accessDeniedServiceNotAvailable => getTranslation('accessDeniedServiceNotAvailable');
  String get accountInactiveMessage => getTranslation('accountInactiveMessage');
  String get pleaseLoginWithMobileNumber => getTranslation('pleaseLoginWithMobileNumber');
}
