import 'package:teledart/model.dart';

//KeyBoardButton for Вступ до 124 section
final inspectionBoard = InlineKeyboardButton(
    text: 'Приймальна комісія',
    url:
    'https://us04web.zoom.us/j/77033238358#success');
final ics = InlineKeyboardButton(
    text: 'Інститут Комп\'ютерних Систем',
    url: 'https://us02web.zoom.us/j/2637843814?pwd=TkZLeU1MY2d5eUpqeTJ5WUJTRHlVUT09#success');
final uni = InlineKeyboardButton(
    text: 'Українсько-німецький інститут',
    url: 'https://us02web.zoom.us/j/86178906435?pwd=bkhtRlNxL3E3SnZCTU1oSFNHcHJNQT09#success');
final upi = InlineKeyboardButton(
    text: 'Українсько-польський інститут',
    url: 'https://us04web.zoom.us/j/85796357100?pwd=TkZLeU1MY2d5eUpqeTJ5WUJTRHlVUT09#success');
final uii = InlineKeyboardButton(
    text: 'Українсько-іспанський інститут',
    url: 'https://zoom.us/j/4645745543?pwd=b3M4cFJxUHFnZnpuU3kyWW8vNzg0QT09#success');

List<List<InlineKeyboardButton>> keyboardVstup = [
  [inspectionBoard],
  [ics],
  [uni, upi, uii],
];

final markupVstup =
InlineKeyboardMarkup(inlineKeyboard: keyboardVstup);
