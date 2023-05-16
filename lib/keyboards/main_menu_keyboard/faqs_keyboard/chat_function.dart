import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';

import 'chat.dart';
import 'chat_keyboard.dart';

void chatFunc(TeleDart teleDart, Map<int, String> adminStates, Telegram bot) {
  teleDart
      .onMessage(keyword: startChat.text)
      .where((message) => message.text?.contains(startChat.text) ?? false)
      .listen((message) {
    message.reply(
      'Розпочато спілкування з користувачем',
      replyMarkup: markupFAQS,
    );

    int chatId = message.chat.id;
    adminStates[chatId] = 'waiting_for_message';
    teleDart.onMessage().listen((message) async {
      final chatId = message.chat.id;

      // Проверяем состояние пользователя
      while (adminStates.containsKey(chatId) && adminStates[chatId] == 'waiting_for_message') {

        // Отправляем сообщение админу
        await message_client(message, bot);

        // Сбрасываем состояние пользователя


        message.reply('Сообщение отправлено админу. Спасибо!');
        adminStates.remove(chatId);
      }
    });
  });
}
