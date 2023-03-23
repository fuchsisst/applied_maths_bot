import 'dart:async';

import 'package:applied_maths_bot/command_text.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';

var BOT_TOKEN = '5839246590:AAGamMdzCPzjFn0xgKCl0nmk7juW8oAG4eI';

Future<void> main() async {
  // init Telegram
  final username = (await Telegram(BOT_TOKEN).getMe()).username;
  var teledart = TeleDart(BOT_TOKEN, Event(username!));

  teledart.start();

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

  teledart.onCommand('start').listen(
      (message) => message.reply(startMessage, replyMarkup: markupMenu));
  teledart
      .onCommand('info_113')
      .listen((message) => message.reply(info_113, replyMarkup: markupMenu));

  teledart
      .onMessage(keyword: info113.text)
      .where((message) => message.text?.contains(info113.text) ?? false)
      .listen((message) => message.reply(info_113));

  teledart
      .onMessage(keyword: socialMedia.text)
      .where((message) => message.text?.contains(socialMedia.text) ?? false)
      .listen((message) =>
          message.reply('Social Media:', replyMarkup: markupSocialMedia));
}
//