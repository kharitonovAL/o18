import 'dart:developer';

import 'package:auth_repository/auth_repository.dart';
import 'package:database_repository/database_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_client/cubits/counter_cubit/counter_cubit.dart';
import 'package:o18_client/cubits/message_cubit/message_cubit.dart';
import 'package:o18_client/cubits/profile_cubit/profile_cubit.dart';
import 'package:o18_client/cubits/user_request_cubit/user_request_cubit.dart';
import 'package:o18_client/helper/helper.dart';
import 'package:o18_client/ui/counters/counters_page.dart';
import 'package:o18_client/ui/messages/messages_page.dart';
import 'package:o18_client/ui/profile/profile_page.dart';
import 'package:o18_client/ui/requests/request_page.dart';
import 'package:storage_repository/storage_repository.dart';

class TabBarPage extends StatefulWidget {
  @override
  _TabBarPageState createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage> {
  Tab messageTab = const Tab(icon: Icon(Icons.message), text: 'Сообщения');
  Tab requestTab = const Tab(icon: Icon(Icons.receipt), text: 'Заявки');
  Tab counterTab = const Tab(icon: Icon(Icons.av_timer), text: 'Счетчики');
//  var paymentTab = Tab(icon: Icon(Icons.monetization_on), text: 'Оплата');
  Tab profileTab = const Tab(icon: Icon(Icons.account_box), text: 'Профиль');

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  final AuthRepository _authRepository = AuthRepository();
  final UserRequestRepository _userRequestRepository = UserRequestRepository();
  final OwnerRepository _ownerRepository = OwnerRepository();
  final FlatRepository _flatRepository = FlatRepository();
  final HouseRepository _houseRepository = HouseRepository();
  final AccountRepository _accountRepository = AccountRepository();
  final MessagesRepository _messagesRepository = MessagesRepository();
  final CounterRepository _counterRepository = CounterRepository();

  String savedTopic = '';

  @override
  void initState() {
    messaging.requestPermission().then((settings) {
      log(
        'User granted permission: ${settings.authorizationStatus}',
        name: 'TabBarPage',
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        log(
          'User granted permission',
          name: 'TabBarPage',
        );
      } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
        log(
          'User granted provisional permission',
          name: 'TabBarPage',
        );
      } else {
        log(
          'User declined or has not accepted permission',
          name: 'TabBarPage',
        );
      }
    });

    messaging.getToken().then<void>((token) => StorageRepository.setString(keyToken, token ?? 'token'));
    savedTopic = StorageRepository.getString(keyTopic);

    // store token to owner object in db
    _authRepository.currentUser().then((user) {
      _ownerRepository.getOwnerByEmail(email: user!.emailAddress!).then((owner) {
        final token = StorageRepository.getString(keyToken);

        // check if owner already has token in `deviceTokenList`
        if (owner!.deviceTokenList != null && owner.deviceTokenList!.isNotEmpty) {
          final tokenList = owner.deviceTokenList!.map((dynamic t) => t as String).toList();

          // check if token already stored
          if (tokenList.contains(token)) {
            log(
              'token already exist',
              name: 'TabBarPage',
            );
          } else {
            owner
              ..setAdd(Owner.keyDeviceTokenList, token)
              ..isRegistered = true
              ..update();
          }
        } else {
          owner
            ..setAdd(Owner.keyDeviceTokenList, token)
            ..isRegistered = true
            ..update();
        }
      });
    });

    if (savedTopic == '') {
      _getTopic().then((topic) => FirebaseMessaging.instance.subscribeToTopic(topic));
    }

    FirebaseMessaging.onMessage.listen((message) => showMessage(
          message: message,
        ));
    FirebaseMessaging.onMessageOpenedApp.listen((message) => showMessage(
          message: message,
        ));

    super.initState();
  }

  void showMessage({
    required RemoteMessage message,
  }) {
    log(
      'Got a message whilst in the foreground!',
      name: 'TabBarPage',
    );
    log(
      'Message data: ${message.data}',
      name: 'TabBarPage',
    );

    if (message.notification != null) {
      log(
        'Message also contained a notification: ${message.notification!.body}',
        name: 'TabBarPage',
      );
      showNewMessageAlert(context: context);
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) =>
      DefaultTabController(
        length: 4, // todo return 5 when will add payments and counters
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              // isScrollable: true,
              tabs: [
                messageTab,
                requestTab,
                counterTab,
                profileTab, // todo: return later `paymentTab` when will add payments
              ],
            ),
            title: const Text('Оператор 18'),
          ),
          body: TabBarView(
            children: [
              BlocProvider(
                create: (context) => MessageCubit(
                  ownerRepository: _ownerRepository,
                  authRepository: _authRepository,
                  messagesRepository: _messagesRepository,
                  houseId: savedTopic,
                ),
                child: MessagesPage(),
              ),
              BlocProvider(
                create: (context) => UserRequestCubit(
                  authRepo: _authRepository,
                  userRequestRepository: _userRequestRepository,
                  ownerRepository: _ownerRepository,
                  accountRepository: _accountRepository,
                ),
                child: RequestsPage(),
              ),
              BlocProvider(
                create: (context) => CounterCubit(
                  authRepo: _authRepository,
                  ownerRepository: _ownerRepository,
                  flatRepository: _flatRepository,
                  accountRepository: _accountRepository,
                  counterRepository: _counterRepository,
                ),
                child: CountersPage(),
              ),
//              Center(child: Text('оплатить')), // TODO: return later `paymentTab` when will add payments
              BlocProvider(
                create: (context) => ProfileCubit(
                  authRepo: _authRepository,
                  ownerRepository: _ownerRepository,
                  flatRepository: _flatRepository,
                  houseRepository: _houseRepository,
                  accountRepository: _accountRepository,
                  messagesRepository: _messagesRepository,
                ),
                child: ProfilePage(),
              ),
            ],
          ),
        ),
      );

  Future<String> _getTopic() async {
    final user = await _authRepository.currentUser();
    log(
      'current user: ${user!.username}',
      name: 'TabBarPage',
    );

    final _owner = await _ownerRepository.getOwnerByEmail(email: user.emailAddress!);
    final _account = await _accountRepository.getAccountByOwner(owner: _owner!);
    final _flat = await _flatRepository.getFlatByAccount(accountId: _account.objectId!);
    final _house = await _houseRepository.getHouseByFlat(flat: _flat!);

    savedTopic = _house.objectId!;
    log(
      'savedTopic: $savedTopic',
      name: 'TabBarPage',
    );

    await StorageRepository.setString(keyOwner, _owner.objectId!);
    await StorageRepository.setString(keyTopic, savedTopic);
    return savedTopic;
  }
}
