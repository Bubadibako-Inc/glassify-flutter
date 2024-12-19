import '../../../data/transaction/models/item.dart';

class TransactionEntity {
  TransactionEntity({
    required this.id,
    required this.date,
    required this.items,
    required this.totalAmount,
    required this.userId,
  });

  final String? id;
  final DateTime? date;
  final List<Item> items;
  final int? totalAmount;
  final String? userId;
}
