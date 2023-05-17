
//Отримання повідомлення від користувача
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';

import '../../../constants.dart';
import 'keyboard.dart';

void chattingFunc(TeleDart teleDart, Telegram bot) {
  // Состояния для пользователя и администратора
  Map<int, String> userStates = {};
  Map<int, String> adminStates = {};

  // Вызываем команду /chat со стороны пользователя
  teleDart.onCommand('chat').listen((message) async {
    final chatId = message.chat.id;

    await message.reply('Задайте вопрос:');

    // Устанавливаем состояние "ожидание сообщения" для данного пользователя
    userStates[chatId] = 'waiting_for_message';
  });

  // Слушаем "вопрос"-сообщение пользователя для отправки администратору
  teleDart.onMessage().listen((message) {
    final chatId = message.chat.id;

    // Проверяем состояние пользователя
    if (userStates.containsKey(chatId) && userStates[chatId] == 'waiting_for_message') {
      // Отправляем сообщение админу
      messageToAdmin(userStates, adminStates, teleDart, message, bot);

      // Сбрасываем состояние пользователя
      userStates.remove(chatId);

      message.reply('Сообщение отправлено админу. Спасибо!');
    }
  });

}

Future<void> messageToAdmin ( Map<int, String> userStates, Map<int, String> adminStates, TeleDart teleDart, Message message, Telegram bot) async {
  final chatUser = message.chat.firstName;
  final chatId = message.chat.id;
  final text = message.text;

  if(adminStates.containsKey(chatId) && adminStates[chatId] == 'chatting'){
    await bot.sendMessage(adminChatId, "Cообщение от клиента $chatUser: $text");
    teleDart.onMessage().listen((message) async {
      final chatId = message.chat.id;

      if (userStates.containsKey(chatId) && userStates[chatId] == 'chatting') {
        // Отправляем сообщение админу
        messageToAdmin(userStates, adminStates, teleDart, message, bot);

      }
    });
  }
  await bot.sendMessage(adminChatId, "Новое сообщение от клиента $chatUser: $text", replyMarkup: markupChat);

  teleDart.onMessage(keyword: 'Відповісти').listen((message) async {
    final chatId = message.chat.id;
    await message.reply('Старт чата');

    // Устанавливаем состояние "chatting" для данного пользователя
    adminStates[chatId] = 'chatting';
    messageToClient(adminStates, teleDart, message, bot, userStates);

  });

}

Future<void> messageToClient(Map<int, String> adminStates, TeleDart teleDart, Message message, Telegram bot, Map<int, String> userStates) async {

  teleDart.onMessage().listen((message) async {
    final chatId = message.chat.id;
    await message.reply('Администратор на месте, ожидайте');

    // Устанавливаем состояние "chatting" для данного пользователя
    userStates[chatId] = 'chatting';

    if (userStates.containsKey(chatId) && userStates[chatId] == 'chatting') {
      // Отправляем сообщение админу
      messageToAdmin(userStates, adminStates, teleDart, message, bot);

    }

  });

  teleDart.onMessage(keyword: 'Off').listen((message) async {
    final chatId = message.chat.id;
    await message.reply('Завершить');

    // Устанавливаем состояние "chatting" для данного пользователя
    userStates.remove(chatId);
    adminStates.remove(chatId);

  });

}