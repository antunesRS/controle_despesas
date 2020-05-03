import 'package:flutter/material.dart';

class SpendingTab extends StatefulWidget {
  @override
  _SpendingTabState createState() => _SpendingTabState();
}

class _SpendingTabState extends State<SpendingTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gastos'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
        onPressed: (){},
      ),
    );
  }
}
