import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mailto/mailto.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_client/cubits/profile_cubit/profile_cubit.dart';
import 'package:o18_client/helper/helper.dart';
import 'package:o18_client/screen_router.dart';
import 'package:o18_client/ui/profile/phone_dictionary.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:storage_repository/storage_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  // TextEditingController _nameTEC = TextEditingController();
  // TextEditingController _phoneTEC = TextEditingController();

  // bool _nameValidator = false;
  // bool _phoneValidator = false;
  final bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  ProfileCubit? _profileCubit;

  UserProfile? userProfile;
  String? _name;
  String? _email;
  String? _phoneNum;
  String? _address;
  String? _flatNumber;
  ParseUser? _parseUser;
  Owner? _owner;
  Account? _account;
  Flat? _flat;
  House? _house;

  @override
  void initState() {
    _profileCubit = context.read<ProfileCubit>();
    super.initState();
  }

  @override
  void dispose() {
    _profileCubit!.close();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) =>
      Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (context, state) {
                      if (state is ProfileLoading) {
                        return const Center(
                          child: Column(
                            children: [
                              CircularProgressIndicator(),
                              Text('Загружаю данные профиля'),
                            ],
                          ),
                        );
                      } else if (state is ProfileLoadFailure) {
                        return const Center(
                          child: Text('Ошибка загрузки профиля'),
                        );
                      } else if (state is ProfileLoaded) {
                        userProfile = state.userProfile;
                        _parseUser = state.parseUser;
                        _name = state.userProfile.name;
                        _phoneNum = state.userProfile.phoneNumber;
                        _owner = state.owner;
                        _account = state.account;
                        _flat = state.flat;
                        _house = state.house;
                        _address = state.userProfile.address;
                        _flatNumber = state.userProfile.flatNumber;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Данные профиля:',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'ФИО собственника:',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              state.userProfile.name,
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Адресс предоставления услуг:',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              state.userProfile.address,
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Адрес электронной почты:',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              state.userProfile.email,
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Номер телефона:',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              state.userProfile.phoneNumber,
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Лицевые счета:',
                              style: TextStyle(fontSize: 16),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: state.accountList
                                  .map(
                                    (e) => ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      title: Text('${e.accountNumber}'),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Назначение: ${e.purpose}'),
                                          Text(
                                            'Баланс: ${e.debt} руб.',
                                            style: TextStyle(
                                              color: '${e.debt}'.contains('-') ? Colors.red : Colors.grey,
                                              fontWeight:
                                                  '${e.debt}'.contains('-') ? FontWeight.bold : FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                        );
                      }

                      return const Center(
                        child: Column(
                          children: [
                            CircularProgressIndicator(),
                            Text('Загружаю данные профиля'),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextButton(
                  child: const Text('Редактировать данные профиля', style: TextStyle(fontSize: 16)),
                  onPressed: () {
                    showDialog<void>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text(
                          'Данные профиля',
                          style: TextStyle(fontSize: 16),
                        ),
                        content: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                keyboardType: TextInputType.text,
                                initialValue: _name,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Введите ФИО';
                                  }

                                  return null;
                                },
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    _name = value;
                                  }
                                },
                              ),
                              TextFormField(
                                // key: Key('phone_field'),
                                maxLength: 11,
                                keyboardType: TextInputType.number,
                                initialValue: _phoneNum,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Введите номер телефона';
                                  }

                                  return null;
                                },
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    _phoneNum = value;
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: Navigator.of(context).pop,
                            child: const Text('Отмена'),
                          ),
                          TextButton(
                            child: const Text('Сохранить'),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                _owner!
                                  ..name = _name
                                  ..phoneNumber = int.parse(_phoneNum!);
                                await _owner!.update().then(
                                  (value) {
                                    _profileCubit!.profileData();

                                    Navigator.of(context).pop();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        duration: const Duration(seconds: 1),
                                        content: Text(
                                          'Данные ${value.success ? '' : 'не'} обновлены!',
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Управляющая компания:',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Оператор 18',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Адрес:',
                        style: TextStyle(fontSize: 16),
                      ),
                      const Text(
                        'Ижевск, ул.Пушкинская, д. 192, оф. 31',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Адрес электронной почты:',
                        style: TextStyle(fontSize: 16),
                      ),
                      GestureDetector(
                        onTap: _composeEmail,
                        child: const Text(
                          'hello@operator18.ru',
                          style: TextStyle(fontSize: 16, color: Colors.blue),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Номер телефона:',
                        style: TextStyle(fontSize: 16),
                      ),
                      GestureDetector(
                        child: const Text(
                          '+7 (3412) 00-00-00',
                          style: TextStyle(fontSize: 16, color: Colors.blue),
                        ),
                        onTap: () => _callPhone(phoneNumber: '+73412000000'),
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        child: const Text(
                          '+7 (3412) 00-00-00',
                          style: TextStyle(fontSize: 16, color: Colors.blue),
                        ),
                        onTap: () => _callPhone(phoneNumber: '+73412000000'),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Номер телефона Аварийной службы:',
                        style: TextStyle(fontSize: 16),
                      ),
                      GestureDetector(
                        child: const Text(
                          '+7 (3412) 00-00-00',
                          style: TextStyle(fontSize: 16, color: Colors.blue),
                        ),
                        onTap: () => _callPhone(phoneNumber: '+734120000000'),
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        child: const Text(
                          '+7 (950) 666-66-66',
                          style: TextStyle(fontSize: 16, color: Colors.blue),
                        ),
                        onTap: () => _callPhone(phoneNumber: '+9999999999'),
                      ),
                      const SizedBox(height: 8),
                      Center(
                        child: ElevatedButton(
                          child: const Text('Другие телефоны'),
                          onPressed: () => Navigator.push<void>(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PhoneDictionary(),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: _composeReportErrorEmail,
                          child: const Text('Сообщить об ошибке в приложении'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              logoutButton(),
              deleteUserButton()
            ],
          ),
        ),
      );

  void _callPhone({
    required String phoneNumber,
  }) async {
    final phone = 'tel:$phoneNumber';

    if (await canLaunchUrl(Uri.parse(phone))) {
      await launchUrl(Uri.parse(phone));
    } else {
      throw 'Could not Call Phone';
    }
  }

  void _composeEmail() async {
    final body = '''
------------------- Служебная информация ------------------
----------------------- НЕ УДАЛЯТЬ!!! ---------------------
Адрес: $_address кв.$_flatNumber
Номер л/с: ${_account!.accountNumber}
Номер телефона: $_phoneNum
Собственник: ${_owner!.name}

-----------------------------------------------------------
Ниже опишите подробно причину обращения.
-----------------------------------------------------------
    ''';
    final email = Mailto(
      body: body,
      subject: 'Обращение в УК',
      to: ['hello@operator18.ru'],
    );

    await launchUrl(Uri.parse('$email'));
  }

  void _composeReportErrorEmail() async {
    final body = '''
------------------- Системная информация ------------------
----------------------- НЕ УДАЛЯТЬ!!! ---------------------

OwnerID: ${_owner!.objectId}
FlatID: ${_flat!.objectId}
AccountID: ${_account!.objectId}
HouseID: ${_house!.objectId}

-----------------------------------------------------------
Ниже опишите подробно ошибку и шаги для её воспроизведения.
Желательно добавить скриншоты к письму.
-----------------------------------------------------------
    ''';
    final email = Mailto(
      body: body,
      subject: 'Ошибка в клиенте УК',
      to: ['hello@operator18.ru'],
    );

    await launchUrl(Uri.parse('$email'));
  }

  Widget logoutButton() => TextButton(
        child: _isLoading
            ? const CircularProgressIndicator()
            : const Text('Выйти из профиля', style: TextStyle(fontSize: 16)),
        onPressed: () async {
          final isLoggedOut = await _profileCubit!.logOut(
            StorageRepository.getString(keyTopic),
            StorageRepository.getString(keyToken),
            messaging,
          );

          if (isLoggedOut != null && isLoggedOut) {
            await Navigator.pushNamedAndRemoveUntil(context, ScreenRouter.ROOT, (route) => false);
          }
        },
      );

  Widget deleteUserButton() => TextButton(
        child: const Text(
          'Удалить учетную запись',
          style: TextStyle(fontSize: 16),
        ),
        onPressed: () {
          showDialog<void>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Внимание!'),
              content: const Text(
                'Вы уверены что хотите удалить учетную запись? '
                'Данное действие необратимо, для входа в приложение'
                ' потребуется заново зарегистрировать учетную запись!',
              ),
              actions: [
                TextButton(
                  onPressed: Navigator.of(context).pop,
                  child: const Text('Отмена'),
                ),
                TextButton(
                  child: const Text('Удалить'),
                  onPressed: () async {
                    final isDeleted = await _profileCubit!.deleteUser(
                      StorageRepository.getString(keyTopic),
                      StorageRepository.getString(keyToken),
                      messaging,
                    );
                    if (isDeleted != null && isDeleted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: const Duration(seconds: 3),
                          content: Text(
                            'Учетная запись ${isDeleted ? '' : 'не'} удалена!',
                          ),
                        ),
                      );

                      await Navigator.pushNamedAndRemoveUntil(
                        context,
                        ScreenRouter.ROOT,
                        (route) => false,
                      );
                    }
                  },
                )
              ],
            ),
          );
        },
      );
}
