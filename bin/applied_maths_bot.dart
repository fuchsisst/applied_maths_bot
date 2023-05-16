import 'dart:async';
import 'dart:io';

import 'package:applied_maths_bot/command_text.dart';
import 'package:applied_maths_bot/constants.dart';
import 'package:applied_maths_bot/keyboards/main_menu_keyboard/faqs_keyboard/chat.dart';
import 'package:applied_maths_bot/keyboards/main_menu_keyboard/faqs_keyboard/chat_function.dart';
import 'package:applied_maths_bot/keyboards/main_menu_keyboard/faqs_keyboard/chat_keyboard.dart';
import 'package:applied_maths_bot/keyboards/main_menu_keyboard/info_keyboard/applied_math_113_keyboard/applied_math_113_function.dart';
import 'package:applied_maths_bot/keyboards/main_menu_keyboard/info_keyboard/info_function.dart';
import 'package:applied_maths_bot/keyboards/main_menu_keyboard/info_keyboard/system_analysis_124_keyboard/system_analisys_124_function.dart';
import 'package:applied_maths_bot/keyboards/main_menu_keyboard/main_menu_function.dart';
import 'package:applied_maths_bot/keyboards/main_menu_keyboard/main_menu_keyboard.dart';
import 'package:teledart/src/telegram/model.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';

Future<void> main() async {
  //Метод getMe() возращает основную информацию о боте в виде объекта User.
  //Из объекта получаем свойство класса username, то есть имя пользователя.
  final username = (await Telegram(botToken).getMe()).username;
  final bot = Telegram(botToken);

  //Определение порта, на котором будет запущено веб-приложение,
  //и преобразования его значения в целое число.
  final webappPort = int.parse(Platform.environment['PORT'] ?? '8000');

  //Создание Вебхука с использованием протокола HTTP
  //Задается URL-адрес сервера, к которому будет привязан вебхук,
  //с использованием переменной webappPort, которая содержит порт сервера.
  var webhook = await Webhook.createHttpWebhok(Telegram(botToken),
      'https://appliedmathsbotdart0.herokuapp.com/webhook/$botToken',
      serverPort: webappPort, dropPendingUpdates: true);

  var teleDart = TeleDart(botToken, Event(username!), fetcher: webhook);

  teleDart.start();
  Map<int, String> adminStates = {};
  mainMenuFunc(teleDart);
  infoFunc(teleDart);
  systemAnalysisFunc(teleDart);
  appliedMathFunc(teleDart);
  chatFunc(teleDart, adminStates, bot);

  teleDart.onCommand('start').listen((message) => message.reply(
        startMessage,
        replyMarkup: markupMenu,
        disableNotification: true,
      ));

  teleDart.onCommand('info_113').listen((message) => message.reply(
        aboutAppliedMath,
        replyMarkup: markupMenu,
        disableNotification: true,
      ));

  //Карта для отслеживания состояний пользователей
  Map<int, String> userStates = {};

  teleDart.onCommand('chat').listen((message) async {
    final chatId = message.chat.id;

    await message.reply('Задайте вопрос:');

    // Устанавливаем состояние "ожидание сообщения" для данного пользователя
    userStates[chatId] = 'waiting_for_message';
  });

  teleDart.onMessage().listen((message) {
    final chatId = message.chat.id;
    final text = message.text;

    // Проверяем состояние пользователя
    if (userStates.containsKey(chatId) && userStates[chatId] == 'waiting_for_message') {
      // Отправляем сообщение админу
      message_hand(message, bot);

      // Сбрасываем состояние пользователя
      userStates.remove(chatId);

      message.reply('Сообщение отправлено админу. Спасибо!');
    }
  });
}
