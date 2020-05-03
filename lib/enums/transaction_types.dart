enum TransactionType {earning, spending}
extension ParseToInt on TransactionType{
  int getId(){
    return this == TransactionType.earning ? 1 : 2;
  }
}