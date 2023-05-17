import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';

import '../../../constants.dart';
import 'keyboard.dart';
int? chatUserId;
void chattingFunc(TeleDart teleDart, Telegram bot) {
  // Состояния для пользователя и администратора.
  // Состояние 'waiting_for_message' устанавливаем для пользователя, когда
  // он отправил сообщение и ожидает ответа администратора
  // Состояние 'chatting' устанавливается для обоих сторон в случае принятия
  // переписки админом.
  Map<int, String> userStates = {};
  Map<int, String> adminStates = {};


  // Вызываем команду /chat со стороны пользователя
  teleDart.onCommand('chat').listen((message) async {
    chatUserId = message.chat.id;
    print(chatUserId);
    await message.reply('Задайте вопрос:');

    // Устанавливаем состояние "ожидание сообщения" для данного пользователя
    userStates[chatUserId!] = 'waiting_for_message';
  });

  // Слушаем "вопрос"-сообщение пользователя для отправки администратору
  teleDart.onMessage().listen((message) {

    // Проверяем состояние пользователя
    if (userStates.containsKey(chatUserId) && userStates[chatUserId] == 'waiting_for_message') {
      // Отправляем сообщение админу
      messageToAdmin(userStates, adminStates, teleDart, message, bot);

      // // Сбрасываем состояние пользователя
      // userStates.remove(chatUserId);

      message.reply('Сообщение отправлено админу. Спасибо!');
    } else if (adminStates.containsKey(chatUserId) && adminStates[chatUserId] == 'chatting') {
      // Отправляем сообщение клиенту
      messageToClient(adminStates, teleDart, message, bot, userStates);
    }
  });

}

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

  // Отписываемся от прослушивания сообщений, чтобы избежать повторной обработки
  var subscription = teleDart.onMessage().listen((message) async {
    final chatId = message.chat.id;
    if (userStates.containsKey(chatId) && userStates[chatId] == 'chatting') {
      // Отправляем сообщение админу
      messageToAdmin(userStates, adminStates, teleDart, message, bot);
    }
  });

  // Ждем некоторое время, чтобы обеспечить отправку сообщения администратору
  await Future.delayed(Duration(seconds: 1));

  // Отменяем подписку после отправки сообщения администратору
  subscription.cancel();
}


Future<void> messageToClient(Map<int, String> adminStates, TeleDart teleDart, Message message, Telegram bot, Map<int, String> userStates) async {
  teleDart.onMessage().listen((message) async {
    final chatId = message.chat.id;

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