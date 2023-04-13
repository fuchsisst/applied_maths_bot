import 'package:applied_maths_bot/command_text.dart';
import 'package:applied_maths_bot/keyboards/main_menu_keyboard/info_keyboard/info_keyboard.dart';
import 'package:teledart/teledart.dart';

import 'system_analisys_124_keyboard.dart';

void systemAnalysisFunc(TeleDart teleDart) {
  teleDart
      .onMessage(keyword: about124.text)
      .where((message) => message.text?.contains(about124.text) ?? false)
      .listen((message) => message.reply(
    aboutSystemAnalysis,
  ));
  teleDart
      .onMessage(keyword: statistics.text)
      .where((message) => message.text?.contains(statistics.text) ?? false)
      .listen((message) => message.reply(
    statisticSystemAnalysis,
  ));
  teleDart
      .onMessage(keyword: admissionTips.text)
      .where((message) => message.text?.contains(admissionTips.text) ?? false)
      .listen((message) => message.replyPhoto('https://mon.gov.ua/storage/app/uploads/public/642/536/34e/64253634e8e87484387527.jpg', caption: admissionTipsSystemAnalysis));
  teleDart
      .onMessage(keyword: backInfo.text)
      .where((message) => message.text?.contains(backInfo.text) ?? false)
      .listen((message) => message.reply(
    infoMessage,
    replyMarkup: infoMarkup,
  ));
}
