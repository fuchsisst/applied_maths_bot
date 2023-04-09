import 'package:teledart/teledart.dart';

import '../../../../command_text.dart';
import '../system_analysis_124_keyboard/system_analisys_124_keyboard.dart';

void appliedMathFunc(TeleDart teleDart){
  teleDart
      .onMessage(keyword: about.text)
      .where((message) => message.text?.contains(about.text) ?? false)
      .listen((message) => message.reply(
    info_113,
  ));

}