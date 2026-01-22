import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../context/global.dart';
import '../providers/language_provider/l10n_provider.dart';

abstract class AppTextStyle extends TextStyle {
  static String lang = GlobalContext.context.read<LanguageProvider>().lang ?? 'en';
  static TextStyle style8 = TextStyle(fontSize: lang == 'en' ? 10 : 13);
  static TextStyle style8B = TextStyle(fontSize: lang == 'en' ? 10 : 13, fontWeight: FontWeight.bold);
  static TextStyle style9 = TextStyle(fontSize: lang == 'en' ? 11 : 14);
  static TextStyle style9B = TextStyle(fontSize: lang == 'en' ? 11 : 14, fontWeight: FontWeight.bold);
  static TextStyle style10 = TextStyle(fontSize: lang == 'en' ? 12 : 16);
  static TextStyle style10B = TextStyle(fontSize: lang == 'en' ? 12 : 16, fontWeight: FontWeight.bold);
  static TextStyle style11 = TextStyle(fontSize: lang == 'en' ? 13 : 16);
  static TextStyle style11B = TextStyle(fontSize: lang == 'en' ? 13 : 16, fontWeight: FontWeight.bold);
  static TextStyle style12 = TextStyle(fontSize: lang == 'en' ? 14 : 17);
  static TextStyle style12B = TextStyle(fontSize: lang == 'en' ? 14 : 17, fontWeight: FontWeight.bold);
  static TextStyle style14 = TextStyle(fontSize: lang == 'en' ? 14 : 17);
  static TextStyle style14B = TextStyle(fontSize: lang == 'en' ? 14 : 17, fontWeight: FontWeight.bold);
  static TextStyle style16 = TextStyle(fontSize: lang == 'en' ? 16 : 19);
  static TextStyle style16B = TextStyle(fontSize: lang == 'en' ? 16 : 19, fontWeight: FontWeight.bold);
  static TextStyle style18 = TextStyle(fontSize: lang == 'en' ? 18 : 21);
  static TextStyle style18B = TextStyle(fontSize: lang == 'en' ? 18 : 21, fontWeight: FontWeight.bold);
  static TextStyle style20 = TextStyle(fontSize: lang == 'en' ? 20 : 23);
  static TextStyle style20B = TextStyle(fontSize: lang == 'en' ? 20 : 23, fontWeight: FontWeight.bold);
  static TextStyle style22 = TextStyle(fontSize: lang == 'en' ? 22 : 25);
  static TextStyle style22B = TextStyle(fontSize: lang == 'en' ? 22 : 25, fontWeight: FontWeight.bold);
  static TextStyle style24 = TextStyle(fontSize: lang == 'en' ? 24 : 27);
  static TextStyle style24B = TextStyle(fontSize: lang == 'en' ? 24 : 27, fontWeight: FontWeight.bold);
  static TextStyle style26 = TextStyle(fontSize: lang == 'en' ? 26 : 29);
  static TextStyle style26B = TextStyle(fontSize: lang == 'en' ? 26 : 29, fontWeight: FontWeight.bold);
  static TextStyle style28 = TextStyle(fontSize: lang == 'en' ? 28 : 31);
  static TextStyle style28B = TextStyle(fontSize: lang == 'en' ? 28 : 31, fontWeight: FontWeight.bold);
  static TextStyle style30 = TextStyle(fontSize: lang == 'en' ? 30 : 33);
  static TextStyle style30B = TextStyle(fontSize: lang == 'en' ? 30 : 33, fontWeight: FontWeight.bold);
  static TextStyle style32 = TextStyle(fontSize: lang == 'en' ? 32 : 35);
  static TextStyle style32B = TextStyle(fontSize: lang == 'en' ? 32 : 35, fontWeight: FontWeight.bold);
  static TextStyle style34 = TextStyle(fontSize: lang == 'en' ? 34 : 37);
  static TextStyle style34B = TextStyle(fontSize: lang == 'en' ? 34 : 37, fontWeight: FontWeight.bold);
}
