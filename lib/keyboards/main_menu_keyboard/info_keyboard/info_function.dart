import 'package:applied_maths_bot/command_text.dart';
import 'package:applied_maths_bot/keyboards/main_menu_keyboard/main_menu_keyboard.dart';
import 'package:teledart/teledart.dart';

import 'applied_math_113_keyboard/applied_math_113_keyboard.dart';
import 'info_keyboard.dart';
import 'system_analysis_124_keyboard/system_analisys_124_keyboard.dart' as sysAnalisKeyboard;


void infoFunc(TeleDart teleDart) {
  teleDart
      .onMessage(keyword: appliedMath_113.text)
      .where((message) => message.text?.contains(appliedMath_113.text) ?? false)
      .listen((message) => message.reply(
           menu_systemAnalysis, replyMarkup: appliedMathMarkup
          ));
  teleDart
      .onMessage(keyword: systemAnalysis_124.text)
      .where(
          (message) => message.text?.contains(systemAnalysis_124.text) ?? false)
      .listen((message) => message.reply(menu_systemAnalysis, replyMarkup: sysAnalisKeyboard.systemAnalysisMarkup));
  teleDart
      .onMessage(keyword: back.text)
      .where((message) => message.text?.contains(back.text) ?? false)
      .listen((message) => message.reply(
            'Головне меню',
            replyMarkup: markupMenu,
          ));
}
