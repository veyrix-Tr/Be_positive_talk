import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/message_model.dart';
import '../models/inbox_chat_model.dart';

class ChatService {
  static final ChatService _instance = ChatService._internal();
  factory ChatService() => _instance;
  ChatService._internal();

  List<Message> _messages = [];
  List<InboxChat> _inboxChats = [];

  // Load messages from JSON file
  Future<void> _loadMessages() async {
    if (_messages.isNotEmpty) return;

    try {
      final String jsonString = await rootBundle.loadString(
        'assets/data/messages.json',
      );
      final Map<String, dynamic> data = json.decode(jsonString);
      final List<dynamic> messagesList = data['messages'];

      _messages = messagesList.map((json) => Message.fromJson(json)).toList();
    } catch (e) {
      // Fallback to empty list if JSON loading fails
      _messages = [];
    }
  }

  // Load inbox chats from JSON file
  Future<void> _loadInboxChats() async {
    if (_inboxChats.isNotEmpty) return;

    try {
      final String jsonString = await rootBundle.loadString(
        'assets/data/messages.json',
      );
      final Map<String, dynamic> data = json.decode(jsonString);
      final List<dynamic> messagesList = data['messages'];

      // Create inbox chats from messages
      final Map<String, InboxChat> chatMap = {};

      for (var messageJson in messagesList) {
        final message = Message.fromJson(messageJson);
        final isFromUser = message.senderId.startsWith('user');
        final vendorId = isFromUser ? message.receiverId : message.senderId;
        final userId = isFromUser ? message.senderId : message.receiverId;

        // Only process messages for current user (user_001)
        if (userId == 'user_001') {
          if (!chatMap.containsKey(vendorId)) {
            chatMap[vendorId] = InboxChat(
              id: 'chat_$vendorId',
              vendorId: vendorId,
              vendorName: _getVendorName(vendorId),
              vendorImage: 'assets/profile1.png',
              lastMessage: message.text,
              lastMessageTime: message.timestamp,
              unreadCount: !message.isRead && !isFromUser ? 1 : 0,
              isOnline: _getVendorOnlineStatus(vendorId),
            );
          } else {
            // Update last message and unread count
            final chat = chatMap[vendorId]!;
            chatMap[vendorId] = InboxChat(
              id: chat.id,
              vendorId: chat.vendorId,
              vendorName: chat.vendorName,
              vendorImage: chat.vendorImage,
              lastMessage: message.text,
              lastMessageTime: message.timestamp,
              unreadCount:
                  chat.unreadCount + (!message.isRead && !isFromUser ? 1 : 0),
              isOnline: chat.isOnline,
            );
          }
        }
      }

      _inboxChats = chatMap.values.toList()
        ..sort((a, b) => b.lastMessageTime.compareTo(a.lastMessageTime));
    } catch (e) {
      // Fallback to empty list if JSON loading fails
      _inboxChats = [];
    }
  }

  // Helper methods for vendor data (simplified for now)
  String _getVendorName(String vendorId) {
    final names = {
      'vendor_001': 'Emma Thompson',
      'vendor_002': 'David Martinez',
      'vendor_003': 'Lisa Anderson',
      'vendor_004': 'James Wilson',
      'vendor_005': 'Sophie Turner',
    };
    return names[vendorId] ?? 'Unknown Vendor';
  }

  bool _getVendorOnlineStatus(String vendorId) {
    final statuses = {
      'vendor_001': true,
      'vendor_002': true,
      'vendor_003': false,
      'vendor_004': true,
      'vendor_005': false,
    };
    return statuses[vendorId] ?? false;
  }

  // Get inbox chats
  Future<List<InboxChat>> getInboxChats() async {
    await _loadInboxChats();

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 600));

    return _inboxChats;
  }

  // Get messages for a specific vendor
  Future<List<Message>> getMessages(String vendorId) async {
    await _loadMessages();

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Filter messages for the specific vendor and current user
    return _messages
        .where(
          (message) =>
              (message.senderId == 'user_001' &&
                  message.receiverId == vendorId) ||
              (message.receiverId == 'user_001' &&
                  message.senderId == vendorId),
        )
        .toList()
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));
  }

  // Send a message
  Future<Message> sendMessage(String vendorId, String text) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    final newMessage = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderId: 'user_001', // Mock current user ID
      receiverId: vendorId,
      text: text,
      timestamp: DateTime.now(),
      isRead: false,
    );

    // Add to loaded messages
    _messages.add(newMessage);

    return newMessage;
  }
}
