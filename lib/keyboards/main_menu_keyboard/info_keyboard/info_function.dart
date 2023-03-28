import 'package:applied_maths_bot/command_text.dart';
import 'package:applied_maths_bot/keyboards/main_menu_keyboard/main_menu_keyboard.dart';
import 'package:teledart/teledart.dart';

import 'info_keyboard.dart';

void infoFunc(TeleDart teleDart) {
  teleDart
      .onMessage(keyword: appliedMath_113.text)
      .where((message) => message.text?.contains(appliedMath_113.text) ?? false)
      .listen((message) => message.reply(
            info_113,
          ));
  teleDart
      .onMessage(keyword: systemAnalysis_124.text)
      .where(
          (message) => message.text?.contains(systemAnalysis_124.text) ?? false)
      .listen((message) => message.reply(inProcess));
  teleDart
      .onMessage(keyword: back.text)
      .where((message) => message.text?.contains(back.text) ?? false)
      .listen((message) => message.reply(
            'Головне меню',
            replyMarkup: markupMenu,
          ));
}
