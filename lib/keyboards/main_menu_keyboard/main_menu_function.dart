import 'package:applied_maths_bot/command_text.dart';
import 'package:applied_maths_bot/keyboards/inline_social_media_keyboard.dart';
import 'package:teledart/teledart.dart';

import 'info_keyboard/info_keyboard.dart';
import 'main_menu_keyboard.dart';

void mainMenuFunc(TeleDart teleDart) {
  teleDart
      .onMessage(keyword: info.text)
      .where((message) => message.text?.contains(info.text) ?? false)
      .listen((message) => message.reply(
            infoMessage,
            replyMarkup: infoMarkup,
          ));
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
      .onMessage(keyword: chat_.text)
      .where((message) => message.text?.contains(chat_.text) ?? false)
      .listen((message) => message.reply(chat));
}
