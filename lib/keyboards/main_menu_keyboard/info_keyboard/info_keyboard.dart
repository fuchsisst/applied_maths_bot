import 'package:teledart/model.dart';

//KeyBoardButton for info
final appliedMath_113 = KeyboardButton(text: '113 - Прикладна математика');
final systemAnalysis_124 = KeyboardButton(text: '124 - Системний аналіз');
final back = KeyboardButton(text: 'Назад');

List<List<KeyboardButton>> keyboardMenu = [
  [appliedMath_113],
  [systemAnalysis_124],
  [back],
];

final infoMarkup =
ReplyKeyboardMarkup(resizeKeyboard: true, keyboard: keyboardMenu);