import 'package:controledespesas/components/form_text_component.dart';
import 'package:controledespesas/enums/transaction_types.dart';
import 'package:controledespesas/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {

  final TransactionType _type;

  TransactionForm(this._type);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _valueController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormComponent(_descriptionController, 'Descrição'),
          TextFormComponent(_valueController, 'Valor'),
          FlatButton(
            child: Text('Cancelar'),
            onPressed: () {
              Navigator.pop(context);
              _descriptionController.clear();
              _valueController.clear();
            },
          ),
          FlatButton(
            child: Text('Salvar'),
            onPressed: () async{
              if (_formKey.currentState.validate()){
                TransactionValue transaction = TransactionValue(widget._type,
                    double.parse(_valueController.text),_descriptionController.text, formatDate(DateTime.now()));
                _descriptionController.clear();
                _valueController.clear();

                Navigator.pop(context, transaction);
              }
            },
          )
        ],
      ),
    );
  }

  String formatDate(DateTime date){
    final formatedDate = new DateFormat('yyyy-MM-dd');
    return formatedDate.format(DateTime.fromMillisecondsSinceEpoch(date.millisecondsSinceEpoch*1000));
  }
}
