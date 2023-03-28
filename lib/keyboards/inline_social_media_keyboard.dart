import 'package:teledart/model.dart';

//KeyBoardButton for Social Media section
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