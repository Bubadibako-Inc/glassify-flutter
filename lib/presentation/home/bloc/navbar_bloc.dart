import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'navbar_event.dart';
part 'navbar_state.dart';

class NavbarBloc extends Bloc<NavbarEvent, NavbarState> {
  NavbarBloc() : super(const NavbarState(index: 0)) {
    on<OnPageChanged>((event, emit) async {
      emit(NavbarState(index: event.index));
    });
  }
}
