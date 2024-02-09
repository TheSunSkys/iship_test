import 'package:application_a/repository/auth_repository.dart';
import 'package:application_a/repository/order_repository.dart';
import 'package:http/http.dart' as http;

class Repository {
  // Session? _session;
  final http.Client? _client;

  late final AuthRepository _authRepository;
  late final OrderRepository _orderRepository;

  Repository({
    String? uri,
    http.Client? client,
  }) : _client = client {
    _authRepository = AuthRepository(
      repository: this,
      uri: 'https://app-uat.iship.cloud/api/auth',
      client: _client,
    );

    _orderRepository = OrderRepository(
      repository: this,
      uri: 'https://app-uat.iship.cloud/api',
      client: _client,
    );
  }

  void setTokenHeader(
    String token,
  ) {
    _authRepository.setTokenHeader(token);
    _orderRepository.setTokenHeader(token);
  }

  void removeTokenHeader() {
    _authRepository.setTokenHeader('');
    _orderRepository.setTokenHeader('');
  }

  AuthRepository auth() {
    return _authRepository;
  }

  OrderRepository order() {
    return _orderRepository;
  }
}
