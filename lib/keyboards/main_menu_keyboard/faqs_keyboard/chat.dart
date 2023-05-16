
//Отримання повідомлення від користувача
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';

import '../../../constants.dart';
import 'inline_faqs_keyboard.dart';

void message_hand(Message message, Telegram bot){
  final chatId = message.chat.id;
  final text = message.text;


  bot.sendMessage(adminChatId, "New message from client $chatId: ${message.messageId +1}");
}

//Відправка повідомлення до користувача