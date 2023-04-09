import 'package:teledart/model.dart';

//KeyBoardButton for 113 - Applied Math
final about113 = KeyboardButton(text: 'About 113');
final statistics = KeyboardButton(text: 'Statistics 113');
final admissionTips = KeyboardButton(text: 'Admission Tips 113');
final faqs = KeyboardButton(text: 'FAQs 113');
final backInfo = KeyboardButton(text: 'Back');

List<List<KeyboardButton>> keyboardMenu = [
  [about113 , statistics],
  [admissionTips, faqs],
  [backInfo],
];

final appliedMathMarkup =
ReplyKeyboardMarkup(resizeKeyboard: true, keyboard: keyboardMenu);