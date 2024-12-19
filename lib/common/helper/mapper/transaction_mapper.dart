import '../../../data/transaction/models/transaction.dart';
import '../../../domain/transaction/entities/transaction.dart';

class TransactionMapper {
  static TransactionEntity toEntity(TransactionModel transaction) {
    return TransactionEntity(
      id: transaction.id,
      userId: transaction.userId,
      date: transaction.date,
      items: transaction.items,
      totalAmount: transaction.totalAmount,
    );
  }
}
