part of 'home_bloc.dart';

enum Status { initial, loading, success, failure }

class HomeState extends Equatable {
  const HomeState({
    this.status = Status.initial,
    this.errorCode = '',
    List<OrderModel>? orders,
  }) : orders = orders ?? const <OrderModel>[];

  final Status status;
  final String errorCode;
  final List<OrderModel> orders;

  HomeState copyWith({
    Status? status,
    String? errorCode,
    List<OrderModel>? orders,
  }) {
    return HomeState(
      status: status ?? this.status,
      errorCode: errorCode ?? this.errorCode,
      orders: orders ?? this.orders,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorCode,
        orders,
      ];
}
