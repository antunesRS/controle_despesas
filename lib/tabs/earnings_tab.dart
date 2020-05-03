import 'package:controledespesas/models/transaction.dart';
import 'package:flutter/material.dart';

class EarningTab extends StatefulWidget {
  @override
  _EarningTabState createState() => _EarningTabState();
}

class _EarningTabState extends State<EarningTab> {

  List<TransactionValue> transactions = List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Proventos'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
        onPressed: (){},
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(8),
          itemCount: transactions.length,
          itemBuilder: null
      ),
    );
  }
}
