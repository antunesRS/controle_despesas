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

class ContactHelper{
  static final ContactHelper _instance = ContactHelper.internal();
  factory ContactHelper() => _instance;
  ContactHelper.internal();

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
    Database dbContact = await db;
    dbContact.insert(transactionTable, transaction.toMap());
  }

  Future<TransactionValue> getContact(int id) async{
    Database dbContact = await db;
    List<Map> maps = await dbContact.query(transactionTable,
        columns: [idColumn, typeColumn, valueColumn, spendingTypeColumn, dateColumn],
        where: '$idColumn = ?',
        whereArgs: [id]);

    if(maps.length > 0){
      return TransactionValue.fromMap(maps.first);
    }
    else{
      return null;
    }
  }

  Future<int> delete(int id) async{
    Database dbContact = await db;
    return await dbContact.delete(transactionTable,
        where: '$idColumn = ?',
        whereArgs: [id]);
  }

  Future<int> updateContact(TransactionValue transaction) async{
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