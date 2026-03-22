import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/usage_record_model.dart';

class UsageService {
  static final UsageService _instance = UsageService._internal();
  factory UsageService() => _instance;
  UsageService._internal();

  List<UsageRecord> _usageRecords = [];

  // Load usage records from JSON file
  Future<void> _loadUsageRecords() async {
    if (_usageRecords.isNotEmpty) return;

    try {
      final String jsonString = await rootBundle.loadString(
        'assets/data/usage_records.json',
      );
      final Map<String, dynamic> data = json.decode(jsonString);
      final List<dynamic> usageRecordsList = data['usageRecords'];

      _usageRecords = usageRecordsList.map((json) {
        // Convert JSON to match UsageRecord model
        final usageRecordJson = {
          'id': json['id'],
          'userId': json['userId'],
          'vendorId': json['vendorId'],
          'vendorName': json['vendorName'],
          'type': 'call', // Default to call type
          'durationSeconds':
              json['duration'] *
              60, // Convert minutes to seconds for UsageRecord model
          'tokensUsed': json['tokensUsed'],
          'date': json['date'],
        };
        return UsageRecord.fromJson(usageRecordJson);
      }).toList();
    } catch (e) {
      // Fallback to empty list if JSON loading fails
      _usageRecords = [];
    }
  }

  // Get usage history
  Future<List<UsageRecord>> getUsageHistory() async {
    await _loadUsageRecords();

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 600));

    return _usageRecords;
  }

  // Get usage stats
  Future<Map<String, dynamic>> getUsageStats() async {
    await _loadUsageRecords();

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 400));

    final totalTokensUsed = _usageRecords.fold<int>(
      0,
      (sum, record) => sum + record.tokensUsed,
    );
    final totalCalls = _usageRecords
        .where((r) => r.type == UsageType.call)
        .length;
    final totalChats = _usageRecords
        .where((r) => r.type == UsageType.chat)
        .length;
    final totalDuration = _usageRecords.fold<Duration>(
      Duration.zero,
      (sum, record) => sum + record.duration,
    );

    // Get usage by vendor
    final vendorUsage = <String, Map<String, dynamic>>{};
    for (final record in _usageRecords) {
      if (!vendorUsage.containsKey(record.vendorId)) {
        vendorUsage[record.vendorId] = {
          'vendorName': record.vendorName,
          'totalTokens': 0,
          'sessions': 0,
        };
      }
      vendorUsage[record.vendorId]!['totalTokens'] += record.tokensUsed;
      vendorUsage[record.vendorId]!['sessions'] += 1;
    }

    return {
      'totalTokensUsed': totalTokensUsed,
      'totalCalls': totalCalls,
      'totalChats': totalChats,
      'totalDuration': totalDuration.inMinutes,
      'vendorUsage': vendorUsage,
    };
  }

  // Get usage by date range
  Future<List<UsageRecord>> getUsageByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    await _loadUsageRecords();

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    return _usageRecords
        .where(
          (record) =>
              record.date.isAfter(
                startDate.subtract(const Duration(days: 1)),
              ) &&
              record.date.isBefore(endDate.add(const Duration(days: 1))),
        )
        .toList();
  }
}
