import 'package:teledart/model.dart';

//KeyBoardButton for FAQs section
final startChat = InlineKeyboardButton(
    text: 'Розпочати спілкування',
  callbackData: 'Для закінчення, напишіть у чат "end"'
  );

List<List<InlineKeyboardButton>> keyboardFAQs = [
  [startChat],
];

final markupFAQS =
InlineKeyboardMarkup(inlineKeyboard: keyboardFAQs);
