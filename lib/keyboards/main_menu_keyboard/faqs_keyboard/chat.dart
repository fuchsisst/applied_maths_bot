
//Отримання повідомлення від користувача
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';

import '../../../constants.dart';
import 'inline_faqs_keyboard.dart';

Future<void> message_hand(Message message, Telegram bot) async {
  final chatId = message.chat.id;
  final text = message.text;


  await bot.sendMessage(adminChatId, "Новое сообщение от клиента $chatId: $text", replyMarkup: markupFAQS);
}

Future<void> message_client(Message message, Telegram bot) async {
  final chatId = message.chat.id;
  final text = message.text;


  await bot.sendMessage(chatId, "$text", replyMarkup: markupFAQS);
}