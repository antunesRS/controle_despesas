import 'package:controledespesas/enums/transaction_types.dart';

class TransactionValue{
    int id;
    TransactionType type;
    double value;
    String spendingType;
    String date;

    TransactionValue.fromMap(Map<String, dynamic> map){
        this.id = map['id'];
        this.type = int.parse(map['type']) == 1? TransactionType.earning :
                                                 TransactionType.spending;
        this.value = map['value'];
        this.spendingType = map['spendingType'];
        this.date = map['date'];
    }

    Map<String, dynamic> toMap(){
        Map<String, dynamic> map = {
          //'id' : this.id,
          'type' : this.type.getId(),
          'value' : this.value,
          'spendingType' : this.spendingType,
          'date' : this.date
        };

        return map;
    }

    @override
    String toString() {
        return 'Transaction{id: $id, type: $type, value: $value, spendingType: $spendingType, date: $date}';
    }


}