enum CallStatus {
  pending,
  ongoing,
  completed,
  cancelled,
  missed,
}

class CallSession {
  final String id;
  final String userId;
  final String vendorId;
  final DateTime startTime;
  final DateTime? endTime;
  final int? durationSeconds;
  final int? tokensSpent;
  final CallStatus callStatus;

  const CallSession({
    required this.id,
    required this.userId,
    required this.vendorId,
    required this.startTime,
    this.endTime,
    this.durationSeconds,
    this.tokensSpent,
    required this.callStatus,
  });

  factory CallSession.fromJson(Map<String, dynamic> json) {
    return CallSession(
      id: json['id'] as String,
      userId: json['userId'] as String,
      vendorId: json['vendorId'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] != null ? DateTime.parse(json['endTime'] as String) : null,
      durationSeconds: json['durationSeconds'] as int?,
      tokensSpent: json['tokensSpent'] as int?,
      callStatus: CallStatus.values.firstWhere(
        (status) => status.name == json['callStatus'],
        orElse: () => CallStatus.pending,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'vendorId': vendorId,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'durationSeconds': durationSeconds,
      'tokensSpent': tokensSpent,
      'callStatus': callStatus.name,
    };
  }

  CallSession copyWith({
    String? id,
    String? userId,
    String? vendorId,
    DateTime? startTime,
    DateTime? endTime,
    int? durationSeconds,
    int? tokensSpent,
    CallStatus? callStatus,
  }) {
    return CallSession(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      vendorId: vendorId ?? this.vendorId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      tokensSpent: tokensSpent ?? this.tokensSpent,
      callStatus: callStatus ?? this.callStatus,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CallSession &&
        other.id == id &&
        other.userId == userId &&
        other.vendorId == vendorId &&
        other.startTime == startTime &&
        other.endTime == endTime &&
        other.durationSeconds == durationSeconds &&
        other.tokensSpent == tokensSpent &&
        other.callStatus == callStatus;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        vendorId.hashCode ^
        startTime.hashCode ^
        endTime.hashCode ^
        durationSeconds.hashCode ^
        tokensSpent.hashCode ^
        callStatus.hashCode;
  }

  @override
  String toString() {
    return 'CallSession(id: $id, userId: $userId, vendorId: $vendorId, startTime: $startTime, endTime: $endTime, durationSeconds: $durationSeconds, tokensSpent: $tokensSpent, callStatus: $callStatus)';
  }
}
