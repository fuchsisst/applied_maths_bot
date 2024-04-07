import 'package:teledart/model.dart';

//KeyBoardButton for 113 - Applied Math
final about113 = KeyboardButton(text: 'Про спеціальність 113');
final statistics = KeyboardButton(text: 'Статистика ринку для 113');
final admissionTips = KeyboardButton(text: 'Вступ 2024 для 113');
final backInfo = KeyboardButton(text: 'Back');

List<List<KeyboardButton>> keyboardMenu = [
  [about113 , statistics],
  [admissionTips, backInfo],
];

final appliedMathMarkup =
ReplyKeyboardMarkup(resizeKeyboard: true, keyboard: keyboardMenu);
