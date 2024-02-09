import 'package:equatable/equatable.dart';

class AuthModel extends Equatable {
  const AuthModel({required this.token});

  final String token;

  @override
  List<Object?> get props => [token];

  static const empty = AuthModel(
    token: '',
  );

  factory AuthModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return empty;

    return AuthModel(
      token: json['api_token'] ?? empty.token,
    );
  }

  Map<String, dynamic> toJson() {
    if (this == empty) return {};
    return {
      'token': token,
    };
  }
}
