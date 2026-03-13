import 'dart:async';
import '../models/message_model.dart';

class ChatService {
  static final ChatService _instance = ChatService._internal();
  factory ChatService() => _instance;
  ChatService._internal();

  // Mock chat data
  final List<Message> _mockMessages = [
    Message(
      id: '1',
      senderId: 'vendor_1',
      receiverId: 'user_123',
      text: '🙂 Let\'s make you HAPPY!',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      isRead: true,
    ),
    Message(
      id: '2',
      senderId: 'user_123',
      receiverId: 'vendor_1',
      text: 'Hi! I need some career advice.',
      timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 45)),
      isRead: true,
    ),
    Message(
      id: '3',
      senderId: 'vendor_1',
      receiverId: 'user_123',
      text: 'I\'d be happy to help! What specific area are you interested in?',
      timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 30)),
      isRead: true,
    ),
    Message(
      id: '4',
      senderId: 'vendor_2',
      receiverId: 'user_123',
      text: 'How can I help you today?',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      isRead: false,
    ),
    Message(
      id: '5',
      senderId: 'vendor_3',
      receiverId: 'user_123',
      text: 'Looking forward to our session',
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
      isRead: true,
    ),
    Message(
      id: '6',
      senderId: 'user_123',
      receiverId: 'vendor_3',
      text: 'Thank you! I\'m excited too.',
      timestamp: DateTime.now().subtract(const Duration(days: 2, minutes: 15)),
      isRead: true,
    ),
  ];

  // Mock inbox data
  final List<InboxChat> _mockInbox = [
    InboxChat(
      id: '1',
      vendorId: 'vendor_1',
      vendorName: 'Aashna',
      vendorImage: 'assets/profile1.png',
      lastMessage: '🙂 Let\'s make you HAPPY!',
      date: 'Mar 5, 2026',
      isVerified: true,
      isUnread: false,
    ),
    InboxChat(
      id: '2',
      vendorId: 'vendor_2',
      vendorName: 'Mike Chen',
      vendorImage: 'assets/profile1.png',
      lastMessage: 'How can I help you today?',
      date: 'Mar 4, 2026',
      isVerified: true,
      isUnread: true,
    ),
    InboxChat(
      id: '3',
      vendorId: 'vendor_3',
      vendorName: 'Emma Davis',
      vendorImage: 'assets/profile1.png',
      lastMessage: 'Looking forward to our session',
      date: 'Mar 3, 2026',
      isVerified: true,
      isUnread: false,
    ),
  ];

  Future<List<InboxChat>> getInboxChats() async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 600));
    
    return _mockInbox;
  }

  Future<List<Message>> getMessages(String vendorId) async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 400));
    
    // Filter messages by vendor
    return _mockMessages.where((message) => 
      message.senderId == vendorId || message.receiverId == vendorId
    ).toList();
  }

  Future<Message> sendMessage(String receiverId, String text) async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 300));
    
    final newMessage = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderId: 'user_123',
      receiverId: receiverId,
      text: text,
      timestamp: DateTime.now(),
      isRead: false,
    );

    // Add to mock messages
    _mockMessages.add(newMessage);
    
    return newMessage;
  }

  Future<void> markMessagesAsRead(String vendorId) async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 200));
    
    // Mark messages as read
    for (int i = 0; i < _mockMessages.length; i++) {
      final message = _mockMessages[i];
      if (message.receiverId == 'user_123' && message.senderId == vendorId) {
        _mockMessages[i] = message.copyWith(isRead: true);
      }
    }
  }

  Future<void> deleteChat(String vendorId) async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 300));
    
    // Remove messages and inbox entry
    _mockMessages.removeWhere((message) => 
      message.senderId == vendorId || message.receiverId == vendorId
    );
    _mockInbox.removeWhere((chat) => chat.vendorId == vendorId);
  }
}

class InboxChat {
  final String id;
  final String vendorId;
  final String vendorName;
  final String vendorImage;
  final String lastMessage;
  final String date;
  final bool isVerified;
  final bool isUnread;

  InboxChat({
    required this.id,
    required this.vendorId,
    required this.vendorName,
    required this.vendorImage,
    required this.lastMessage,
    required this.date,
    required this.isVerified,
    required this.isUnread,
  });
}
