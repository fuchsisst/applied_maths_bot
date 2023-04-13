import 'package:teledart/model.dart';

//KeyBoardButton for 113 - Applied Math
final about113 = KeyboardButton(text: 'Про спеціальність 113');
final statistics = KeyboardButton(text: 'Статистика ринку для 113');
final admissionTips = KeyboardButton(text: 'Вступ 2023 для 113');
final faqs = KeyboardButton(text: 'FAQs 113');
final backInfo = KeyboardButton(text: 'Back');

List<List<KeyboardButton>> keyboardMenu = [
  [about113 , statistics],
  [admissionTips, faqs],
  [backInfo],
];

final appliedMathMarkup =
ReplyKeyboardMarkup(resizeKeyboard: true, keyboard: keyboardMenu);