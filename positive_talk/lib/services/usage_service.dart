import '../models/usage_record_model.dart';

class UsageService {
  static final UsageService _instance = UsageService._internal();
  factory UsageService() => _instance;
  UsageService._internal();

  // Mock usage records
  final List<UsageRecord> _mockUsageRecords = [
    UsageRecord(
      id: '1',
      userId: 'user1',
      vendorId: '1',
      vendorName: 'Aashna',
      type: UsageType.call,
      duration: const Duration(minutes: 15),
      tokensUsed: 75,
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
    UsageRecord(
      id: '2',
      userId: 'user1',
      vendorId: '2',
      vendorName: 'Priya',
      type: UsageType.call,
      duration: const Duration(minutes: 20),
      tokensUsed: 80,
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    UsageRecord(
      id: '3',
      userId: 'user1',
      vendorId: '3',
      vendorName: 'Rajesh',
      type: UsageType.call,
      duration: const Duration(minutes: 5),
      tokensUsed: 30,
      date: DateTime.now().subtract(const Duration(hours: 3)),
    ),
    UsageRecord(
      id: '4',
      userId: 'user1',
      vendorId: '1',
      vendorName: 'Aashna',
      type: UsageType.chat,
      duration: const Duration(minutes: 8),
      tokensUsed: 20,
      date: DateTime.now().subtract(const Duration(hours: 5)),
    ),
    UsageRecord(
      id: '5',
      userId: 'user1',
      vendorId: '2',
      vendorName: 'Priya',
      type: UsageType.chat,
      duration: const Duration(minutes: 12),
      tokensUsed: 30,
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
  ];

  // Get usage history
  Future<List<UsageRecord>> getUsageHistory() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 600));

    return _mockUsageRecords;
  }

  // Get usage stats
  Future<Map<String, dynamic>> getUsageStats() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 400));

    final totalTokensUsed = _mockUsageRecords.fold<int>(0, (sum, record) => sum + record.tokensUsed);
    final totalCalls = _mockUsageRecords.where((r) => r.type == UsageType.call).length;
    final totalChats = _mockUsageRecords.where((r) => r.type == UsageType.chat).length;
    final totalDuration = _mockUsageRecords.fold<Duration>(Duration.zero, (sum, record) => sum + record.duration);

    // Get usage by vendor
    final vendorUsage = <String, Map<String, dynamic>>{};
    for (final record in _mockUsageRecords) {
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
  Future<List<UsageRecord>> getUsageByDateRange(DateTime startDate, DateTime endDate) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    return _mockUsageRecords
        .where((record) => record.date.isAfter(startDate.subtract(const Duration(days: 1))) && record.date.isBefore(endDate.add(const Duration(days: 1))))
        .toList();
  }
}
