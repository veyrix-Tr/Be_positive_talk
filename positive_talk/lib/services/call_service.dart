import 'dart:async';
import '../models/call_session_model.dart';

class CallService {
  static final CallService _instance = CallService._internal();
  factory CallService() => _instance;
  CallService._internal();

  // Mock call sessions
  final List<CallSession> _mockCallSessions = [
    CallSession(
      id: 'call_1',
      userId: 'user_123',
      vendorId: 'vendor_1',
      startTime: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
      endTime: DateTime.now().subtract(const Duration(days: 1, hours: 1)),
      durationSeconds: 3600,
      tokensSpent: 30,
      callStatus: CallStatus.completed,
    ),
    CallSession(
      id: 'call_2',
      userId: 'user_123',
      vendorId: 'vendor_2',
      startTime: DateTime.now().subtract(const Duration(days: 2, hours: 3)),
      endTime: DateTime.now().subtract(const Duration(days: 2, hours: 2, minutes: 30)),
      durationSeconds: 2700,
      tokensSpent: 27,
      callStatus: CallStatus.completed,
    ),
    CallSession(
      id: 'call_3',
      userId: 'user_123',
      vendorId: 'vendor_3',
      startTime: DateTime.now().subtract(const Duration(days: 3, hours: 1)),
      endTime: DateTime.now().subtract(const Duration(days: 3)),
      durationSeconds: 1800,
      tokensSpent: 12,
      callStatus: CallStatus.completed,
    ),
    CallSession(
      id: 'call_4',
      userId: 'user_123',
      vendorId: 'vendor_4',
      startTime: DateTime.now().subtract(const Duration(days: 4)),
      endTime: DateTime.now().subtract(const Duration(days: 4)),
      durationSeconds: 900,
      tokensSpent: 15,
      callStatus: CallStatus.missed,
    ),
    CallSession(
      id: 'call_5',
      userId: 'user_123',
      vendorId: 'vendor_5',
      startTime: DateTime.now().subtract(const Duration(days: 5)),
      endTime: null,
      durationSeconds: null,
      tokensSpent: null,
      callStatus: CallStatus.cancelled,
    ),
  ];

  CallSession? _currentCall;

  Future<CallSession> startCall(String vendorId) async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    final newCall = CallSession(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: 'user_123',
      vendorId: vendorId,
      startTime: DateTime.now(),
      endTime: null,
      durationSeconds: null,
      tokensSpent: null,
      callStatus: CallStatus.ongoing,
    );

    _currentCall = newCall;
    _mockCallSessions.add(newCall);
    
    return newCall;
  }

  Future<CallSession> endCall() async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 300));
    
    if (_currentCall != null) {
      final endTime = DateTime.now();
      final duration = endTime.difference(_currentCall!.startTime).inSeconds;
      final tokensSpent = (duration / 60).ceil() * 5; // 5 tokens per minute
      
      final updatedCall = _currentCall!.copyWith(
        endTime: endTime,
        durationSeconds: duration,
        tokensSpent: tokensSpent,
        callStatus: CallStatus.completed,
      );
      
      // Update in mock list
      final callIndex = _mockCallSessions.indexWhere((call) => call.id == _currentCall!.id);
      if (callIndex != -1) {
        _mockCallSessions[callIndex] = updatedCall;
      }
      
      _currentCall = null;
      return updatedCall;
    }
    
    throw Exception('No active call to end');
  }

  Future<List<CallSession>> getCallHistory() async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 600));
    
    // Return completed calls, sorted by start time (newest first)
    return _mockCallSessions
        .where((call) => call.callStatus == CallStatus.completed)
        .toList()
      ..sort((a, b) => b.startTime.compareTo(a.startTime));
  }

  Future<List<CallSession>> getAllCallSessions() async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 600));
    
    // Return all calls, sorted by start time (newest first)
    return _mockCallSessions
      ..sort((a, b) => b.startTime.compareTo(a.startTime));
  }

  Future<CallSession?> getCurrentCall() async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 100));
    
    return _currentCall;
  }

  Future<void> cancelCall() async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 300));
    
    if (_currentCall != null) {
      final cancelledCall = _currentCall!.copyWith(
        endTime: DateTime.now(),
        callStatus: CallStatus.cancelled,
      );
      
      // Update in mock list
      final callIndex = _mockCallSessions.indexWhere((call) => call.id == _currentCall!.id);
      if (callIndex != -1) {
        _mockCallSessions[callIndex] = cancelledCall;
      }
      
      _currentCall = null;
    }
  }
}
