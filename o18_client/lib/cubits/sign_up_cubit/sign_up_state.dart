part of 'sign_up_cubit.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignUpInitial extends SignUpState {
  @override
  String toString() => 'SignupInitial';
}

class SignUpLoading extends SignUpState {
  @override
  String toString() => 'SignupLoading';
}

class SignUpFailure extends SignUpState {
  final String error;

  const SignUpFailure({required this.error});

  @override
  String toString() => 'SignupFailure { error: $error }';
}


class SignUpSuccess extends SignUpState {
  @override
  String toString() => 'SignupSuccess';
}
