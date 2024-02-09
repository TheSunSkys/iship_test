import 'package:application_a/repository/repository.dart';
import 'package:application_a/until/model/mode.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required Repository repository,
  })  : _repository = repository,
        super(
          const HomeState(),
        ) {
    on<GetOrders>(_onGetOrders);
  }

  final Repository _repository;

  Future<void> _onGetOrders(
    GetOrders event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          status: Status.loading,
        ),
      );

      final response = await _repository.order().getOrders();

      emit(
        state.copyWith(
          status: Status.success,
          orders: response,
        ),
      );
    } catch (err) {
      if (err == 401) {
        emit(
          state.copyWith(
            status: Status.failure,
            errorCode: '401',
          ),
        );
      }

      emit(
        state.copyWith(
          status: Status.failure,
        ),
      );
    }
  }
}
