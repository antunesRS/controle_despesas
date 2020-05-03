import 'package:controledespesas/tabs/earnings_tab.dart';
import 'package:controledespesas/tabs/spendings_tab.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageView(
      children: <Widget>[
        EarningTab(),
        SpendingTab()
      ],
    );
  }
}
