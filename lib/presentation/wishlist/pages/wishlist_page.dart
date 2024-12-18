import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/bloc/auth_bloc.dart';

import '../../unauthenticated/page/unauthenticated_page.dart';

import '../widgets/wishlist_appbar.dart';
import '../widgets/wishlist_content.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(96),
          child: WishlistAppbar(isPage: true),
        ),
        body: BlocBuilder(
          bloc: AuthBloc()..add(GetToken()),
          builder: (context, state) {
            if (state is UnauthenticatedState) {
              return const UnauthenticatedPage();
            }

            if (state is AuthenticatedState) {
              return const WishlistContent();
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
