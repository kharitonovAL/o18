import 'dart:async';
import 'dart:io';
import 'dart:io' as io;

import 'package:bot_app/models/models.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';

class BotMethods {
  final TeleDart teledart;

  const BotMethods({
    required this.teledart,
  });

  Future<void> initParseServer({
    required String parseAppId,
    required String masterKey,
  }) async {
    const parseServerUrl = 'https://<YOUR_PARSE_SERVER_URL>/parse/';
    await Parse().initialize(
      parseAppId,
      parseServerUrl,
      masterKey: masterKey,
      coreStore: CoreStoreMemoryImp(),
      registeredSubClassMap: <String, ParseObjectConstructor>{
        'UserRequest': () => UserRequest(),
        'House': () => House(),
        'Flat': () => Flat(),
        'Account': () => Account(),
        'RequestNumber': () => RequestNumber(),
        'Owner': () => Owner(),
        'ImageFile': () => ImageFile(),
      },
    );
  }

  void start() => teledart.start();

  void onStartCommand(TeleDart teledart) {
    teledart.onCommand('start').listen((message) {
      final newRequestButton = KeyboardButton(text: 'Подать заявку');

      // todo: activate later
      // final sendCounterReadingsButton = KeyboardButton(text: 'Подать показания');

      final newRequestButtonList = [newRequestButton];
      // final sendCounterReadingsButtonList = [sendCounterReadingsButton];

      final markup = ReplyKeyboardMarkup(
        keyboard: [newRequestButtonList], //, sendCounterReadingsButtonList],
        one_time_keyboard: true,
      );

      teledart.telegram.sendMessage(
        message.chat.id,
        'УК приветствует Вас! Выберите действие!',
        reply_markup: markup,
      );
    });
  }

  void accountShouldBeNumbersOnlyMessage(
    TeleDart teledart,
    TeleDartMessage message,
    ReplyKeyboardMarkup markup,
  ) {
    teledart.telegram.sendMessage(
      message.chat.id,
      'Лицевой счет должен состоять только из цифр! Введите корректный номер!',
      reply_markup: markup,
    );
  }

  void accountNotExistMessage(
    TeleDart teledart,
    TeleDartMessage message,
    ReplyKeyboardMarkup markup,
  ) {
    teledart.telegram.sendMessage(
      message.chat.id,
      'Такой лицевой счет отсутствует! Введите номер еще раз или вернитесь в начало!',
      reply_markup: markup,
    );
  }

  void requestWasSendMessage(
    TeleDart teledart,
    TeleDartMessage message,
    ReplyKeyboardMarkup markup,
  ) {
    teledart.telegram.sendMessage(
      message.chat.id,
      'Заявка успешно передана!',
      reply_markup: markup,
    );
  }

  void somthingWentWrongMessage(
    TeleDart teledart,
    TeleDartMessage message,
    ReplyKeyboardMarkup markup, [
    StreamSubscription<TeleDartMessage>? subscription,
  ]) {
    teledart.telegram.sendMessage(
      message.chat.id,
      'Что-то пошло не так! Попробуйте еще раз или отправьте заявку другим способом!',
      reply_markup: markup,
    );

    if (subscription != null) {
      subscription.cancel();
    }
  }

  /// Tell user: Добавить фото к заявке?
  void addPhotoToRequestMessage(
    TeleDart teledart,
    TeleDartMessage message,
  ) {
    final yesButton = KeyboardButton(text: 'Да, добавить!');
    final noButton = KeyboardButton(text: 'Нет, не надо!');
    final toStartButton = KeyboardButton(text: 'В начало');

    final buttonList = [yesButton, noButton, toStartButton];
    final markup = ReplyKeyboardMarkup(
      keyboard: [buttonList],
      one_time_keyboard: true,
    );

    teledart.telegram.sendMessage(
      message.chat.id,
      'Добавить фото к заявке?',
      reply_markup: markup,
    );
  }

  void selectActionMessage(
    TeleDart teledart,
    TeleDartMessage message,
    ReplyKeyboardMarkup markup,
  ) {
    teledart.telegram.sendMessage(
      message.chat.id,
      'Выберите действие!',
      reply_markup: markup,
    );
  }

  void requestPhoneNumberMessage(
    TeleDart teledart,
    TeleDartMessage message,
  ) {
    final requestPhoneNumberButton = KeyboardButton(
      text: 'Предоставить номер телефона',
      request_contact: true,
    );
    final toStartButton = KeyboardButton(text: 'В начало');

    final buttonList = [requestPhoneNumberButton, toStartButton];
    final markup = ReplyKeyboardMarkup(
      keyboard: [buttonList],
      one_time_keyboard: true,
    );
    teledart.telegram.sendMessage(
      message.chat.id,
      'Пожалуйста, предоставьте номера телефона',
      reply_markup: markup,
    );
  }

  /// Tell user: Одну минуту, выполняю запрос...
  Future<void> checkUserInputDataMessage(
    TeleDart teledart,
    TeleDartMessage data,
  ) async {
    await teledart.telegram.sendMessage(
      data.chat.id,
      'Одну минуту, выполняю запрос...',
    );
  }

  void requestAccountNumber(
    TeleDart teledart,
    TeleDartMessage message,
  ) {
    teledart.telegram.sendMessage(
      message.chat.id,
      'Введите номер лицевого счета',
    );
  }

  void requestUserRequestMessage(
    TeleDart teledart,
    TeleDartMessage message,
  ) {
    teledart.telegram.sendMessage(
      message.chat.id,
      'Что случилось?',
    );
  }

  /// Tells user that he attached too much photos
  Future<void> maxPhotoAmountMessage(
    TeleDart teledart,
    TeleDartMessage message,
  ) async {
    await teledart.telegram.sendMessage(
      message.chat.id,
      'Превышен лимит! Выберите не более 5 фото!',
    );
  }

  /// Ask user to add photos from library
  Future<void> selectPhotosMessage(
    TeleDart teledart,
    TeleDartMessage message,
  ) async {
    final doneButton = KeyboardButton(text: 'Готово!');
    final toStartButton = KeyboardButton(text: 'В начало');

    final buttonList = [doneButton, toStartButton];
    final markup = ReplyKeyboardMarkup(
      keyboard: [buttonList],
      one_time_keyboard: true,
    );

    await teledart.telegram.sendMessage(
      message.chat.id,
      'Выберите не более 5 фото и отправьте их мне! Нажмите "Готово!" когда закончите!',
      reply_markup: markup,
    );
  }

  /// If user first select that he want to upload photos, abd then accidentally tap on
  /// `Готово!`, the message `Вы не приложили ни одного фото!` will be sent. And also
  /// user will be asked again to upload photos.
  void doneOnNoPhotosMessage(
    TeleDart teledart,
    TeleDartMessage message,
  ) {
    teledart.telegram
        .sendMessage(
          message.chat.id,
          'Вы не приложили ни одного фото!',
        )
        .then((_) => selectPhotosMessage(
              teledart,
              message,
            ));
  }

  /// Download photo to host's folder by `path` to send it later to ParseServer
  Future<void> downloadPhoto(
    String path,
    String telegramApiKey,
    TeleDartMessage message,
    TeleDart teledart,
  ) async {
    final tPhoto = message.photo!.last;
    final tFile = await teledart.telegram.getFile(tPhoto.file_id);
    final tFileLink = tFile.getDownloadLink(telegramApiKey);
    final request = await HttpClient().getUrl(Uri.parse(tFileLink!));
    final response = await request.close();
    await response.pipe(io.File(path).openWrite()) as io.File;
  }

  Future<void> deletePhotosDirectory(String _accountNumber) async {
    final dir = io.Directory('/var/upload/$_accountNumber');
    final dirExist = await dir.exists();
    if (dirExist) {
      await io.Directory('/var/upload/$_accountNumber').delete(recursive: true);
    }
  }
}
