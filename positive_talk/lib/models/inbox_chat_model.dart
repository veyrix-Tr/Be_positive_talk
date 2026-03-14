class InboxChat {
  final String id;
  final String vendorId;
  final String vendorName;
  final String vendorImage;
  final String lastMessage;
  final DateTime lastMessageTime;
  final int unreadCount;
  final bool isOnline;

  const InboxChat({
    required this.id,
    required this.vendorId,
    required this.vendorName,
    required this.vendorImage,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.unreadCount,
    required this.isOnline,
  });

  String get formattedDate {
    final now = DateTime.now();
    final difference = now.difference(lastMessageTime);
    
    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}
