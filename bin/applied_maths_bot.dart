import 'dart:async';
import 'dart:io';

import 'package:applied_maths_bot/command_text.dart';
import 'package:applied_maths_bot/constants.dart';
import 'package:applied_maths_bot/keyboards/main_menu_keyboard/info_keyboard/applied_math_113_keyboard/applied_math_113_function.dart';
import 'package:applied_maths_bot/keyboards/main_menu_keyboard/info_keyboard/info_function.dart';
import 'package:applied_maths_bot/keyboards/main_menu_keyboard/info_keyboard/system_analysis_124_keyboard/system_analisys_124_function.dart';
import 'package:applied_maths_bot/keyboards/main_menu_keyboard/main_menu_function.dart';
import 'package:applied_maths_bot/keyboards/main_menu_keyboard/main_menu_keyboard.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';

Future<void> main() async {
  //Метод getMe() возращает основную информацию о боте в виде объекта User.
  //Из объекта получаем свойство класса username, то есть имя пользователя.
  final username = (await Telegram(botToken).getMe()).username;
  final bot = Telegram(botToken);

  //Определение порта, на котором будет запущено веб-приложение,
  //и преобразования его значения в целое число.
  final webappPort = int.parse(Platform.environment['PORT'] ?? '5000');

  //Создание Вебхука с использованием протокола HTTP
  //Задается URL-адрес сервера, к которому будет привязан вебхук,
  //с использованием переменной webappPort, которая содержит порт сервера.
  var webhook = await Webhook.createHttpWebhok(Telegram(botToken),
      'https://applied-math-bot.herokuapp.com/webhook/$botToken',
      serverPort: webappPort, dropPendingUpdates: true);

  var teleDart = TeleDart(botToken, Event(username!), fetcher: webhook);

  teleDart.start();

  mainMenuFunc(teleDart);
  infoFunc(teleDart);
  systemAnalysisFunc(teleDart);
  appliedMathFunc(teleDart);
  // chattingFunc(teleDart, bot);

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


}
