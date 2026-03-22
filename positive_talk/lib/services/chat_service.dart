import '../models/message_model.dart';
import '../models/inbox_chat_model.dart';
import '../core/api/api_client.dart';
import 'user_service.dart';

class ChatService {
  static final ChatService _instance = ChatService._internal();
  factory ChatService() => _instance;
  ChatService._internal();

  // Get inbox chats
  Future<List<InboxChat>> getInboxChats() async {
    try {
      final apiClient = ApiClient();
      final response = await apiClient.get('/user/profile', requireAuth: true);

      final userData = apiClient.handleResponse(response);
      final user = userData['user'];

      // Get all messages to build inbox
      final messagesResponse = await apiClient.get(
        '/chat/history/${user['_id']}/all',
        requireAuth: true,
      );
      final messagesData = apiClient.handleListResponse(messagesResponse);

      // Build inbox chats from messages
      final Map<String, InboxChat> chatMap = {};

      for (var messageJson in messagesData) {
        final message = Message.fromJson(messageJson);
        final isFromUser = message.senderId == user['_id'];
        final vendorId = isFromUser ? message.receiverId : message.senderId;

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

      return chatMap.values.toList()
        ..sort((a, b) => b.lastMessageTime.compareTo(a.lastMessageTime));
    } catch (e) {
      throw Exception('Failed to load inbox chats: $e');
    }
  }

  // Get messages for a specific vendor
  Future<List<Message>> getMessages(String vendorId) async {
    try {
      final apiClient = ApiClient();
      final userService = UserService();
      final user = await userService.getCurrentUser();

      if (user == null) {
        throw Exception('User not authenticated');
      }

      final response = await apiClient.get(
        '/chat/history/${user.id}/$vendorId',
        requireAuth: true,
      );

      final messagesData = apiClient.handleListResponse(response);
      return messagesData.map((json) => Message.fromJson(json)).toList()
        ..sort((a, b) => a.timestamp.compareTo(b.timestamp));
    } catch (e) {
      throw Exception('Failed to load messages: $e');
    }
  }

  // Send a message
  Future<Message> sendMessage(String vendorId, String text) async {
    try {
      final apiClient = ApiClient();
      final userService = UserService();
      final user = await userService.getCurrentUser();

      if (user == null) {
        throw Exception('User not authenticated');
      }

      final response = await apiClient.post(
        '/chat/send',
        requireAuth: true,
        body: {'receiverId': vendorId, 'text': text},
      );

      final messageData = apiClient.handleResponse(response);
      return Message.fromJson(messageData);
    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }

  // Helper methods for vendor data (temporary until we have vendor API integration)
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
}
