import 'package:teledart/model.dart';

//KeyBoardButton for FAQs section
final startChat = InlineKeyboardButton(
    text: 'Розпочати спілкування',
  );

List<List<InlineKeyboardButton>> keyboardFAQs = [
  [startChat],
];

final markupFAQS =
InlineKeyboardMarkup(inlineKeyboard: keyboardFAQs);
