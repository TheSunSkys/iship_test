import 'package:application_a/repository/repository.dart';
import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends HydratedBloc<LoginEvent, LoginState> {
  LoginBloc({
    required Repository repository,
  })  : _repository = repository,
        super(
          const LoginState(),
        ) {
    on<LoginSubmited>(_onLoginSubmited);
    on<ChangePhone>(_onChangePhone);
    on<ChangePassword>(_onChangePassword);
    on<RemoveToken>(_onRemoveToken);
    on<RemoveErrorMessage>(_onRemoveErrorMessage);
  }

  final Repository _repository;

  Future<void> _onRemoveToken(
    RemoveToken event,
    Emitter<LoginState> emit,
  ) async {
    _repository.removeTokenHeader();
    emit(
      state.copyWith(
        token: '',
      ),
    );
  }

  Future<void> _onRemoveErrorMessage(
    RemoveErrorMessage event,
    Emitter<LoginState> emit,
  ) async {
    emit(
      state.copyWith(
        errorMessage: '',
      ),
    );
  }

  Future<void> _onLoginSubmited(
    LoginSubmited event,
    Emitter<LoginState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          errorMessage: '',
        ),
      );

      final response = await _repository.auth().loginSubmit(
            phone: state.phone,
            password: state.password,
            // phone: '0927043617',
            // password: '11111111',
          );
      _repository.setTokenHeader(response.token);

      emit(
        state.copyWith(
          token: response.token,
          errorMessage: '',
        ),
      );
    } catch (err) {
      emit(
        state.copyWith(
          errorMessage: err.toString(),
        ),
      );
      print('error $err');
    }
  }

  Future<void> _onChangePhone(
    ChangePhone event,
    Emitter<LoginState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          phone: event.phone.toString(),
        ),
      );
    } catch (err) {
      print('error $err');
    }
  }

  Future<void> _onChangePassword(
    ChangePassword event,
    Emitter<LoginState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          password: event.password.toString(),
        ),
      );
    } catch (err) {
      print('error $err');
    }
  }

  @override
  LoginState? fromJson(Map<String, dynamic> json) {
    final token = json['token'] as String;
    // final password = json['password'] as String;
    // final phone = json['phone'] as String;

    if (token != '') {
      _repository.setTokenHeader(token);
    }

    return LoginState(
      token: token,
      // password: password,
      // phone: phone,
    );
  }

  @override
  Map<String, dynamic>? toJson(LoginState state) {
    return {
      'token': state.token,
      // 'phone': state.phone,
      // 'password': state.password,
    };
  }
}
