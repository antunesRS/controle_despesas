import 'package:flutter/material.dart';

class SpendingTypeDropdown extends StatefulWidget {
  @override
  _SpendingTypeDropdownState createState() => _SpendingTypeDropdownState();
}

class _SpendingTypeDropdownState extends State<SpendingTypeDropdown> {

  String dropdownValue = 'Cartão de crédito';
  final options = ['Cartão de crédito', 'Compras', 'Lazer', 'Gastos pontuais', 'Gastos emergenciais','Outros'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: DropdownButton<String>(
        hint: Text('Tipo de gasto'),
        value: dropdownValue,
        icon: Icon(Icons.keyboard_arrow_down),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(
          color: Colors.red
        ),
        underline: Container(
          height: 2,
          color: Colors.redAccent,
        ),
        onChanged: (String newValue){
          setState(() {
            dropdownValue = newValue;
          });
        },
        items: options.map((option){
          return DropdownMenuItem(
            value: option,
            child: Text(option),
          );
        }).toList(),
      ),
    );
  }
}
