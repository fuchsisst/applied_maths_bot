import 'package:applied_maths_bot/command_text.dart';
import 'package:teledart/teledart.dart';

import 'applied_math_113_keyboard.dart';
import 'inline_vstup_applied_math_113_keyboard.dart';

void appliedMathFunc(TeleDart teleDart){
  teleDart
      .onMessage(keyword: about113.text)
      .where((message) => message.text?.contains(about113.text) ?? false)
      .listen((message) => message.reply(
    aboutAppliedMath,
  ));
  teleDart
      .onMessage(keyword: statistics.text)
      .where((message) => message.text?.contains(statistics.text) ?? false)
      .listen((message) => message.reply(
    statisticAppliedMath,
  ));
  teleDart
      .onMessage(keyword: admissionTips.text)
      .where((message) => message.text?.contains(admissionTips.text) ?? false)
      .listen((message) => message.replyPhoto(admissionMONUkraine2023, caption: admissionTipsAppliedMath, replyMarkup: markupVstup
  ));

}