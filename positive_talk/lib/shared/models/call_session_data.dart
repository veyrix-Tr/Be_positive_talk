import '../../../models/call_session_model.dart';

class CallSessionData {
  final String sessionId;
  final String vendorId;
  final String vendorName;
  final DateTime startTime;
  final int tokensUsed;
  final CallStatus status;
  final Duration duration;
  final int remainingTokens;

  CallSessionData({
    required this.sessionId,
    required this.vendorId,
    required this.vendorName,
    required this.startTime,
    required this.tokensUsed,
    required this.status,
    required this.duration,
    required this.remainingTokens,
  });

  factory CallSessionData.fromCallSession(CallSession callSession, String vendorName, int remainingTokens) {
    return CallSessionData(
      sessionId: callSession.id,
      vendorId: callSession.vendorId,
      vendorName: vendorName,
      startTime: callSession.startTime,
      tokensUsed: callSession.tokensSpent,
      status: callSession.callStatus,
      duration: callSession.endTime.difference(callSession.startTime),
      remainingTokens: remainingTokens,
    );
  }

  String get formattedDuration {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
