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
        (type) => type.name == json['type'],
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
      'type': type.name,
      'tokens': tokens,
      'amount': amount,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  Transaction copyWith({
    String? id,
    String? userId,
    TransactionType? type,
    int? tokens,
    double? amount,
    String? description,
    DateTime? createdAt,
  }) {
    return Transaction(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      tokens: tokens ?? this.tokens,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Transaction &&
        other.id == id &&
        other.userId == userId &&
        other.type == type &&
        other.tokens == tokens &&
        other.amount == amount &&
        other.description == description &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        type.hashCode ^
        tokens.hashCode ^
        amount.hashCode ^
        description.hashCode ^
        createdAt.hashCode;
  }

  @override
  String toString() {
    return 'Transaction(id: $id, userId: $userId, type: $type, tokens: $tokens, amount: $amount, description: $description, createdAt: $createdAt)';
  }
}
