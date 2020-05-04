import 'dart:async';
import 'package:controledespesas/models/transaction.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String transactionTable = 'transactionTable';
final String idColumn = 'id';
final String typeColumn = 'type';
final String valueColumn = 'value';
final String spendingTypeColumn = 'spendingType';
final String dateColumn = 'date';

class TransactionHelper{
  static final TransactionHelper _instance = TransactionHelper.internal();
  factory TransactionHelper() => _instance;
  TransactionHelper.internal();

  Database _db;

  Future<Database> get db async {
    if(_db != null){
      return _db;
    }
    else{
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final String path = join(await getDatabasesPath(), 'transaction.db');

    return await openDatabase(path, onCreate: (db, version) async{
      await db.execute(_buildQuery());
    }, version: 1);

  }

  String _buildQuery(){
    String sql =
        'CREATE TABLE $transactionTable('
        '$idColumn INTEGER PRIMARY KEY, '
        '$typeColumn INTEGER, '
        '$valueColumn TEXT, '
        '$spendingTypeColumn TEXT, '
        '$dateColumn TEXT)';
    return sql;
  }

  void save(TransactionValue transaction) async {
    Database dbTransaction = await db;
    dbTransaction.insert(transactionTable, transaction.toMap());
  }

  Future<List<TransactionValue>> getAllByType(int type) async{
    Database dbTransaction = await db;
    List<Map> maps = await dbTransaction.query(transactionTable,
        columns: [idColumn, typeColumn, valueColumn, spendingTypeColumn, dateColumn],
        where: '$typeColumn = ?',
        whereArgs: [type]);

    List<TransactionValue> transactions = List();

    for( Map map in maps)
      transactions.add(TransactionValue.fromMap(map));

    return transactions;
  }

  Future<int> delete(int id) async{
    Database dbTransaction = await db;
    return await dbTransaction.delete(transactionTable,
        where: '$idColumn = ?',
        whereArgs: [id]);
  }

  Future<int> updateTransaction(TransactionValue transaction) async{
    Database dbContact = await db;
    return await dbContact.update(transactionTable,
        transaction.toMap(), where: "$idColumn = ?", whereArgs: [transaction.id]);
  }

  Future<List<TransactionValue>> getAll() async {
    Database dbContact = await db;
    List listMap = await dbContact.rawQuery('SELECT * FROM $transactionTable');
    List<TransactionValue> transactionList = List();
    for(Map map in listMap){
      transactionList.add(TransactionValue.fromMap(map));
    }
    return transactionList;
  }

  Future<int> getNumber() async{
    Database dbContact = await db;
    return Sqflite.firstIntValue(await dbContact.rawQuery("SELECT COUNT(*) FROM $transactionTable"));
  }

  Future<Null> close() async {
    Database dbContact = await db;
    dbContact.close();
  }

}