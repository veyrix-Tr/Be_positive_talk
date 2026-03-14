enum TransactionType {
  credit,
  debit,
}

class Transaction {
  final String id;
  final String userId;
  final TransactionType type;
  final int tokens;
  final double amount;
  final String description;
  final DateTime createdAt;

  const Transaction({
    required this.id,
    required this.userId,
    required this.type,
    required this.tokens,
    required this.amount,
    required this.description,
    required this.createdAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] as String,
      userId: json['userId'] as String,
      type: TransactionType.values.firstWhere(
        (type) => type.toString() == json['type'] as String,
        orElse: () => TransactionType.credit,
      ),
      tokens: json['tokens'] as int,
      amount: (json['amount'] as num).toDouble(),
      description: json['description'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'type': type.toString(),
      'tokens': tokens,
      'amount': amount,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
