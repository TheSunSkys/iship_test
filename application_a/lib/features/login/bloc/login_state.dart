part of 'login_bloc.dart';


class LoginState extends Equatable {
  const LoginState({
    this.token = '',
    this.phone = '',
    this.password = '',
    this.errorMessage = '',
  });

  final String token, password, phone, errorMessage;

  LoginState copyWith({
    String? token,
    String? phone,
    String? password,
    String? errorMessage,
  }) {
    return LoginState(
      token: token ?? this.token,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        token,
        phone,
        password,
        errorMessage,
      ];
}
