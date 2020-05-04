import 'package:controledespesas/enums/transaction_types.dart';
import 'package:controledespesas/tabs/transaction_tab.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: <Widget>[
        TransactionsTab(TransactionType.earning),
        TransactionsTab(TransactionType.spending),
      ],
    );
  }
}
