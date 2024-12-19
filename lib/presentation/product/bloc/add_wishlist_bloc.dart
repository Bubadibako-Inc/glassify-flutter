import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/user/models/wishlist_req_params.dart';
import '../../../domain/user/usecases/add_wishlist.dart';
import '../../../service_locator.dart';

part 'add_wishlist_event.dart';
part 'add_wishlist_state.dart';

class AddWishlistBloc extends Bloc<AddWishlistEvent, AddWishlistState> {
  AddWishlistBloc() : super(AddWishlistInitialState()) {
    on<OnAddWishlistPressed>((event, emit) async {
      emit(AddWishlistInitialState());

      final response =
          await sl<AddWishlistUseCase>().call(params: event.params);

      response.fold((error) {
        emit(AddWishlistFailedState(
            message: error ?? 'Terjadi kesalahan, coba lagi nanti'));
      }, (data) async {
        emit(AddWishlistSuccessState());
      });
    });
  }
}
