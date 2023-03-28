import 'dart:async';
import 'dart:io';

import 'package:applied_maths_bot/command_text.dart';
import 'package:applied_maths_bot/constants.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';

Future<void> main() async {
  //Метод getMe() возращает основную информацию о боте в виде объекта User.
  //Из объекта получаем свойство класса username, то есть имя пользователя.
  final username = (await Telegram(botToken).getMe()).username;

  //
  final webappPort = int.parse(Platform.environment['PORT'] ?? '8000');

  var webhook = await Webhook.createHttpWebhok(Telegram(botToken),
      'https://appliedmathsbotdart0.herokuapp.com/webhook/$botToken',
      serverPort: webappPort, dropPendingUpdates: true);

  var teleDart = TeleDart(botToken, Event(username!), fetcher: webhook);
  teleDart.start();

  //KeyBoardButton for main menu
  final info113 = KeyboardButton(text: 'Інфо');
  final socialMedia = KeyboardButton(text: 'Соцмережі');
  final news = KeyboardButton(text: 'Новини');
  final fAQ = KeyboardButton(text: 'FAQ');

  List<List<KeyboardButton>> keyboardMenu = [
    [info113],
    [socialMedia],
    [news],
    [fAQ]
  ];

  final markupMenu =
      ReplyKeyboardMarkup(resizeKeyboard: true, keyboard: keyboardMenu);

  //
  final instagram = InlineKeyboardButton(
      text: 'Instagram',
      url:
          'https://www.instagram.com/appliedmathematics_onpu/?igshid=YmMyMTA2M2Y%3D');
  final facebook = InlineKeyboardButton(
      text: 'Facebook', url: 'https://m.facebook.com/AppliedMathematicsONPU/');
  final telegramChannel = InlineKeyboardButton(
      text: 'Telegram Channel', url: 'https://t.me/applyed_math');

  List<List<InlineKeyboardButton>> keyboardSocialMedia = [
    [instagram],
    [facebook],
    [telegramChannel]
  ];

  final markupSocialMedia =
      InlineKeyboardMarkup(inlineKeyboard: keyboardSocialMedia);

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
}
