import 'package:teledart/model.dart';

//KeyBoardButton for 124 - System Analysis
final about124 = KeyboardButton(text: 'About');
final statistics = KeyboardButton(text: 'Statistics');
final admissionTips = KeyboardButton(text: 'Admission Tips');
final faqs = KeyboardButton(text: 'FAQs');
final backInfo = KeyboardButton(text: 'Back');

List<List<KeyboardButton>> keyboardMenu = [
  [about124, statistics],
  [admissionTips, faqs],
  [backInfo],
];

final systemAnalysisMarkup =
ReplyKeyboardMarkup(resizeKeyboard: true, keyboard: keyboardMenu);