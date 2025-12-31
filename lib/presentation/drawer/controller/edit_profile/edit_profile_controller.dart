import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../../core/services/hive_services/box_kes.dart';
import '../../../../injection_container.dart';
import '../../../auth/domain/model/user_model.dart';
import '../../../home/domain/model/home_model.dart';
import '../../../home/domain/usecase/home_usecase.dart';
import '../../domain/usecase/profile_usecase.dart';

enum ProfileStatus { init, loading, success, failure }

class EditProfileController extends ChangeNotifier with WidgetsBindingObserver {
  final ProfileUsecase profileUsecase;
  final HomeUsecase homeUsecase;
  final ImagePicker _picker = ImagePicker();
  
  File? imagePath;
  ValueNotifier<ProfileStatus> profileStatus = ValueNotifier(ProfileStatus.init);
  User? currentProfile;
  CompanyInfo? companyInfo;
  
  // Text controllers for editable fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  
  // Store selected phone number details
  PhoneNumber? selectedPhoneNumber;
  String? countryCode;
  String? mobileNumber;
  
  // Gender selection
  String? selectedGender;

  EditProfileController({required this.profileUsecase, required this.homeUsecase}) {
    loadProfile();
  }

  // Check if user is B2B Team
  bool get isB2BUser {
    final userTeam = sl<Box>(instanceName: BoxKeys.appBox).get(BoxKeys.userTeam);
    return userTeam == 'B2B Team';
  }

  // Load profile from backend-tmms for B2B users
  Future<void> loadProfile() async {
    if (!isB2BUser) {
      // For WeFix Team, load from Hive
      final user = sl<Box<User>>().get(BoxKeys.userData);
      currentProfile = user;
      _populateControllers();
      notifyListeners();
      return;
    }

    profileStatus.value = ProfileStatus.loading;
    notifyListeners();

    // Fetch profile data
    final profileResult = await profileUsecase.getProfile();
    
    // Fetch home data to get company information
    final homeResult = await homeUsecase.getHomeData();
    
    profileResult.fold(
      (failure) {
        profileStatus.value = ProfileStatus.failure;
        notifyListeners();
      },
      (success) {
        if (success.data != null) {
          currentProfile = success.data;
          _populateControllers();
          profileStatus.value = ProfileStatus.success;
        } else {
          profileStatus.value = ProfileStatus.failure;
        }
        notifyListeners();
      },
    );
    
    // Extract company information from home data
    homeResult.fold(
      (failure) {
        // If home data fetch fails, continue without company info
        // Don't set status to failure as profile might have loaded successfully
      },
      (success) {
        if (success.data != null) {
          companyInfo = success.data?.technician?.company;
          notifyListeners();
        }
      },
    );
  }

  void _populateControllers() {
    if (currentProfile != null) {
      emailController.text = currentProfile?.email ?? '';
      firstnameController.text = currentProfile?.fullName ?? '';
      lastnameController.text = currentProfile?.fullNameEnglish ?? '';
      
      // Normalize gender value when loading from profile
      final genderValue = currentProfile?.gender;
      if (genderValue != null && genderValue.isNotEmpty) {
        final lowerGender = genderValue.toLowerCase().trim();
        if (lowerGender == 'male' || lowerGender == 'm' || lowerGender == 'ذكر') {
          selectedGender = 'Male';
        } else if (lowerGender == 'female' || lowerGender == 'f' || lowerGender == 'أنثى') {
          selectedGender = 'Female';
        } else if (genderValue == 'Male' || genderValue == 'Female') {
          selectedGender = genderValue;
        } else {
          selectedGender = null; // Set to null if doesn't match expected values
        }
      } else {
        selectedGender = null;
      }
      
      // Set phone number - combine country code and mobile number if available
      if (currentProfile?.mobileNumber != null && currentProfile?.countryCode != null) {
        phoneController.text = currentProfile!.mobileNumber!;
        countryCode = currentProfile!.countryCode;
        mobileNumber = currentProfile!.mobileNumber;
      } else if (currentProfile?.mobileNumber != null) {
        phoneController.text = currentProfile!.mobileNumber!;
        mobileNumber = currentProfile!.mobileNumber;
      }
    }
  }
  
  // Handle phone number change from WidgetPhoneField
  void onPhoneNumberChanged(PhoneNumber phoneNumber) {
    selectedPhoneNumber = phoneNumber;
    // Store country code separately (includes + sign, e.g., "+962")
    countryCode = phoneNumber.dialCode;
    
    // Extract mobile number without country code
    // phoneNumber.phoneNumber contains the full number (e.g., "+962791234567")
    // We need to remove the dialCode to get just the local number (e.g., "791234567")
    if (phoneNumber.phoneNumber != null && phoneNumber.dialCode != null) {
      String fullNumber = phoneNumber.phoneNumber!;
      String dialCode = phoneNumber.dialCode!;
      // Remove dial code from the beginning of the full number
      if (fullNumber.startsWith(dialCode)) {
        mobileNumber = fullNumber.substring(dialCode.length).trim();
      } else {
        // If dial code is not at the start, try removing it anyway
        mobileNumber = fullNumber.replaceAll(dialCode, '').trim();
      }
      // Update the text controller with just the local number
      phoneController.text = mobileNumber ?? '';
    } else if (phoneNumber.phoneNumber != null) {
      // Fallback: use the full number if dial code is not available
      mobileNumber = phoneNumber.phoneNumber;
      phoneController.text = mobileNumber ?? '';
    } else {
      mobileNumber = null;
      phoneController.text = '';
    }
    notifyListeners();
  }

  // Handle gender change
  void onGenderChanged(String? gender) {
    selectedGender = gender;
    notifyListeners();
  }

  // Function to pick an image from the gallery
  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imagePath = File(pickedFile.path);
      notifyListeners();
    }
  }

  // Update profile for B2B users
  Future<bool> updateProfile() async {
    if (!isB2BUser) {
      return false; // Profile update only for B2B users
    }

    profileStatus.value = ProfileStatus.loading;
    notifyListeners();

    final result = await profileUsecase.updateProfile(
      email: emailController.text.isNotEmpty ? emailController.text : null,
      fullNameArabic: firstnameController.text.isNotEmpty ? firstnameController.text : null,
      fullNameEnglish: lastnameController.text.isNotEmpty ? lastnameController.text : null,
      mobileNumber: mobileNumber?.isNotEmpty == true ? mobileNumber : null,
      countryCode: countryCode?.isNotEmpty == true ? countryCode : null,
      gender: selectedGender,
      profileImage: imagePath,
    );

    return result.fold(
      (failure) {
        profileStatus.value = ProfileStatus.failure;
        notifyListeners();
        return false;
      },
      (success) {
        if (success.data != null) {
          currentProfile = success.data;
          // Update Hive storage with new profile data
          final userBox = sl<Box<User>>();
          final existingUser = userBox.get(BoxKeys.userData);
          if (existingUser != null) {
            final updatedUser = existingUser.copyWith(
              email: success.data?.email ?? existingUser.email,
              fullName: success.data?.fullName ?? existingUser.fullName,
              fullNameEnglish: success.data?.fullNameEnglish ?? existingUser.fullNameEnglish,
              mobileNumber: success.data?.mobileNumber ?? existingUser.mobileNumber,
              countryCode: success.data?.countryCode ?? existingUser.countryCode,
              gender: success.data?.gender ?? existingUser.gender,
              profileImage: success.data?.profileImage ?? existingUser.profileImage,
            );
            userBox.put(BoxKeys.userData, updatedUser);
          }
          imagePath = null; // Clear selected image
          profileStatus.value = ProfileStatus.success;
          notifyListeners();
          return true;
        } else {
          profileStatus.value = ProfileStatus.failure;
          notifyListeners();
          return false;
        }
      },
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    firstnameController.dispose();
    lastnameController.dispose();
    phoneController.dispose();
    super.dispose();
  }
}
