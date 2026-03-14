enum UsageType {
  call,
  chat,
}

class UsageRecord {
  final String id;
  final String userId;
  final String vendorId;
  final String vendorName;
  final UsageType type;
  final Duration duration;
  final int tokensUsed;
  final DateTime date;

  const UsageRecord({
    required this.id,
    required this.userId,
    required this.vendorId,
    required this.vendorName,
    required this.type,
    required this.duration,
    required this.tokensUsed,
    required this.date,
  });

  factory UsageRecord.fromJson(Map<String, dynamic> json) {
    return UsageRecord(
      id: json['id'] as String,
      userId: json['userId'] as String,
      vendorId: json['vendorId'] as String,
      vendorName: json['vendorName'] as String,
      type: UsageType.values.firstWhere(
        (type) => type.toString() == json['type'] as String,
        orElse: () => UsageType.call,
      ),
      duration: Duration(seconds: json['durationSeconds'] as int),
      tokensUsed: json['tokensUsed'] as int,
      date: DateTime.parse(json['date'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'vendorId': vendorId,
      'vendorName': vendorName,
      'type': type.toString(),
      'durationSeconds': duration.inSeconds,
      'tokensUsed': tokensUsed,
      'date': date.toIso8601String(),
    };
  }
}
