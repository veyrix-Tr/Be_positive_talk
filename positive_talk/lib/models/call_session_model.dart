enum CallStatus {
  waiting,
  ongoing,
  completed,
  cancelled,
  failed,
}

class CallSession {
  final String id;
  final String userId;
  final String vendorId;
  final DateTime startTime;
  final DateTime endTime;
  final int durationSeconds;
  final int tokensSpent;
  final CallStatus callStatus;

  const CallSession({
    required this.id,
    required this.userId,
    required this.vendorId,
    required this.startTime,
    required this.endTime,
    required this.durationSeconds,
    required this.tokensSpent,
    required this.callStatus,
  });

  factory CallSession.fromJson(Map<String, dynamic> json) {
    return CallSession(
      id: json['id'] as String,
      userId: json['userId'] as String,
      vendorId: json['vendorId'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      durationSeconds: json['durationSeconds'] as int,
      tokensSpent: json['tokensSpent'] as int,
      callStatus: CallStatus.values.firstWhere(
        (status) => status.toString() == json['callStatus'] as String,
        orElse: () => CallStatus.waiting,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'vendorId': vendorId,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'durationSeconds': durationSeconds,
      'tokensSpent': tokensSpent,
      'callStatus': callStatus.toString(),
    };
  }
}
