import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/user/entities/cart.dart';
import '../../../domain/user/usecases/get_cart.dart';

import '../../../service_locator.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoadingState()) {
    on<OnGetCartItems>((event, emit) async {
      final response = await sl<GetCartUseCase>().call();

      response.fold((error) {
        emit(CartFailedState(
            message: error ?? 'Terjadi kesalahan silahkan coba lagi nanti'));
      }, (data) {
        emit(CartLoadedState(items: data));
      });
    });
  }
}
