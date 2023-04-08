import 'package:applied_maths_bot/command_text.dart';
import 'package:applied_maths_bot/keyboards/main_menu_keyboard/info_keyboard/info_keyboard.dart';
import 'package:teledart/teledart.dart';

import 'system_analisys_124_keyboard.dart';

void systemAnalysisFunc(TeleDart teleDart) {

  teleDart
      .onMessage(keyword: about.text)
      .where((message) => message.text?.contains(about.text) ?? false)
      .listen((message) => message.reply(
    aboutSystemAnalysis,
  ));
  teleDart
      .onMessage(keyword: backInfo.text)
      .where((message) => message.text?.contains(backInfo.text) ?? false)
      .listen((message) => message.reply(
    infoMessage,
    replyMarkup: infoMarkup,
  ));
}
