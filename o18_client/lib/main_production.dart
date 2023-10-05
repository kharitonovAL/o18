// import 'dart:developer';

// import 'package:authentication_repository/authentication_repository.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// // ignore: implementation_imports
// import 'package:model_repository/src/model/models.dart' as models;
// import 'package:o18_client/app/app.dart';
// import 'package:o18_client/app/app_bloc_observer.dart';
// import 'package:o18_client/firebase_options.dart';
// import 'package:o18_client/utils/utils.dart';
// import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
// import 'package:storage_repository/storage_repository.dart';

// Future<void> _firebaseMessagingBackgroundHandler(
//   RemoteMessage message,
// ) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   await Firebase.initializeApp();

//   log(
//     'Handling a background message: ${message.messageId}',
//     name: 'main_production',
//   );
// }

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await dotenv.load();
//   await StorageRepository.getInstance();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

//   await Parse().initialize(
//     dotenv.env[Keys.parseAppId]!,
//     dotenv.env[Keys.parseServerUrl]!,
//     clientKey: dotenv.env[Keys.clientKey]!,
//     coreStore: await CoreStoreSharedPrefsImp.getInstance(),
//     registeredSubClassMap: <String, ParseObjectConstructor>{
//       'UserRequest': models.UserRequest.new,
//       'Operator': models.Operator.new,
//       'House': models.House.new,
//       'Flat': models.Flat.new,
//       'Owner': models.Owner.new,
//       'Account': models.Account.new,
//       'RequestNumber': models.RequestNumber.new,
//       'Partner': models.Partner.new,
//       'PartnerStaff': models.PartnerStaff.new,
//       'MasterStaff': models.MasterStaff.new,
//       'CouncilMember': models.CouncilMember.new,
//       'HouseMessage': models.HouseMessage.new,
//       'Counter': models.Counter.new,
//       'Image': models.ImageFile.new,
//     },
//   );
//   App(
//     authenticationRepository: AuthenticationRepository(),
//   );
// }
