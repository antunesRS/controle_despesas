import 'package:controledespesas/enums/transaction_types.dart';

class TransactionValue{
    int id;
    TransactionType type;
    double value;
    String typeName;
    String date;

    TransactionValue(this.type, this.value, this.typeName, this.date);

    TransactionValue.fromMap(Map<String, dynamic> map){
        this.id = map['id'];
        this.type = map['type'] == 1? TransactionType.earning :
                                                 TransactionType.spending;
        this.value = double.parse(map['value']);
        this.typeName = map['spendingType'];
        this.date = map['date'];
    }

    Map<String, dynamic> toMap(){
        Map<String, dynamic> map = {
          //'id' : this.id,
          'type' : this.type.getId(),
          'value' : this.value,
          'spendingType' : this.typeName,
          'date' : this.date
        };

        return map;
    }

    @override
    String toString() {
        return 'Transaction{id: $id, type: $type, value: $value, spendingType: $typeName, date: $date}';
    }


}