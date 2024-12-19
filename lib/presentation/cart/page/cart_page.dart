import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/configs/assets/app_icons.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../../core/configs/routes/app_routes.dart';
import '../../../common/bloc/auth_bloc.dart';
import '../../../common/widgets/horizontal_spacer.dart';

import '../../unauthenticated/page/unauthenticated_page.dart';

import '../bloc/cart_bloc.dart';
import '../widgets/cart_appbar.dart';
import '../widgets/empty_cart.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => CartBloc(),
        ),
      ],
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(96),
          child: CartAppbar(),
        ),
        body: BlocBuilder<AuthBloc, AuthState>(
          bloc: AuthBloc()..add(GetToken()),
          builder: (context, state) {
            if (state is AuthenticatedState) {
              return BlocBuilder(
                bloc: CartBloc()..add(OnGetCartItems()),
                builder: (context, state) {
                  if (state is CartLoadedState) {
                    if (state.items.isNotEmpty) {
                      ListView.builder(
                        itemCount: state.items.length,
                        itemBuilder: (_, index) {
                          return Text(state.items[index].productId!);
                        },
                      );
                    } else {
                      return const SafeArea(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.0),
                          child: EmptyCart(),
                        ),
                      );
                    }
                  }

                  if (state is CartFailedState) {
                    return Center(
                      child: Text(state.message),
                    );
                  }
                  return const SizedBox.shrink();
                },
              );
            }

            return const UnauthenticatedPage();
          },
        ),
      ),
    );
  }
}
