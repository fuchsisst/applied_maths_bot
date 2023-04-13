import 'package:teledart/model.dart';

//KeyBoardButton for 124 - System Analysis
final about124 = KeyboardButton(text: 'Про спеціальність 124');
final statistics = KeyboardButton(text: 'Статистика ринку для 124');
final admissionTips = KeyboardButton(text: 'Вступ 2023 для 124');
final faqs = KeyboardButton(text: 'FAQs 124');
final backInfo = KeyboardButton(text: 'Back');

List<List<KeyboardButton>> keyboardMenu = [
  [about124, statistics],
  [admissionTips, faqs],
  [backInfo],
];

final systemAnalysisMarkup =
ReplyKeyboardMarkup(resizeKeyboard: true, keyboard: keyboardMenu);