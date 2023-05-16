
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
      messageToAdmin(message, bot);

      // Сбрасываем состояние пользователя
      userStates.remove(chatId);

      message.reply('Сообщение отправлено админу. Спасибо!');
    }
  });

}

Future<void> messageToAdmin (Message message, Telegram bot) async {
  final chatUsername = message.chat.username;
  final text = message.text;


  await bot.sendMessage(adminChatId, "Новое сообщение от клиента $chatUsername: $text", replyMarkup: markupChat);

}

Future<void> messageToClient(Message message, Telegram bot) async {
  final chatId = message.chat.id;
  final text = message.text;


  await bot.sendMessage(chatId, "$text", replyMarkup: markupChat);
}