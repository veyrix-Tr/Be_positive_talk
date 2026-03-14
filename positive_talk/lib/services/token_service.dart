import 'package:flutter/foundation.dart';

class TokenService extends ChangeNotifier {
  static final TokenService _instance = TokenService._internal();
  factory TokenService() => _instance;
  TokenService._internal();

  int _tokens = 150;
  Duration _callDuration = Duration.zero;
  bool _isCallActive = false;
  int _tokensUsed = 0;

  int get tokens => _tokens;
  Duration get callDuration => _callDuration;
  bool get isCallActive => _isCallActive;
  int get tokensUsed => _tokensUsed;
  bool get isTokensExhausted => _tokens <= 0;

  void updateTokens(int newTokens) {
    _tokens = newTokens;
    notifyListeners();
  }

  void updateCallDuration(Duration duration) {
    _callDuration = duration;
    notifyListeners();
  }

  void consumeTokens(int tokensToConsume) {
    _tokens -= tokensToConsume;
    _tokensUsed += tokensToConsume;
    notifyListeners();
  }

  void addTokens(int tokensToAdd) {
    _tokens += tokensToAdd;
    notifyListeners();
  }

  void resetCallDuration() {
    _callDuration = Duration.zero;
    notifyListeners();
  }

  void startCall() {
    _isCallActive = true;
    _tokensUsed = 0;
    resetCallDuration();
    notifyListeners();
  }

  void stopCall() {
    _isCallActive = false;
    notifyListeners();
  }
}
