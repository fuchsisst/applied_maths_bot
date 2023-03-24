import 'dart:async';
import 'dart:io';

import 'package:applied_maths_bot/command_text.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';

Future<void> main() async {
  var BOT_TOKEN = '5839246590:AAGamMdzCPzjFn0xgKCl0nmk7juW8oAG4eI';
  // init Telegram
  final username = (await Telegram(BOT_TOKEN).getMe()).username;
  final WEBAPP_HOST = '0.0.0.0';
  final WEBAPP_PORT = int.parse(Platform.environment['PORT'] ?? '8000');
  // Add this line of code to bind to $PORT
 // final port = int.parse(Platform.environment['PORT'] ?? '8000');
 // final teleDart = TeleDart(BOT_TOKEN, Event(username!));
 //teleDart.start();
 // teleDart.setWebhook('https://dashboard.heroku.com/apps/appliedmathsbotdart0/$BOT_TOKEN',dropPendingUpdates: true );


 // void startWebhook() async{
 //   await teleDart.setWebhook('https://dashboard.heroku.com/apps/appliedmathsbotdart0/$BOT_TOKEN',dropPendingUpdates: true );
 //  }
 //
 //  void deleteWebhook() async {
 //   await teleDart.deleteWebhook();
 //  }


  var webhook = await Webhook.createHttpWebhok(
      Telegram(BOT_TOKEN),
    'https://appliedmathsbotdart0.herokuapp.com/webhook/{TOKEN}',
      serverPort: WEBAPP_PORT,
      dropPendingUpdates: true);

  var teleDart = TeleDart(BOT_TOKEN, Event(username!), fetcher: webhook);
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

  teleDart
      .onCommand('info_113')
      .listen((message) => message.reply(
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

//
//
