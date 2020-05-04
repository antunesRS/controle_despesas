import 'package:controledespesas/components/TransactionForm.dart';
import 'package:controledespesas/components/spending_type_dropdown.dart';
import 'package:controledespesas/enums/transaction_types.dart';
import 'package:controledespesas/helpers/transaction_helper.dart';
import 'package:controledespesas/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionsTab extends StatefulWidget {

  final TransactionType _type;
  final String _title;
  final Color _color;
  final IconData _iconData;
  final String _dialogTitle;

  TransactionsTab(type) : this._type = type,
              this._title = type == TransactionType.earning? 'Proventos' : 'Gastos',
              this._color = type == TransactionType.earning? Colors.green : Colors.red,
              this._iconData = type == TransactionType.earning? Icons.monetization_on : Icons.money_off,
              this._dialogTitle = type == TransactionType.earning? 'Novo Provento' : 'Novo Gasto';


  @override
  _TransactionsTabState createState() => _TransactionsTabState();
}

class _TransactionsTabState extends State<TransactionsTab> {

  final TransactionHelper _transactionHelper = TransactionHelper();
  List<TransactionValue> _transactions = List();
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _getAllTransactions(widget._type.getId());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._title),
        centerTitle: true,
        backgroundColor: widget._color,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: widget._color,
        onPressed: ()async{
          TransactionValue transactionValue = await _showInputScreen();
          debugPrint(transactionValue.toString());
          if(transactionValue != null)
            _transactionHelper.save(transactionValue);
          _getAllTransactions(widget._type.getId());
        }
      ),
      body: ListView.builder(
        padding: EdgeInsets.only(top: 8),
          itemCount: _transactions.length,
          itemBuilder: (context, index) => _buildTransactionItem(_transactions, index, context)
        ),
    );
  }

  Widget _buildTransactionItem(List<TransactionValue> transactions, int index, context){
    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment(-0.9, 0.0),
          child: Icon(Icons.delete, color: Colors.white,),
        ),
      ),
      direction: DismissDirection.startToEnd,
      child: Card(
        child: ListTile(
          leading: Icon(widget._iconData, color: widget._color,),
          title: Text(_transactions[index].typeName),
          subtitle: Text(_transactions[index].value.toString()),
          trailing: Text(_transactions[index].date),
        ),
      ),
      onDismissed: (direction){
        final removedTransaction = _transactions[index];
        setState(() {
          _transactions.removeAt(index);
        });

        _transactionHelper.delete(removedTransaction.id);

        final snackBar = SnackBar(
          content: Text("${widget._type.getId() == 1 ? 'Provento' : 'Gasto'} removido"),
          action: SnackBarAction(
            label: 'Desfazer',
            onPressed: (){
              setState(() {
                _transactions.insert(index, removedTransaction);
              });
              _transactionHelper.save(removedTransaction);
            },
          ),
          duration: Duration(seconds: 3),
        );

        Scaffold.of(context).removeCurrentSnackBar();
        Scaffold.of(context).showSnackBar(snackBar);

        _getAllTransactions(widget._type.getId());
      },
    );
  }

  Future<TransactionValue> _showInputScreen() async{
   return await showDialog(
        context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(10),
          title: Center(child: Text(widget._dialogTitle)),
          content: TransactionForm(widget._type)
        );
      }
    );
    }

  void _getAllTransactions(int type){

    _transactionHelper.getAllByType(type).then((list) {
      setState(() {
        _transactions = list;
      });
    });
  }
  }
