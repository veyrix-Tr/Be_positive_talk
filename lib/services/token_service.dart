import 'dart:async';
import 'package:flutter/foundation.dart';

class TokenService extends ChangeNotifier {
  static final TokenService _instance = TokenService._internal();
  factory TokenService() => _instance;
  TokenService._internal();

  int _tokens = 120;
  int _callDuration = 0;
  int _tokensUsed = 0;
  Timer? _callTimer;
  bool _isCallActive = false;

  // Current token balance
  int get tokens => _tokens;

  // Call duration in seconds
  int get callDuration => _callDuration;

  // Tokens used during current call
  int get tokensUsed => _tokensUsed;

  // Whether a call is currently active
  bool get isCallActive => _isCallActive;

  /// Start a call and begin token deduction
  void startCall() {
    if (_isCallActive) return; // Call already active

    _isCallActive = true;
    _callDuration = 0;
    _tokensUsed = 0;

    _callTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_isCallActive) {
        timer.cancel();
        return;
      }

      _callDuration++;

      // Deduct 1 token per second
      if (_tokens > 0) {
        _tokens--;
        _tokensUsed++;
        notifyListeners();
      } else {
        // Auto disconnect when tokens reach zero
        stopCall();
      }
    });

    notifyListeners();
  }

  /// Stop the call and return session data
  CallSessionData stopCall() {
    if (!_isCallActive) {
      return CallSessionData(
        duration: _callDuration,
        tokensUsed: _tokensUsed,
        remainingTokens: _tokens,
      );
    }

    _callTimer?.cancel();
    _isCallActive = false;

    final sessionData = CallSessionData(
      duration: _callDuration,
      tokensUsed: _tokensUsed,
      remainingTokens: _tokens,
    );

    notifyListeners();
    return sessionData;
  }

  /// Add tokens (for purchases)
  void addTokens(int amount) {
    _tokens += amount;
    notifyListeners();
  }

  /// Check if user has sufficient tokens for a call
  bool hasSufficientTokens(int requiredTokens) {
    return _tokens >= requiredTokens;
  }

  /// Reset tokens to default value
  void resetTokens() {
    if (_isCallActive) {
      stopCall(); // Stop any active call before reset
    }
    _tokens = 120;
    _callDuration = 0;
    _tokensUsed = 0;
    notifyListeners();
  }

  /// Check if tokens are exhausted
  bool get isTokensExhausted => _tokens <= 0;
}

/// Data model for call session information
class CallSessionData {
  final int duration; // in seconds
  final int tokensUsed;
  final int remainingTokens;

  CallSessionData({
    required this.duration,
    required this.tokensUsed,
    required this.remainingTokens,
  });

  /// Format duration as MM:SS
  String get formattedDuration {
    final minutes = duration ~/ 60;
    final seconds = duration % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
