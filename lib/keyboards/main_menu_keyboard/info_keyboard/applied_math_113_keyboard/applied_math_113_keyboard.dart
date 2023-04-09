import 'package:teledart/model.dart';

//KeyBoardButton for 113 - Applied Math
final about = KeyboardButton(text: 'About');
final statistics = KeyboardButton(text: 'Statistics');
final admissionTips = KeyboardButton(text: 'Admission Tips');
final faqs = KeyboardButton(text: 'FAQs');
final backInfo = KeyboardButton(text: 'Back');

List<List<KeyboardButton>> keyboardMenu = [
  [about , statistics],
  [admissionTips, faqs],
  [backInfo],
];

final appliedMathMarkup =
ReplyKeyboardMarkup(resizeKeyboard: true, keyboard: keyboardMenu);