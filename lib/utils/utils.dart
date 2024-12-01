import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_blight/screen/login/login_bloc.dart';

class TextUtils {
  //छोड्नुहोस्
  static String appname = "Agricultural Assistant";
  static String register = "दर्ता गर्नुहोस्";
  static String registerPage = "दर्ता पृष्ठ";
  static String skip = "छोड्नुहोस्";
  static String next = "अर्को";
  static String finished = "समाप्त भयो";
  static String back = "पछाडि";
  static String phone = "मोबाइल";
  static String email = "ईमेल";
  static String password = "पासवर्ड";
  static String forgotPassword = "पासवर्ड भुल्नु भयो?";
  static String login = "लग - इन";
  static String fullname = "पुरा नाम";
  static String confirmPassword = "सुनिश्चित पासवर्ड";
  static String alreadyHaveAnAccount = "पहिले नै खाता छ?";
  static String loginPage = "लगइन पृष्ठ";
  static String dontHaveAccount = "खाता छैन?";
  static String aboutWeather = "मौसम जानकारी";
  static String diseaseProbability = "डढुवा रोगको सम्भावना";
  static String logout = "बाहिर निस्कनु";
  static String help = "मद्दत";
  static String askLogout = "के तपाई लगआउट गर्न चाहनुहुन्छ?";
  static String yes = "हो";
  static String no = "होइन";
  static String firstname = "पहिलो नाम";
  static String lastname = "थर";
  static String nearbyLocation = "तपाईंको नजिकैको  स्थान";
  static String aboutDisease = "रोग बारे";
  static String otherPlace = "अन्य स्थान";
  static String seeMore = "अझ धेरै हेर्नुहोस्";
  static String aboutUs = "हाम्रोबारे";
}

void logout(BuildContext context) {
  context.read<LoginBloc>().logout();
}

bool checkEmail(String email) {
  if (email.isEmpty) {
    return false;
  }
  return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
}

//format the date to show in the chat
String formatDate(String date) {
  final DateTime dateTime = DateTime.parse(date);
  final DateTime now = DateTime.now();
  final Duration diff = now.difference(dateTime);

  String formattedDate;

  if (diff.inDays > 0) {
    // For dates older than a day, format as "DD/MM/YYYY"
    formattedDate =
        "${_padWithZero(dateTime.day)}/${_padWithZero(dateTime.month)}/${dateTime.year}";
  } else if (diff.inHours > 0) {
    // For hours difference, show as "X hours ago"
    formattedDate = "${diff.inHours} hour${diff.inHours > 1 ? 's' : ''} ago";
  } else if (diff.inMinutes > 0) {
    // For minutes difference, show as "X minutes ago"
    formattedDate =
        "${diff.inMinutes} minute${diff.inMinutes > 1 ? 's' : ''} ago";
  } else {
    // For the current hour or less, format time as "HH:MM AM/PM"
    formattedDate = _formatTime(dateTime);
  }

  return formattedDate;
}

String _padWithZero(int number) {
  return number.toString().padLeft(2, '0');
}

String _formatTime(DateTime dateTime) {
  final hour = dateTime.hour % 12 == 0
      ? 12
      : dateTime.hour % 12; // Convert to 12-hour format
  final minute = _padWithZero(dateTime.minute);
  final period = dateTime.hour >= 12 ? 'PM' : 'AM';
  return "$hour:$minute $period";
}

String? passwordValidator(String? p0) {
  if (p0 == null || p0.trim().isEmpty) {
    return "कृपया पासवर्ड आवश्यक छ";
  }
  if (p0.length <= 6) {
    return "पासवर्डको लम्बाई ६ भन्दा बढी हुनुपर्छ";
  }
  return null;
}
