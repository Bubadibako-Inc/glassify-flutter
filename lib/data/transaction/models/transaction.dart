import 'item.dart';

class TransactionModel {
  TransactionModel({
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

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json["_id"],
      date: DateTime.tryParse(json["date"] ?? ""),
      items: json["items"] == null
          ? []
          : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
      totalAmount: json["total_amount"],
      userId: json["user_id"],
    );
  }
}
