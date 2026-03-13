import 'dart:async';

enum UsageType { call, chat, video }

class UsageService {
  static final UsageService _instance = UsageService._internal();
  factory UsageService() => _instance;
  UsageService._internal();

  // Mock usage data - extended version of call service data
  final List<UsageRecord> _mockUsageRecords = [
    UsageRecord(
      id: 'usage_1',
      vendorName: 'Aashna',
      vendorImage: 'assets/profile1.png',
      duration: const Duration(minutes: 45),
      tokensUsed: 5,
      date: 'Mar 10, 2026',
      type: UsageType.call,
    ),
    UsageRecord(
      id: 'usage_2',
      vendorName: 'Mike Chen',
      vendorImage: 'assets/profile1.png',
      duration: const Duration(minutes: 30),
      tokensUsed: 6,
      date: 'Mar 9, 2026',
      type: UsageType.call,
    ),
    UsageRecord(
      id: 'usage_3',
      vendorName: 'Emma Davis',
      vendorImage: 'assets/profile1.png',
      duration: const Duration(minutes: 25),
      tokensUsed: 4,
      date: 'Mar 8, 2026',
      type: UsageType.call,
    ),
    UsageRecord(
      id: 'usage_4',
      vendorName: 'Lisa Wang',
      vendorImage: 'assets/profile1.png',
      duration: const Duration(minutes: 60),
      tokensUsed: 12,
      date: 'Mar 7, 2026',
      type: UsageType.call,
    ),
    UsageRecord(
      id: 'usage_5',
      vendorName: 'Robert Johnson',
      vendorImage: 'assets/profile1.png',
      duration: const Duration(minutes: 15),
      tokensUsed: 8,
      date: 'Mar 6, 2026',
      type: UsageType.call,
    ),
    UsageRecord(
      id: 'usage_6',
      vendorName: 'Sarah Miller',
      vendorImage: 'assets/profile1.png',
      duration: const Duration(minutes: 40),
      tokensUsed: 7,
      date: 'Mar 5, 2026',
      type: UsageType.call,
    ),
    UsageRecord(
      id: 'usage_7',
      vendorName: 'David Kim',
      vendorImage: 'assets/profile1.png',
      duration: const Duration(minutes: 55),
      tokensUsed: 11,
      date: 'Mar 4, 2026',
      type: UsageType.call,
    ),
    UsageRecord(
      id: 'usage_8',
      vendorName: 'Aashna',
      vendorImage: 'assets/profile1.png',
      duration: const Duration(minutes: 20),
      tokensUsed: 2,
      date: 'Mar 3, 2026',
      type: UsageType.call,
    ),
  ];

  Future<List<UsageRecord>> getUsageHistory() async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 600));

    // Return usage records sorted by date (newest first)
    final sortedRecords = List<UsageRecord>.from(_mockUsageRecords)
      ..sort((a, b) => b.date.compareTo(a.date));

    return sortedRecords;
  }

  Future<List<UsageRecord>> getUsageByType(UsageType type) async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 400));

    return _mockUsageRecords.where((record) => record.type == type).toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  Future<List<UsageRecord>> getUsageByVendor(String vendorName) async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 400));

    return _mockUsageRecords
        .where((record) => record.vendorName == vendorName)
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  Future<Map<String, dynamic>> getUsageStats() async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 500));

    final totalCalls = _mockUsageRecords.length;
    final totalMinutes = _mockUsageRecords.fold<int>(
      0,
      (sum, record) => sum + record.duration.inMinutes,
    );
    final totalTokens = _mockUsageRecords.fold<int>(
      0,
      (sum, record) => sum + record.tokensUsed,
    );

    final averageCallDuration = totalCalls > 0
        ? Duration(minutes: (totalMinutes / totalCalls).round())
        : Duration.zero;

    // Most frequently contacted vendor
    final vendorCounts = <String, int>{};
    for (final record in _mockUsageRecords) {
      vendorCounts[record.vendorName] =
          (vendorCounts[record.vendorName] ?? 0) + 1;
    }

    final topVendor = vendorCounts.isNotEmpty
        ? vendorCounts.entries.reduce((a, b) => a.value > b.value ? a : b).key
        : 'None';

    return {
      'totalCalls': totalCalls,
      'totalMinutes': totalMinutes,
      'totalTokens': totalTokens,
      'averageCallDuration': '${averageCallDuration.inMinutes} min',
      'topVendor': topVendor,
      'uniqueVendors': vendorCounts.length,
      'thisMonthCalls': 3, // Mock data
      'thisMonthTokens': 15, // Mock data
    };
  }

  Future<List<UsageRecord>> getUsageByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 400));

    return _mockUsageRecords.where((record) {
      final recordDate = DateTime.parse(record.date);
      return recordDate.isAfter(startDate.subtract(const Duration(days: 1))) &&
          recordDate.isBefore(endDate.add(const Duration(days: 1)));
    }).toList()..sort((a, b) => b.date.compareTo(a.date));
  }

  Future<Map<String, dynamic>> getMonthlyUsage() async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 300));

    final now = DateTime.now();
    final currentMonth = now.month;
    final currentYear = now.year;

    final monthlyUsage = <int, List<UsageRecord>>{};
    for (final record in _mockUsageRecords) {
      final recordDate = DateTime.parse(record.date);
      final monthKey =
          recordDate.year * 100 + recordDate.month; // YYYYMM format

      if (!monthlyUsage.containsKey(monthKey)) {
        monthlyUsage[monthKey] = [];
      }
      monthlyUsage[monthKey]!.add(record);
    }

    return {
      'currentMonth': currentMonth,
      'currentYear': currentYear,
      'monthlyData': monthlyUsage,
      'trend': 'increasing', // Mock trend
    };
  }
}

class UsageRecord {
  final String id;
  final String vendorName;
  final String vendorImage;
  final Duration duration;
  final int tokensUsed;
  final String date;
  final UsageType type;

  UsageRecord({
    required this.id,
    required this.vendorName,
    required this.vendorImage,
    required this.duration,
    required this.tokensUsed,
    required this.date,
    required this.type,
  });
}
