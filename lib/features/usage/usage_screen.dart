import 'package:flutter/material.dart';
import '../../../core/theme/typography.dart';
import '../../../core/theme/colors.dart';

class UsageScreen extends StatelessWidget {
  const UsageScreen({super.key});

  // Mock usage data
  List<UsageRecord> get _mockUsage => [
    UsageRecord(
      id: '1',
      vendorName: 'Aashna',
      duration: Duration(minutes: 12),
      tokensUsed: 24,
      date: 'Mar 6, 2026',
      type: UsageType.call,
    ),
    UsageRecord(
      id: '2',
      vendorName: 'Mike Chen',
      duration: Duration(minutes: 8),
      tokensUsed: 16,
      date: 'Mar 5, 2026',
      type: UsageType.call,
    ),
    UsageRecord(
      id: '3',
      vendorName: 'Emma Davis',
      duration: Duration(minutes: 15),
      tokensUsed: 30,
      date: 'Mar 4, 2026',
      type: UsageType.call,
    ),
    UsageRecord(
      id: '4',
      vendorName: 'Alex Rodriguez',
      duration: Duration(minutes: 20),
      tokensUsed: 40,
      date: 'Mar 3, 2026',
      type: UsageType.call,
    ),
    UsageRecord(
      id: '5',
      vendorName: 'Lisa Wang',
      duration: Duration(minutes: 6),
      tokensUsed: 12,
      date: 'Mar 2, 2026',
      type: UsageType.call,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        title: Text(
          'Usage History',
          style: AppTypography.headline3,
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _mockUsage.length,
        itemBuilder: (context, index) {
          final usage = _mockUsage[index];
          return _UsageRecordTile(usage: usage);
        },
      ),
    );
  }
}

class _UsageRecordTile extends StatelessWidget {
  final UsageRecord usage;

  const _UsageRecordTile({required this.usage});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with vendor name and type
          Row(
            children: [
              Icon(
                usage.type == UsageType.call ? Icons.call_outlined : Icons.chat_outlined,
                color: AppColors.primary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Call with ${usage.vendorName}',
                  style: AppTypography.title2.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Details
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Duration',
                      style: AppTypography.caption1.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${usage.duration.inMinutes} min',
                      style: AppTypography.body1.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tokens used',
                      style: AppTypography.caption1.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${usage.tokensUsed}',
                      style: AppTypography.body1.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Date
          Text(
            usage.date,
            style: AppTypography.caption1.copyWith(
              color: AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}

class UsageRecord {
  final String id;
  final String vendorName;
  final Duration duration;
  final int tokensUsed;
  final String date;
  final UsageType type;

  UsageRecord({
    required this.id,
    required this.vendorName,
    required this.duration,
    required this.tokensUsed,
    required this.date,
    required this.type,
  });
}

enum UsageType { call, chat }
