import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';

import '../../../constants.dart';
import 'keyboard.dart';

int? chatUserId;

void chattingFunc(TeleDart teleDart, Telegram bot) {
  // Состояния пользователей и администраторов
  Map<int, String> userStates = {};
  Map<int, String> adminStates = {};

  // Ставим "слушать" команду /chat
  teleDart.onCommand('chat').listen((message) async {
    chatUserId = message.chat.id;
    await message.reply('Задайте вопрос:');

    userStates[chatUserId!] = 'waiting_for_message';
  });

  // Снова слушаем сообщения
  teleDart.onMessage().listen((message) {
    final chatId = message.chat.id;

    if (userStates.containsKey(chatId) && userStates[chatId] == 'waiting_for_message') {
      messageToAdmin(userStates, adminStates, teleDart, message, bot);
      message.reply('Сообщение отправлено админу. Спасибо!');
    } else if (adminStates.containsKey(chatId) && adminStates[chatId] == 'chatting') {
      messageToClient(adminStates, teleDart, message, bot, userStates);
    }
  });
}
//
Future<void> messageToAdmin(
    Map<int, String> userStates,
    Map<int, String> adminStates,
    TeleDart teleDart,
    Message message,
    Telegram bot) async {
  final chatUser = message.chat.firstName;
  final chatId = message.chat.id;
  final text = message.text;

  if (adminStates.containsKey(chatId) && adminStates[chatId] == 'chatting') {
    await bot.sendMessage(adminChatId, "Cообщение от клиента $chatUser: $text");
  } else {
    await bot.sendMessage(adminChatId, "Новое сообщение от клиента $chatUser: $text");
  }

  teleDart.onMessage(keyword: 'Ответ').listen((message) async {
    adminStates[chatUserId!] = 'chatting';
    userStates[chatUserId!] = 'chatting';

    final chatId = message.chat.id;
    if (userStates.containsKey(chatId) && userStates[chatId] == 'chatting') {
      messageToClient(adminStates, teleDart, message, bot, userStates);
    }
  });

  var subscription = teleDart.onMessage().listen((message) async {
    final chatId = message.chat.id;
    if (userStates.containsKey(chatId) && userStates[chatId] == 'chatting') {
      messageToAdmin(userStates, adminStates, teleDart, message, bot);
    }
  });

  await Future.delayed(Duration(seconds: 1));
  subscription.cancel();
}

Future<void> messageToClient(
    Map<int, String> adminStates,
    TeleDart teleDart,
    Message message,
    Telegram bot,
    Map<int, String> userStates) async {
  teleDart.onMessage().listen((message) {
    final chatId = message.chat.id;
    if (userStates.containsKey(chatId) && userStates[chatId] == 'chatting') {
      messageToAdmin(userStates, adminStates, teleDart, message, bot);

    }}
    );

  teleDart.onMessage(keyword: 'Off').listen((message) async {
    final chatId = message.chat.id;
    await message.reply('Завершить');
    userStates.remove(chatId);
    adminStates.remove(chatId);
  });
}
