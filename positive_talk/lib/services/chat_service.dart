import '../models/message_model.dart';
import '../models/inbox_chat_model.dart';

class ChatService {
  static final ChatService _instance = ChatService._internal();
  factory ChatService() => _instance;
  ChatService._internal();

  // Mock message data
  final Map<String, List<Message>> _mockMessages = {
    '1': [
      Message(
        id: '1',
        senderId: 'user1',
        receiverId: '1',
        text: 'Hello Aashna, I need some career advice.',
        timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
        isRead: true,
      ),
      Message(
        id: '2',
        senderId: '1',
        receiverId: 'user1',
        text:
            'Hi! I\'d be happy to help. What specific area are you looking to get guidance on?',
        timestamp: DateTime.now().subtract(const Duration(minutes: 28)),
        isRead: true,
      ),
      Message(
        id: '3',
        senderId: 'user1',
        receiverId: '1',
        text: 'I\'m considering a career change but feeling uncertain.',
        timestamp: DateTime.now().subtract(const Duration(minutes: 25)),
        isRead: false,
      ),
    ],
    '2': [
      Message(
        id: '4',
        senderId: 'user1',
        receiverId: '2',
        text:
            'Hi Priya, I\'m interested in your relationship counseling services.',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        isRead: true,
      ),
      Message(
        id: '5',
        senderId: '2',
        receiverId: 'user1',
        text:
            'Hello! Thank you for your interest. I\'d love to help you. When would you like to schedule our first session?',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        isRead: true,
      ),
    ],
    '3': [
      Message(
        id: '6',
        senderId: 'user1',
        receiverId: '3',
        text: 'Rajesh, I need business strategy advice for my startup.',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        isRead: true,
      ),
    ],
  };

  // Mock inbox chats data
  final List<Map<String, dynamic>> _mockInboxChats = [
    {
      'id': 'chat1',
      'vendorId': '1',
      'vendorName': 'Aashna',
      'vendorImage': 'assets/profile1.png',
      'lastMessage': 'I\'m considering a career change but feeling uncertain.',
      'lastMessageTime': DateTime.now().subtract(const Duration(minutes: 25)),
      'unreadCount': 1,
      'isOnline': true,
    },
    {
      'id': 'chat2',
      'vendorId': '2',
      'vendorName': 'Priya',
      'vendorImage': 'assets/profile2.png',
      'lastMessage':
          'Hello! Thank you for your interest. I\'d love to help you.',
      'lastMessageTime': DateTime.now().subtract(const Duration(hours: 2)),
      'unreadCount': 0,
      'isOnline': true,
    },
    {
      'id': 'chat3',
      'vendorId': '3',
      'vendorName': 'Rajesh',
      'vendorImage': 'assets/profile3.png',
      'lastMessage': 'Rajesh, I need business strategy advice for my startup.',
      'lastMessageTime': DateTime.now().subtract(const Duration(days: 1)),
      'unreadCount': 0,
      'isOnline': false,
    },
  ];

  // Get inbox chats
  Future<List<InboxChat>> getInboxChats() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 600));

    return _mockInboxChats
        .map(
          (chatData) => InboxChat(
            id: chatData['id'] as String,
            vendorId: chatData['vendorId'] as String,
            vendorName: chatData['vendorName'] as String,
            vendorImage: chatData['vendorImage'] as String,
            lastMessage: chatData['lastMessage'] as String,
            lastMessageTime: chatData['lastMessageTime'] as DateTime,
            unreadCount: chatData['unreadCount'] as int,
            isOnline: chatData['isOnline'] as bool,
          ),
        )
        .toList();
  }

  // Get messages for a specific vendor
  Future<List<Message>> getMessages(String vendorId) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    return _mockMessages[vendorId] ?? [];
  }

  // Send a message
  Future<Message> sendMessage(String vendorId, String text) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    final newMessage = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderId: 'user1', // Mock current user ID
      receiverId: vendorId,
      text: text,
      timestamp: DateTime.now(),
      isRead: false,
    );

    // Add to mock messages
    if (_mockMessages.containsKey(vendorId)) {
      _mockMessages[vendorId]!.add(newMessage);
    } else {
      _mockMessages[vendorId] = [newMessage];
    }

    return newMessage;
  }
}
