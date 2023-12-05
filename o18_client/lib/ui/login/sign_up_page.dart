import 'dart:developer';

import 'package:database_repository/database_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_client/cubits/auth_cubit/auth_cubit.dart';
import 'package:o18_client/cubits/sign_up_cubit/sign_up_cubit.dart';
import 'package:o18_client/helper/helper.dart';
import 'package:o18_client/screen_router.dart';
import 'package:o18_client/theme/style/app_colors.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:storage_repository/storage_repository.dart';
import 'package:validators/validators.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({
    required this.switchToSignInPageCallback,
  });

  final VoidCallback switchToSignInPageCallback;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _ownerRepository = OwnerRepository();
  final _flatRepository = FlatRepository();
  final _houseRepository = HouseRepository();
  final _accountRepository = AccountRepository();

  bool _signUpIsLoading = false;
  bool _yesIsLoading = false;

  bool _isUserCreated = false;

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }

    return false;
  }

  String _email = '';
  String _password = '';
  String _accountNumber = '';
  ParseUser? user;
  List<Owner>? ownerList;
  Flat? _flat;
  Account? _account;
  House? _house;

  final _nameTEC = TextEditingController();
  final _phoneNumberTEC = TextEditingController();
  bool _nameValidator = false;
  bool _phoneValidator = false;

  SignUpCubit? _signUpCubit;

  void resetForm() {
    _formKey.currentState!.reset();
  }

  @override
  void initState() {
    _signUpCubit = context.read<SignUpCubit>();
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) =>
      MultiBlocListener(
        listeners: [
          BlocListener<SignUpCubit, SignUpState>(
            listener: (context, state) {
              if (state is SignUpSuccess) {
                context.read<AuthCubit>().appStarted();
              }
            },
          ),
          BlocListener<AuthCubit, AuthenticationState>(
            listener: (context, state) {
              if (state is AuthenticationAuthenticated) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  ScreenRouter.ROOT,
                  (route) => false,
                );
              }
            },
          ),
        ],
        child: Scaffold(
          appBar: AppBar(title: const Center(child: Text('Регистрация'))),
          body: _showSignUpForm(),
        ),
      );

  Widget _showEmailInput() => Padding(
        padding: EdgeInsets.zero,
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            hintText: 'Email',
            icon: Icon(
              Icons.email,
              color: Colors.grey,
            ),
          ),
          validator: (value) => value!.isEmpty ? 'Введите адрес электронной почты' : null,
          onSaved: (value) => _email = value!.trim().toLowerCase(),
        ),
      );

  Widget _showPasswordInput() => Padding(
        padding: EdgeInsets.zero,
        child: TextFormField(
          obscureText: true,
          decoration: const InputDecoration(
            hintText: 'Пароль',
            icon: Icon(
              Icons.lock,
              color: Colors.grey,
            ),
          ),
          validator: (value) => value!.isEmpty ? 'Введите пароль ' : null,
          onSaved: (value) => _password = value!.trim(),
        ),
      );

  Widget _showAccountInput() => Padding(
        padding: EdgeInsets.zero,
        child: TextFormField(
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            hintText: 'Номер лицевого счета',
            icon: Icon(
              Icons.account_box,
              color: Colors.grey,
            ),
          ),
          validator: (value) => value!.isEmpty ? 'Введите номер лицевого счета' : null,
          onSaved: (value) => _accountNumber = value!.trim(),
        ),
      );

  Widget _showSignUpButton() => _signUpIsLoading
      ? Padding(
          padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
          child: SizedBox(
            height: 40,
            child: ElevatedButton(
              onPressed: validateAndSubmit,
              child: const Text(
                'Зарегистрироваться',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        )
      : const CircularProgressIndicator(
          color: AppColors.green_0,
        );

  Widget _showToSignInButton() => TextButton(
        onPressed: widget.switchToSignInPageCallback,
        child: const Text(
          'Уже есть аккаунт?',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
          textAlign: TextAlign.center,
        ),
      );

  Widget _showSignUpForm() => Container(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (!_isUserCreated) _showEmailInput(),
                if (!_isUserCreated) _showPasswordInput(),
                if (!_isUserCreated) _showAccountInput(),
                if (!_isUserCreated) _showSignUpButton(),
                if (!_isUserCreated) _showToSignInButton(),
              ],
            ),
          ),
        ),
      );

  Future<void> validateAndSubmit() async {
    if (validateAndSave()) {
      setState(() => _signUpIsLoading = true);

      if (!isEmail(_email)) {
        showAlert(
          title: 'Внимание!',
          content: 'Введите действительный адрес электронной почты и повторите попытку!',
          context: context,
        );
        setState(() => _signUpIsLoading = false);
        return;
      }

      if (!isNumeric(_accountNumber)) {
        showAlert(
          title: 'Внимание!',
          content: 'Номер лицевого счета должен состоять только из цифр!',
          context: context,
        );
        setState(() => _signUpIsLoading = false);
        return;
      }

      try {
        // create new user on server
        user = await _signUpCubit!.authRepository.signUp(
          email: _email,
          password: _password,
        );

        log(
          'signed up user: $user',
          name: 'SignUpPage',
        );

        // get list of Owners
        ownerList = await _ownerRepository.getOwnerListByAccountNumber(
          accountNumber: _accountNumber,
          accountRepository: _accountRepository,
        );

        if (ownerList != null) {
          Owner? _owner;
          var _isOwnerDefined = false;

          // check if there more than one owner for account
          if (ownerList!.length == 1) {
            log(
              'there is only one owner',
              name: 'SignUpPage',
            );

            log(
              'owner is registered ${ownerList!.first.isRegistered}',
              name: 'SignUpPage',
            );

            // check if the only user is already registered or `isRegistered` equals to `null`
            if (ownerList!.first.isRegistered == null || !ownerList!.first.isRegistered!) {
              log(
                'the only user is NOT registered',
                name: 'SignUpPage',
              );

              _owner = ownerList!.first;
              _owner.isRegistered = true;
              await _owner.update();
              _isOwnerDefined = true;

              user!.set('ownerId', _owner.objectId);
              await user!.update();
            }
          }

          // if user defined - check his address
          if (_isOwnerDefined) {
            _account = await _accountRepository.getAccountByOwner(owner: _owner!);
            _flat = await _flatRepository.getFlatByAccount(accountId: _account!.objectId!);
            _house = await _houseRepository.getHouseByFlat(flat: _flat!);

            await showDialog<void>(
              context: context,
              builder: (context) => StatefulBuilder(
                builder: (context, setState) => AlertDialog(
                  title: const Text('Это ваш адрес?'),
                  content: Text(
                    'ул.${_house!.street}, д.${_house!.houseNumber}, кв.${_flat!.flatNumber}',
                  ),
                  actions: [
                    TextButton(
                      child: const Text('Нет'),
                      onPressed: () {
                        setState(() {
                          _yesIsLoading = false;
                          _isUserCreated = false;
                        });
                        Navigator.of(context).pop();
                        user!.destroy();
                        showWarningAlert(context);
                      },
                    ),
                    TextButton(
                      child: _yesIsLoading ? const CircularProgressIndicator() : const Text('Да'),
                      onPressed: () async {
                        setState(() => _yesIsLoading = true);
                        // dismiss keyboard when primaryButton tapped
                        FocusScope.of(context).requestFocus(FocusNode());
                        _owner!.email = _email;

                        final result = await _owner.update();
                        setState(() => _yesIsLoading = false);
                        _isUserCreated = result.success;
                        log(
                          'new user ${_isUserCreated ? 'created' : 'NOT created'}',
                          name: 'SignUpPage',
                        );

                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: const Duration(seconds: 3),
                            content: Text(
                              'Учетная запись ${_isUserCreated ? '' : 'не'} зарегистрирована!',
                            ),
                          ),
                        );
                        widget.switchToSignInPageCallback();
                      },
                    ),
                  ],
                ),
              ),
            );
          } else {
            // if it is new user, that not exist in Owner list, create it
            await showDialog<void>(
              context: context,
              builder: (context) => StatefulBuilder(
                builder: (context, setState) => AlertDialog(
                  title: const Text('Введите Ваши ФИО'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        keyboardType: TextInputType.text,
                        controller: _nameTEC,
                        decoration: InputDecoration(
                          labelText: 'Введите ФИО',
                          errorText: _nameValidator ? 'Введите ФИО' : null,
                        ),
                      ),
                      TextField(
                        maxLength: 11,
                        keyboardType: TextInputType.number,
                        controller: _phoneNumberTEC,
                        decoration: InputDecoration(
                          labelText: 'Введите номер телефона',
                          errorText: _phoneValidator ? 'Введите номер телефона' : null,
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                        child: const Text('Отмена'),
                        onPressed: () {
                          user!.destroy();
                          Navigator.of(context).pop();
                        }),
                    TextButton(
                      child: _yesIsLoading ? const CircularProgressIndicator() : const Text('Сохранить'),
                      onPressed: () async {
                        setState(() => _yesIsLoading = true);

                        _account = await _accountRepository.getAccountByAccountNumber(
                          accountNumber: _accountNumber,
                        );
                        _flat = await _flatRepository.getFlatByAccount(
                          accountId: _account!.objectId!,
                        );
                        _house = await _houseRepository.getHouseByFlat(
                          flat: _flat!,
                        );

                        setState(() {
                          if (_nameTEC.text.isEmpty) {
                            _nameValidator = true;
                          } else {
                            _nameValidator = false;
                          }

                          if (_phoneNumberTEC.text.isEmpty) {
                            _phoneValidator = true;
                          } else {
                            _phoneValidator = false;
                          }
                        });

                        if (!_nameValidator || !_phoneValidator) {
                          // create new owner
                          final _newOwner = Owner()
                            ..name = _nameTEC.text
                            ..phoneNumber = int.parse(_phoneNumberTEC.text.trim())
                            ..email = _email
                            ..isRegistered = true
                            ..squareMeters = _flat!.flatSquare!
                            ..accountId = _account!.objectId;

                          _newOwner.setAdd(
                            Owner.keyDeviceTokenList,
                            StorageRepository.getString(keyToken),
                          );
                          _newOwner.setAdd(
                            Owner.keyPhoneNumberList,
                            int.parse(_phoneNumberTEC.text.trim()),
                          );

                          final nOwner = await _newOwner.create();
                          final results = nOwner.results!.map((dynamic e) => e as Owner).toList();
                          final createdOwner = results.first;

                          // update account's ownerIdList
                          _account!.setAdd(
                            Account.keyOwnerIdList,
                            createdOwner.objectId,
                          );
                          await _account!.update();

                          // update user's property

                          user!.set(
                            'ownerId',
                            createdOwner.objectId,
                          );
                          await user!.update();

                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: const Duration(seconds: 3),
                              content: Text(
                                'Учетная запись ${nOwner.success ? '' : 'не'} создана!',
                              ),
                            ),
                          );
                          widget.switchToSignInPageCallback();
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          }

          _setStartDate();
        } else {
          await user!.destroy();
          showAlert(
            title: 'Внимание!',
            content: 'Неверный номера лицевого счета!'
                ' Проверьте правильность вводимых даннх или свяжитесь с управляющей компанией!',
            context: context,
          );
          await user!.destroy().then(
                (response) => log(
                  'user ${response!.success ? 'was' : 'was NOT'} destroyed',
                  name: 'SignUpPage',
                ),
              );
        }

        setState(() => _signUpIsLoading = false);
      } catch (e) {
        log(
          'Error: $e',
          name: 'SignUpPage',
        );
        setState(() {
          _signUpIsLoading = false;
          _formKey.currentState!.reset();
        });
      }
    }

    // dismiss keyboard when primaryButton tapped
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void showWarningAlert(
    BuildContext context,
  ) =>
      showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Внимание!'),
          content: const Text(
            'Пожалуйста, свяжитесь с Управляющей компанией и передайте ей верные данные Вашего адреса!'
            'Иначе в приложении будут указаны неверные данные!',
          ),
          actions: [
            TextButton(
              onPressed: () {
                user!.destroy();
                Navigator.of(context).pop();
                widget.switchToSignInPageCallback();
              },
              child: const Text('OK'),
            )
          ],
        ),
      );

  void _setStartDate() async => StorageRepository.setString(
        keyFirstOpenDate,
        DateTime.now().toLocal().toString(),
      );
}
