import 'package:teledart/model.dart';

//KeyBoardButton for main menu
final info = KeyboardButton(text: 'Інфо');
final socialMedia = KeyboardButton(text: 'Соцмережі');
final news = KeyboardButton(text: 'Новини');
final chat_ = KeyboardButton(text: 'Чат');

List<List<KeyboardButton>> keyboardMenu = [
  [info, socialMedia],
  [news],
  [chat_]
];

final markupMenu =
    ReplyKeyboardMarkup(resizeKeyboard: true, keyboard: keyboardMenu);
