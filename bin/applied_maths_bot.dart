import 'dart:async';
import 'dart:io';

import 'package:applied_maths_bot/command_text.dart';
import 'package:applied_maths_bot/constants.dart';
import 'package:applied_maths_bot/keyboards/inline_social_media_keyboard.dart';
import 'package:applied_maths_bot/keyboards/main_menu_keyboard.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';

Future<void> main() async {
  //Метод getMe() возращает основную информацию о боте в виде объекта User.
  //Из объекта получаем свойство класса username, то есть имя пользователя.
  final username = (await Telegram(botToken).getMe()).username;

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

  teleDart.onCommand('start').listen((message) => message.reply(
        startMessage,
        replyMarkup: markupMenu,
        disableNotification: true,
      ));

  teleDart.onCommand('info_113').listen((message) => message.reply(
        info_113,
        replyMarkup: markupMenu,
        disableNotification: true,
      ));

  teleDart
      .onMessage(keyword: info113.text)
      .where((message) => message.text?.contains(info113.text) ?? false)
      .listen((message) => message.reply(info_113));

  teleDart
      .onMessage(keyword: socialMedia.text)
      .where((message) => message.text?.contains(socialMedia.text) ?? false)
      .listen((message) => message.reply(
            'Social Media:',
            replyMarkup: markupSocialMedia,
            disableNotification: true,
          ));

  teleDart
      .onMessage(keyword: news.text)
      .where((message) => message.text?.contains(news.text) ?? false)
      .listen((message) => message.reply(inProcess));

  teleDart
      .onMessage(keyword: fAQ.text)
      .where((message) => message.text?.contains(fAQ.text) ?? false)
      .listen((message) => message.reply(inProcess));
}
