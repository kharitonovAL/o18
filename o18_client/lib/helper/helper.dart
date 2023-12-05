import 'package:flutter/material.dart';

void showAlert({
  required String title,
  required String content,
  required BuildContext context,
}) =>
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: const Text('ОК'),
          ),
        ],
      ),
    );

void showNewMessageAlert({
  required BuildContext context,
}) =>
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Новое сообщение!'),
        actions: [
          TextButton(
            child: const Text('ОК'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );

const collectionMessages = 'messages';
const collectionAccounts = 'accounts';
const collectionHouses = 'houses';
const collectionCounters = 'counters';
const collectionRequests = 'requests';

const keyEmail = 'email';
const keyAccountNumber = 'accountNumber';
const keyAccountsArray = 'accounts';
const keyHouseNumber = 'houseNumber';
const keyFlatNumber = 'flatNumber';
const keyStreet = 'street';
const keyRequestDate = 'requestDate';
const keyPhoneNumber = 'phoneNumber';
const keyRequest = 'request';
const keyRequestNumber = 'requestNumber';
const keyResponse = 'response';
const keyResponseDate = 'responseDate';
const keyStatus = 'status';
const keyDate = 'date';
const keyTopic = 'topic';
const keyToken = 'token';
const keyOwner = 'owner';
const keyTopicValue = '/topics/';
const keyWasSeen = 'wasSeen';
const keyUserUid = 'userUid';
const keyFirstOpenDate = 'firstOpenDate';
const keyAuthor = 'author';
const keyName = 'name';
const keySurname = 'surname';
const keyCity = 'city';
const keyReadingsDate = 'readingsDate';
const keyReadings = 'readings';
const keyAddress = 'address';

String convertStringToEnglish(
  String str,
) {
  final newString = str.toLowerCase();
  final finalString = newString
      .replaceAll('а', 'a')
      .replaceAll('б', 'b')
      .replaceAll('в', 'v')
      .replaceAll('г', 'g')
      .replaceAll('д', 'd')
      .replaceAll('е', 'e')
      .replaceAll('ё', 'yo')
      .replaceAll('ж', 'zh')
      .replaceAll('з', 'z')
      .replaceAll('и', 'i')
      .replaceAll('й', 'i')
      .replaceAll('к', 'k')
      .replaceAll('л', 'l')
      .replaceAll('м', 'm')
      .replaceAll('н', 'n')
      .replaceAll('о', 'o')
      .replaceAll('п', 'p')
      .replaceAll('р', 'r')
      .replaceAll('с', 's')
      .replaceAll('т', 't')
      .replaceAll('у', 'u')
      .replaceAll('ф', 'f')
      .replaceAll('х', 'h')
      .replaceAll('ц', 'c')
      .replaceAll('ч', 'ch')
      .replaceAll('ш', 'sh')
      .replaceAll('щ', 'sh')
      .replaceAll('ъ', '_')
      .replaceAll('ы', 'i')
      .replaceAll('ь', '_')
      .replaceAll('э', 'e')
      .replaceAll('ю', 'yu')
      .replaceAll('я', 'ya');

  return finalString;
}
