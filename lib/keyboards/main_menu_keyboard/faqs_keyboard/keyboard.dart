import 'package:teledart/model.dart';

//KeyBoardButton for Social Media section
final answerChat = InlineKeyboardButton(
    text: 'Відповісти', callbackData: 'Start Chatting');

List<List<InlineKeyboardButton>> keyboardChat = [
  [answerChat],
];

final markupChat =
InlineKeyboardMarkup(inlineKeyboard: keyboardChat);