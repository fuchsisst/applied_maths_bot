import 'dart:async';

import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';
import 'dart:io' as io;

const telegramApiKey = '5839246590:AAGamMdzCPzjFn0xgKCl0nmk7juW8oAG4eI';

Future<void> main() async {

  // init Telegram
  final telegram = Telegram(telegramApiKey);
  final event = Event((await telegram.getMe()).username!);
  final teledart = TeleDart(telegram as String, event);

  // start bot
  teledart.start();

  // when user input command with keyword 'start', execute this block
  teledart.onCommand('start').listen((message) {

    // create buttons
    final testButton = KeyboardButton(text: 'Test medium');
    final anotheButton = KeyboardButton(text: 'Another button');
    final loadImages = KeyboardButton(text: 'Load images');
    final deleteImages = KeyboardButton(text: 'Delete images');

    // arrange buttons boy two in line
    final twoButtonList = [testButton, anotheButton];
    final imageButtonList = [loadImages, deleteImages];

    // grab all buttons together
    final markup = ReplyKeyboardMarkup(
      keyboard: [twoButtonList, imageButtonList],
    );

    // send message to user
    teledart.sendMessage(
      message.chat.id,
      'Try it',
    );
  });

  // when user input text with keyword 'Another button', execute this block
  teledart.onMessage(keyword: 'Another button').listen((message) {
    final testButton = KeyboardButton(text: 'Test medium');
    final anotheButton = KeyboardButton(text: 'Another button');
    final loadImages = KeyboardButton(text: 'Load images');
    final deleteImages = KeyboardButton(text: 'Delete images');

    final twoButtonList = [testButton, anotheButton];
    final imageButtonList = [loadImages, deleteImages];

    final markup = ReplyKeyboardMarkup(
      keyboard: [twoButtonList, imageButtonList],
    );

    teledart.sendMessage(
      message.chat.id,
      'Try it: Another button',
    );
  });

  // when user input text with keyword 'Test medium', execute this block
  teledart.onMessage(keyword: 'Test medium').listen((message) {
    final testButton = KeyboardButton(text: 'Test medium');
    final anotheButton = KeyboardButton(text: 'Another button');
    final loadImages = KeyboardButton(text: 'Load images');
    final deleteImages = KeyboardButton(text: 'Delete images');

    final twoButtonList = [testButton, anotheButton];
    final imageButtonList = [loadImages, deleteImages];

    final markup = ReplyKeyboardMarkup(
      keyboard: [twoButtonList, imageButtonList],
    );

    teledart.sendMessage(
      message.chat.id,
      'Try it: Test medium',
    );
  });

  // if user typed and send to bot anything except those one in if-statement,
  // execute block
  teledart.onMessage().listen((message) {
    if (message.text != 'Test medium' &&
        message.text != 'Another button' &&
        message.text != 'Load images' &&
        message.text != 'Delete images' &&
        message.photo == null) {
      teledart.sendMessage(
        message.chat.id,
        'Nice try',
      );
    }
  });

  // execute this if user hit 'Load images' button
  teledart.onMessage(keyword: 'Load images').listen((message) async {

    // ask user to select one photo
    teledart.sendMessage(message.chat.id, 'choose one');

    // subscribe to user input
    final subscription = teledart.onMessage().listen((_) {});

    // listen subscription
    subscription.onData((data) async {

      // if user upload photo do the following
      if (data.photo != null) {

        // create the dicrectory on the host
        final dir =
        await io.Directory('/var/upload/${message.chat.id}').create();

        // download photo to the directory
        downloadPhoto(
          '${dir.path}/img.png',
          telegramApiKey,
          data,
          teledart,
        ).then((value) =>
            teledart.sendMessage(data.chat.id, 'image loaded'));
      }
    });
  });

  // execute this if user hit 'Delete images' button
  teledart.onMessage(keyword: 'Delete images').listen((message) {
    // delete folder and image in it
    deletePhotosDirectory(teledart, message).then((value) =>
        teledart.sendMessage(message.chat.id, 'image deleted'));
  });
}

Future<void> downloadPhoto(
    String path,
    String telegramApiKey,
    TeleDartMessage message,
    TeleDart teledart,
    ) async {
  final tPhoto = message.photo!.last;
  final tFile = await teledart.getFile(tPhoto.fileId);
  final tFileLink = tFile.getDownloadLink(telegramApiKey);
  final request = await io.HttpClient().getUrl(Uri.parse(tFileLink!));
  final response = await request.close();
  await response.pipe(io.File(path).openWrite()) as io.File;
}

Future<void> deletePhotosDirectory(
    TeleDart teledart,
    TeleDartMessage message,
    ) async {
  final dir = io.Directory('/var/upload/${message.chat.id}');
  final isDirExist = await dir.exists();
  if (isDirExist) {
    await io.Directory('/var/upload/${message.chat.id}')
        .delete(recursive: true);
  } else {
    teledart.sendMessage(message.chat.id, 'Nothing to delete');
  }
}