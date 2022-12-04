import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color darkBrown = Color(0xFF2E1A00);
  static const Color grey = Color(0xffdcd9d9);
  static const Color establishmentIconColor = Color(0xFFDE6B6B);
  static const Color lightBrown = Color(0xFFB87333);
  static const Color brown = Color(0xFF964B00);
}
class AppImages {
  static String get userAvatar => "assets/images/user_avatar.png";
  static String get darkLogo => "assets/images/dark_logo.png";
  static String get lightLogo => "assets/images/light_logo.png";
  static String get lightUnauthorizedLogo => "assets/images/light_unauthorized_logo.png";
}
class AppFonts {
  static TextStyle? roomName = GoogleFonts.inter(fontSize: 17, color: AppColors.darkBrown);
  static TextStyle? nicknameDisabled = GoogleFonts.inter(color: AppColors.white, fontSize: 15, /* fontWeight: FontWeight.w600,*/);
  static TextStyle? mapsButton = GoogleFonts.inter(fontSize: 10.5, color: Colors.white);
  static TextStyle? titleAppHome = GoogleFonts.gugi(color: AppColors.white, fontSize: 30, /* fontWeight: FontWeight.w600,*/);
  static TextStyle? appTitle = GoogleFonts.inter(color: AppColors.white, fontSize: 20, fontWeight: FontWeight.w500);
  static TextStyle? registerButton = GoogleFonts.inter(color: AppColors.white, fontSize: 14.5, /* fontWeight: FontWeight.w600,*/);
  static TextStyle? roomNickname = GoogleFonts.inter(color: AppColors.darkBrown,fontSize: 18);
  static TextStyle? participantNickname = GoogleFonts.inter(fontSize: 17, color: AppColors.darkBrown);
  static TextStyle? tabBarLabelStyle = GoogleFonts.inter(fontSize: 13, /* fontWeight: FontWeight.w600,*/);
  static TextStyle? roomEnabledName = GoogleFonts.inter(color: AppColors.brown,fontSize: 18);
  static TextStyle? roomDisabledName = GoogleFonts.inter(color: Colors.grey,fontSize: 18);
  static TextStyle? numberParticipants = GoogleFonts.inter(fontSize: 13, color: Colors.black45);
  static TextStyle? distanceLabel = GoogleFonts.inter(fontSize: 13, color: Colors.black45);
  static TextStyle? boxMessage = GoogleFonts.inter(fontSize: 15);
  static TextStyle? textMessage = GoogleFonts.inter(  color: AppColors.white, fontSize: 10);
  static TextStyle? formNickname = GoogleFonts.inter(fontSize: 15);
  static TextStyle? formAge = GoogleFonts.inter(fontSize: 15);
  static TextStyle? titleFirstAccess = GoogleFonts.inter( color: AppColors.white, fontSize: 25, /* fontWeight: FontWeight.w600,*/);
  static TextStyle? titleInsertData = GoogleFonts.inter( color: AppColors.white, fontSize: 17);
  static TextStyle? titleChooseImage = GoogleFonts.inter( color: AppColors.white, fontSize: 13);
  static TextStyle? participantNicknamePageTwo =  GoogleFonts.inter(color: AppColors.darkBrown, fontSize: 18,);
  static TextStyle? userNextButton = GoogleFonts.inter(fontSize: 15, color: Colors.white);
  static TextStyle? enterpriseNextButton = GoogleFonts.inter( fontSize: 15, color: Colors.white);
  static TextStyle? titleOptionsDropdown = GoogleFonts.inter( fontSize: 15, color: Colors.black54);
  static TextStyle? titleLabelDropdown =  GoogleFonts.inter(fontSize: 15);
}
