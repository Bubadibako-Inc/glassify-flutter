import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'carousel_event.dart';
part 'carousel_state.dart';

class CarouselBloc extends Bloc<CarouselEvent, CarouselState> {
  CarouselBloc() : super(const CarouselState(index: 0)) {
    on<OnPageChanged>((event, emit) async {
      emit(CarouselState(index: event.index));
    });
  }
}
