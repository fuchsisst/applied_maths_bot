import 'package:teledart/model.dart';

//KeyBoardButton for main menu
final info113 = KeyboardButton(text: 'Інфо');
final socialMedia = KeyboardButton(text: 'Соцмережі');
final news = KeyboardButton(text: 'Новини');
final fAQ = KeyboardButton(text: 'FAQ');

List<List<KeyboardButton>> keyboardMenu = [
  [info113],
  [socialMedia],
  [news],
  [fAQ]
];

final markupMenu =
    ReplyKeyboardMarkup(resizeKeyboard: true, keyboard: keyboardMenu);
