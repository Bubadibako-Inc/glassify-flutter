import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/bloc/auth_bloc.dart';

import '../../unauthenticated/page/unauthenticated_page.dart';

import '../widgets/transaction_appbar.dart';
import '../widgets/transaction_content.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(),
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(96),
          child: TransactionAppbar(isPage: true),
        ),
        body: BlocBuilder(builder: (_, state) {
          if (state is AuthenticatedState) {
            return const TransactionContent();
          }

          if (state is UnauthenticatedState) {
            return const UnauthenticatedPage();
          }

          return const SizedBox.shrink();
        }),
      ),
    );
  }
}
