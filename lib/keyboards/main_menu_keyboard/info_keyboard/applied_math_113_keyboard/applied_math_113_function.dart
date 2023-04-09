import 'package:applied_maths_bot/command_text.dart';
import 'package:teledart/teledart.dart';
import '../info_keyboard.dart';
import 'applied_math_113_keyboard.dart';

void appliedMathFunc(TeleDart teleDart){
  teleDart
      .onMessage(keyword: about113.text)
      .where((message) => message.text?.contains(about113.text) ?? false)
      .listen((message) => message.reply(
    info_113,
  ));
  teleDart
      .onMessage(keyword: backInfo.text)
      .where((message) => message.text?.contains(backInfo.text) ?? false)
      .listen((message) => message.reply(
    infoMessage,
    replyMarkup: infoMarkup,
  ));

}