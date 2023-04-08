import 'package:teledart/model.dart';

//KeyBoardButton for 124 - System Analysis
final about = KeyboardButton(text: 'About');
final statistics = KeyboardButton(text: 'Statistics');
final admissionTips = KeyboardButton(text: 'Admission Tips');
final faqs = KeyboardButton(text: 'FAQs');
final back = KeyboardButton(text: 'Back');

List<List<KeyboardButton>> keyboardMenu = [
  [about, statistics],
  [admissionTips, faqs],
  [back],
];

final systemAnalysisMarkup =
ReplyKeyboardMarkup(resizeKeyboard: true, keyboard: keyboardMenu);