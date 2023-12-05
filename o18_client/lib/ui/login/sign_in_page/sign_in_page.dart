import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:o18_client/cubits/auth_cubit/auth_cubit.dart';
import 'package:o18_client/cubits/login_cubit/login_cubit.dart';
import 'package:o18_client/helper/helper.dart';
import 'package:o18_client/theme/theme.dart';
import 'package:o18_client/ui/login/sign_in_page/widgets/show_logo.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:storage_repository/storage_repository.dart';
import 'package:validators/validators.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({
    required this.switchToSignUpPageCallback,
  });
  final VoidCallback switchToSignUpPageCallback;

  @override
  State<StatefulWidget> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  LoginCubit? _loginCubit;

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
  String _errorMessage = '';
  ParseUser? user;

  void resetForm() {
    _formKey.currentState!.reset();
    _errorMessage = '';
  }

  @override
  void initState() {
    _loginCubit = context.read<LoginCubit>();
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) =>
      BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          } else if (state is LoginSuccess) {
            context.read<AuthCubit>().appStarted();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Center(
              child: Text('Вход'),
            ),
          ),
          body: _showForm(),
        ),
      );

  Widget showEmailInput() => Padding(
        padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            hintText: 'Email',
            icon: Icon(Icons.email, color: Colors.grey),
          ),
          validator: (value) => value!.isEmpty ? 'Адрес электронной почты не может быть пустым' : null,
          onSaved: (value) => _email = value!.trim().toLowerCase(),
        ),
      );

  Widget showPasswordInput() => Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
        child: TextFormField(
          obscureText: true,
          decoration: const InputDecoration(
            hintText: 'Пароль',
            icon: Icon(Icons.lock, color: Colors.grey),
          ),
          validator: (value) => value!.isEmpty ? 'Пароль не может быть пустым' : null,
          onSaved: (value) => _password = value!.trim(),
        ),
      );

  Widget showLoginButton() => Padding(
        padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
        child: SizedBox(
          height: 40,
          child: BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) => ElevatedButton(
              onPressed: () async {
                // setState(() => _errorMessage = '');

                if (validateAndSave()) {
                  // setState(() => _isLoading = true);

                  if (!isEmail(_email)) {
                    showAlert(
                      title: 'Внимание!',
                      content: 'Введите действительный адрес электронной почты и повторите попытку!',
                      context: context,
                    );
                    // setState(() => _isLoading = false);
                    return;
                  }

                  if (_loginCubit != null) {
                    await _loginCubit!.loginButtonPressed(
                      email: _email.toLowerCase(),
                      password: _password,
                    );
                  }

                  await _setStartDate();
                  // setState(() => _isLoading = false);
                }

                // dismiss keyboard when primaryButton tapped
                FocusScope.of(context).requestFocus(FocusNode());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.green_0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: state is LoginLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                      'Войти',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
            ),
          ),
        ),
      );

  Widget showSignUpButton() => TextButton(
        child: const Text(
          'Зареристрироваться',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
          textAlign: TextAlign.center,
        ),
        onPressed: () {
          widget.switchToSignUpPageCallback();
          resetForm();
        },
      );

  Widget showErrorMessage() => _errorMessage.isNotEmpty
      ? Text(
          _errorMessage,
          style: const TextStyle(fontSize: 13, color: Colors.red, height: 1, fontWeight: FontWeight.w300),
        )
      : Container(height: 0);

  Widget _showForm() => BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          } else if (state is LoginSuccess) {
            context.read<AuthCubit>().appStarted();
          }
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ShowLogo(),
                  showEmailInput(),
                  showPasswordInput(),
                  showLoginButton(),
                  const Divider(color: Colors.transparent),
                  showSignUpButton(),
                  showErrorMessage(),
                ],
              ),
            ),
          ),
        ),
      );

  Future<void> _setStartDate() async => StorageRepository.setString(
        keyFirstOpenDate,
        DateTime.now().toLocal().toString(),
      );
}
