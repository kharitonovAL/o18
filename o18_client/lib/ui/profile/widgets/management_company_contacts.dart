// import 'package:flutter/material.dart';

// class ManagementCompanyContacts extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Управляющая компания:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                     SizedBox(height: 8),
//                     Text('ООО УК \"Квартал\"', style: TextStyle(fontSize: 16)),
//                     SizedBox(height: 8),
//                     Text('Адрес:', style: TextStyle(fontSize: 16)),
//                     Text('Ижевск, ул.Пушкинская, д. 192, оф. 31', style: TextStyle(fontSize: 16)),
//                     SizedBox(height: 8),
//                     Text('Адрес электронной почты:', style: TextStyle(fontSize: 16)),
//                     GestureDetector(
//                         child: Text('ukkvartal18@gmail.com', style: TextStyle(fontSize: 16, color: Colors.blue)),
//                         onTap: _composeEmail),
//                     SizedBox(height: 8),
//                     Text('Номер телефона:', style: TextStyle(fontSize: 16)),
//                     GestureDetector(
//                         child: Text('+7 (3412) 52-40-42', style: TextStyle(fontSize: 16, color: Colors.blue)),
//                         onTap: () => _callPhone(phoneNumber: '+73412524042')),
//                     SizedBox(height: 8),
//                     GestureDetector(
//                         child: Text('+7 (3412) 52-56-11', style: TextStyle(fontSize: 16, color: Colors.blue)),
//                         onTap: () => _callPhone(phoneNumber: '+73412525611')),
//                     SizedBox(height: 8),
//                     Text('Номер телефона Аварийной службы:', style: TextStyle(fontSize: 16)),
//                     GestureDetector(
//                         child: Text('+7 (3412) 45-24-76', style: TextStyle(fontSize: 16, color: Colors.blue)),
//                         onTap: () => _callPhone(phoneNumber: '+73412452476')),
//                     SizedBox(height: 8),
//                     GestureDetector(
//                         child: Text('+7 (950) 823-24-76', style: TextStyle(fontSize: 16, color: Colors.blue)),
//                         onTap: () => _callPhone(phoneNumber: '+79508232476')),
//                     SizedBox(height: 8),
//                     Center(
//                       child: ElevatedButton(
//                         child: Text('Другие телефоны'),
//                         onPressed: () => Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => PhoneDictionary(),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Center(
//                       child: ElevatedButton(
//                         child: Text('Сообщить об ошибке в приложении'),
//                         onPressed: _composeReportErrorEmail,
//                       ),
//                     )
//                   ],
//                 )
//   }

//   void _callPhone({required String phoneNumber}) async {
//     final phone = 'tel:$phoneNumber';

//     if (await canLaunch(phone)) {
//       await launch(phone);
//     } else {
//       throw 'Could not Call Phone';
//     }
//   }

//   void _composeEmail() async {
//     final body = '''
// ------------------- Служебная информация ------------------
// ----------------------- НЕ УДАЛЯТЬ!!! ---------------------
// Адрес: $_address кв.$_flatNumber
// Номер л/с: ${_account!.accountNumber}
// Номер телефона: $_phoneNum
// Собственник: ${_owner!.name}

// -----------------------------------------------------------
// Ниже опишите подробно причину обращения.
// -----------------------------------------------------------
//     ''';
//     final email = Mailto(
//       body: body,
//       subject: 'Обращение в УК Квартал',
//       to: ['ukkvartal18@gmail.com'],
//     );

//     await launch('$email');
//   }

//   void _composeReportErrorEmail() async {
//     final body = '''
// ------------------- Системная информация ------------------
// ----------------------- НЕ УДАЛЯТЬ!!! ---------------------

// OwnerID: ${_owner!.objectId}
// FlatID: ${_flat!.objectId}
// AccountID: ${_account!.objectId}
// HouseID: ${_house!.objectId}

// -----------------------------------------------------------
// Ниже опишите подробно ошибку и шаги для её воспроизведения.
// Желательно добавить скриншоты к письму.
// -----------------------------------------------------------
//     ''';
//     final email = Mailto(
//       body: body,
//       subject: 'Ошибка в клиенте УК Квартал',
//       to: ['info@ukkvartalcrm.ru'],
//     );

//     await launch('$email');
//   }
// }
