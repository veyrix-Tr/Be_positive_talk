import '../models/call_session_model.dart';

class CallService {
  static final CallService _instance = CallService._internal();
  factory CallService() => _instance;
  CallService._internal();

  // Mock call sessions
  final List<CallSession> _mockCallHistory = [
    CallSession(
      id: '1',
      userId: 'user1',
      vendorId: '1',
      startTime: DateTime.now().subtract(const Duration(days: 2)),
      endTime: DateTime.now().subtract(const Duration(days: 2)).add(const Duration(minutes: 15)),
      durationSeconds: 900,
      tokensSpent: 75,
      callStatus: CallStatus.completed,
    ),
    CallSession(
      id: '2',
      userId: 'user1',
      vendorId: '2',
      startTime: DateTime.now().subtract(const Duration(days: 1)),
      endTime: DateTime.now().subtract(const Duration(days: 1)).add(const Duration(minutes: 20)),
      durationSeconds: 1200,
      tokensSpent: 80,
      callStatus: CallStatus.completed,
    ),
    CallSession(
      id: '3',
      userId: 'user1',
      vendorId: '3',
      startTime: DateTime.now().subtract(const Duration(hours: 3)),
      endTime: DateTime.now().subtract(const Duration(hours: 3)).add(const Duration(minutes: 5)),
      durationSeconds: 300,
      tokensSpent: 30,
      callStatus: CallStatus.completed,
    ),
  ];

  CallSession? _currentCall;

  // Start a call
  Future<CallSession> startCall(String userId, String vendorId, int ratePerMinute) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    final startTime = DateTime.now();
    _currentCall = CallSession(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: userId,
      vendorId: vendorId,
      startTime: startTime,
      endTime: startTime, // Will be updated when call ends
      durationSeconds: 0,
      tokensSpent: 0,
      callStatus: CallStatus.ongoing,
    );

    return _currentCall!;
  }

  // End a call
  Future<CallSession> endCall() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    if (_currentCall == null) {
      throw Exception('No active call to end');
    }

    final endTime = DateTime.now();
    final duration = endTime.difference(_currentCall!.startTime);
    final tokensSpent = (duration.inSeconds * 5 ~/ 60); // Mock rate calculation

    final completedCall = CallSession(
      id: _currentCall!.id,
      userId: _currentCall!.userId,
      vendorId: _currentCall!.vendorId,
      startTime: _currentCall!.startTime,
      endTime: endTime,
      durationSeconds: duration.inSeconds,
      tokensSpent: tokensSpent,
      callStatus: CallStatus.completed,
    );

    // Add to history
    _mockCallHistory.add(completedCall);
    
    // Clear current call
    _currentCall = null;

    return completedCall;
  }

  // Get call history
  Future<List<CallSession>> getCallHistory() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 600));

    return _mockCallHistory;
  }

  // Get current call
  CallSession? get currentCall => _currentCall;
}
