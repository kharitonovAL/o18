import 'dart:async';
import 'dart:io' as io;

import 'package:bot_app/bot_methods.dart';
import 'package:bot_app/repositories/account_repository.dart';
import 'package:bot_app/repositories/flat_repository.dart';
import 'package:bot_app/repositories/house_repository.dart';
import 'package:bot_app/repositories/image_file_repository.dart';
import 'package:bot_app/repositories/owner_repository.dart';
import 'package:bot_app/repositories/request_number_repository.dart';
import 'package:bot_app/repositories/user_request_repository.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';

import 'key.dart';

Future<void> main() async {
  // Initialize Telegram and TeleDart library
  final telegram = Telegram(telegramApiKey);
  final event = Event((await telegram.getMe()).username!);
  final teledart = TeleDart(telegram, event);
  final bot = BotMethods(teledart: teledart);

  // Initialize ParseServer
  await bot.initParseServer(
    parseAppId: parseAppId,
    masterKey: masterKey,
  );

  // Local variables
  String? _userRequest;
  String? _accountNumber;
  String? _phoneNumber;
  io.File? img_1;
  io.File? img_2;
  io.File? img_3;
  io.File? img_4;
  io.File? img_5;

  // repos
  final userRequestRepo = UserRequestRepository();
  final requestNumberRepo = RequestNumberRepository();
  final ownerRepo = OwnerRepository();
  final accountRepo = AccountRepository();
  final flatRepo = FlatRepository();
  final houseRepo = HouseRepository();
  final imageFileRepo = ImageFileRepository();

  // start
  bot.start();
  bot.onStartCommand(teledart);

  // dialog flow
  teledart.onMessage(keyword: 'Подать заявку').listen((addRequestMessage) {
    final cancelButton = KeyboardButton(text: 'В начало');
    final cancelButtonList = [cancelButton];
    final toStartMarkup = ReplyKeyboardMarkup(
      keyboard: [cancelButtonList],
      one_time_keyboard: true,
    );

    bot.requestAccountNumber(
      teledart,
      addRequestMessage,
    );

    // listen for account number
    final accountNumberSubscription = teledart.onMessage().listen((_) {});

    // get user input
    accountNumberSubscription.onData((accountNumberData) async {
      // check if user select to start action
      if (accountNumberData.text != 'В начало' &&
          accountNumberData.text != 'Подать заявку') {
        // check if user input is numbers only
        if (int.tryParse(accountNumberData.text!) != null) {
          _accountNumber = accountNumberData.text;

          await bot.checkUserInputDataMessage(
            teledart,
            accountNumberData,
          );

          // check if account number exist
          final isAccountExist = await accountRepo.isAccountExist(
            accountNumber: _accountNumber!,
          );

          if (isAccountExist) {
            await accountNumberSubscription.cancel();

            // listen for user reply with request detail
            bot.requestUserRequestMessage(
              teledart,
              accountNumberData,
            );

            final userRequestSubscription = teledart.onMessage().listen((_) {});

            userRequestSubscription.onData((userRequestData) async {
              // check if user select return to start
              if (userRequestData.text != 'В начало' &&
                  userRequestData.text != 'Подать заявку') {
                _userRequest = userRequestData.text;
                await userRequestSubscription.cancel();

                // ask user for photos
                bot.addPhotoToRequestMessage(
                  teledart,
                  userRequestData,
                );

                // listen for user input
                final askForPhotosSubscription =
                    teledart.onMessage().listen((_) {});

                askForPhotosSubscription.onData((askPhotosData) async {
                  if (askPhotosData.text == 'Да, добавить!') {
                    await bot.selectPhotosMessage(teledart, askPhotosData);
                    await askForPhotosSubscription.cancel();

                    final photosSubscription =
                        teledart.onMessage().listen((_) {});

                    var pCounter = 0;
                    photosSubscription.onData((photosData) async {
                      // check if photos exist and it's amount less then or equal 5
                      if (photosData.photo != null) {
                        // set subdirectory for every user session
                        // to store images separately
                        final dir =
                            await io.Directory('/var/upload/$_accountNumber')
                                .create();

                        // Step 1
                        // first we need to change counter's value, because
                        // if changing method will be placed after the `await bot.downloadPhoto()`
                        // method, the async operatoin will block it and it will stay
                        // on the initial value
                        pCounter++;

                        // Step 2
                        // same here: we have to create file's path to store later files
                        // placed by this path
                        if (pCounter == 1) {
                          img_1 = io.File('${dir.path}/img_$pCounter.png');
                        }
                        if (pCounter == 2) {
                          img_2 = io.File('${dir.path}/img_$pCounter.png');
                        }
                        if (pCounter == 3) {
                          img_3 = io.File('${dir.path}/img_$pCounter.png');
                        }
                        if (pCounter == 4) {
                          img_4 = io.File('${dir.path}/img_$pCounter.png');
                        }
                        if (pCounter == 5) {
                          img_5 = io.File('${dir.path}/img_$pCounter.png');
                        }

                        // Step 3
                        // and only after step 1 and 2 we can download image to store
                        // it localy
                        unawaited(bot.downloadPhoto(
                          '${dir.path}/img_$pCounter.png',
                          telegramApiKey,
                          photosData,
                          teledart,
                        ));
                      } else if (photosData.text == 'Готово!') {
                        // check if user send photos, not just tap on Done button without sending photos
                        if (pCounter == 0) {
                          bot.doneOnNoPhotosMessage(teledart, photosData);
                        } else if (pCounter > 5) {
                          await bot.maxPhotoAmountMessage(teledart, photosData);
                          await bot.selectPhotosMessage(teledart, photosData);
                          await bot.deletePhotosDirectory(_accountNumber!);

                          // clear path to images
                          img_1 = null;
                          img_2 = null;
                          img_3 = null;
                          img_4 = null;
                          img_5 = null;

                          // reset counter
                          pCounter = 0;
                        } else {
                          await photosSubscription.cancel();
                          pCounter = 0;

                          // ask user for phone number
                          bot.requestPhoneNumberMessage(
                            teledart,
                            photosData,
                          );

                          // listen for user input with phone number
                          final phoneNumberSubscription =
                              teledart.onMessage().listen((_) {});

                          phoneNumberSubscription
                              .onData((phoneNumberData) async {
                            // check if user provide phone number via markup
                            if (phoneNumberData.contact?.phone_number != null) {
                              // tell user that something is going on
                              await bot.checkUserInputDataMessage(
                                teledart,
                                phoneNumberData,
                              );

                              _phoneNumber =
                                  phoneNumberData.contact?.phone_number;
                              await phoneNumberSubscription.cancel();

                              final requestNumber =
                                  await requestNumberRepo.lastRequestNumber();

                              // send user request
                              final requestWasSend =
                                  await userRequestRepo.sendRequest(
                                accountNumber: _accountNumber!,
                                requestNumber: requestNumber,
                                phoneNumber: int.parse(_phoneNumber!),
                                request: _userRequest!,
                                ownerRepository: ownerRepo,
                                accountRepository: accountRepo,
                                flatRepository: flatRepo,
                                houseRepository: houseRepo,
                                requestNumberRepository: requestNumberRepo,
                                imageFileRepository: imageFileRepo,
                                image1: img_1,
                                image2: img_2,
                                image3: img_3,
                                image4: img_4,
                                image5: img_5,
                              );

                              if (requestWasSend) {
                                bot.requestWasSendMessage(
                                  teledart,
                                  phoneNumberData,
                                  toStartMarkup,
                                );
                              } else {
                                bot.somthingWentWrongMessage(
                                  teledart,
                                  phoneNumberData,
                                  toStartMarkup,
                                );

                                // need to set `_accountNumber` to null or bot will throw an exception
                                // because if user didn't send photos, bot will be looking for folder
                                // with `_accountNumber` name
                                _accountNumber = null;
                              }

                              // need to set variables to null
                              // or old value will be in cache and
                              // if user, for example, will load 3 photos first,
                              // and with othe request will load only 1,
                              // the first images at 2 and 3'd position will
                              // be still remain
                              img_1 = null;
                              img_2 = null;
                              img_3 = null;
                              img_4 = null;
                              img_5 = null;

                              // delete photos directory
                              await bot.deletePhotosDirectory(_accountNumber!);
                            } else if (phoneNumberData.text ==
                                'Подать заявку') {
                              await phoneNumberSubscription.cancel();
                            } else {
                              bot.requestPhoneNumberMessage(
                                teledart,
                                phoneNumberData,
                              );
                              phoneNumberSubscription.resume();
                            }
                          });
                        }
                      } else if (photosData.text == 'В начало') {
                        await photosSubscription.cancel();
                      } else if (photosData.text != 'В начало') {
                        await bot.selectPhotosMessage(
                          teledart,
                          photosData,
                        );
                      }
                    });
                  } else if (askPhotosData.text == 'Нет, не надо!') {
                    // user select without photo action
                    await askForPhotosSubscription.cancel();

                    // ask user for phone number
                    bot.requestPhoneNumberMessage(
                      teledart,
                      askPhotosData,
                    );

                    // listen for user input with phone number
                    final phoneNumberSubscription =
                        teledart.onMessage().listen((_) {});

                    phoneNumberSubscription.onData((phoneNumberData) async {
                      // check if user provide phone number via markup
                      if (phoneNumberData.contact?.phone_number != null) {
                        // tell user that something is going on
                        await bot.checkUserInputDataMessage(
                          teledart,
                          phoneNumberData,
                        );

                        _phoneNumber = phoneNumberData.contact?.phone_number;
                        await phoneNumberSubscription.cancel();

                        final requestNumber =
                            await requestNumberRepo.lastRequestNumber();

                        // send user request
                        final requestWasSend =
                            await userRequestRepo.sendRequest(
                          accountNumber: _accountNumber!,
                          requestNumber: requestNumber,
                          phoneNumber: int.parse(_phoneNumber!),
                          request: _userRequest!,
                          ownerRepository: ownerRepo,
                          accountRepository: accountRepo,
                          flatRepository: flatRepo,
                          houseRepository: houseRepo,
                          requestNumberRepository: requestNumberRepo,
                          imageFileRepository: imageFileRepo,
                        );

                        if (requestWasSend) {
                          bot.requestWasSendMessage(
                            teledart,
                            phoneNumberData,
                            toStartMarkup,
                          );
                        } else {
                          bot.somthingWentWrongMessage(
                            teledart,
                            phoneNumberData,
                            toStartMarkup,
                          );

                          // need to set `_accountNumber` to null or bot will throw an exception
                          // because if user didn't send photos, bot will be looking for folder
                          // with `_accountNumber` name
                          _accountNumber = null;
                        }
                      } else if (phoneNumberData.text == 'Подать заявку' ||
                          phoneNumberData.text == 'В начало') {
                        await phoneNumberSubscription.cancel();
                      } else {
                        bot.requestPhoneNumberMessage(
                          teledart,
                          phoneNumberData,
                        );
                        phoneNumberSubscription.resume();
                      }
                    });
                  } else if (askPhotosData.photo == null &&
                      askPhotosData.text != null &&
                      askPhotosData.text != 'В начало' &&
                      askPhotosData.text != 'Подать заявку') {
                    // ask user for photos
                    bot.addPhotoToRequestMessage(
                      teledart,
                      userRequestData,
                    );
                  } else {
                    await askForPhotosSubscription.cancel();
                  }
                });
              } else {
                await accountNumberSubscription.cancel();
                await userRequestSubscription.cancel();
              }
            });
          } else {
            bot.accountNotExistMessage(
              teledart,
              accountNumberData,
              toStartMarkup,
            );

            accountNumberSubscription.resume();
          }
        } else {
          bot.accountShouldBeNumbersOnlyMessage(
            teledart,
            accountNumberData,
            toStartMarkup,
          );

          accountNumberSubscription.resume();
        }
      } else {
        await accountNumberSubscription.cancel();
      }
    });
  });

  teledart.onMessage(keyword: 'В начало').listen((message) {
    final newRequestButton = KeyboardButton(text: 'Подать заявку');
    // final sendCounterReadingsButton = KeyboardButton(text: 'Подать показания');

    final newRequestButtonList = [newRequestButton];
    // final sendCounterReadingsButtonList = [sendCounterReadingsButton];

    final markup = ReplyKeyboardMarkup(
      keyboard: [newRequestButtonList], // sendCounterReadingsButtonList],
      one_time_keyboard: true,
    );

    bot.selectActionMessage(
      teledart,
      message,
      markup,
    );

    if (_accountNumber != null) {
      bot.deletePhotosDirectory(_accountNumber!);
    }
  });
}
