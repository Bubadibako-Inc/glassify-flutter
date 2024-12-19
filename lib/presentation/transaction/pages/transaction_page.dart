import 'package:flutter/material.dart';

import '../widgets/transaction_appbar.dart';
import '../widgets/transaction_content.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(96),
        child: TransactionAppbar(isPage: true),
      ),
      body: TransactionContent(),
    );
  }
}
