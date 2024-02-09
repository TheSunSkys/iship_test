part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginSubmited extends LoginEvent {}

class ChangePhone extends LoginEvent {
  const ChangePhone({
    required this.phone,
  });

  final String phone;

  @override
  List<Object> get props => [
        phone,
      ];
}

class ChangePassword extends LoginEvent {
  const ChangePassword({
    required this.password,
  });

  final String password;

  @override
  List<Object> get props => [
        password,
      ];
}

class RemoveToken extends LoginEvent {}
class RemoveErrorMessage extends LoginEvent {}
