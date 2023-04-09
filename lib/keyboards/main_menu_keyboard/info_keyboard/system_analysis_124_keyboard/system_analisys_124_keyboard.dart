import 'package:teledart/model.dart';

//KeyBoardButton for 124 - System Analysis
final about124 = KeyboardButton(text: 'About 124');
final statistics = KeyboardButton(text: 'Statistics 124');
final admissionTips = KeyboardButton(text: 'Admission Tips 124');
final faqs = KeyboardButton(text: 'FAQs 124');
final backInfo = KeyboardButton(text: 'Back');

List<List<KeyboardButton>> keyboardMenu = [
  [about124, statistics],
  [admissionTips, faqs],
  [backInfo],
];

final systemAnalysisMarkup =
ReplyKeyboardMarkup(resizeKeyboard: true, keyboard: keyboardMenu);