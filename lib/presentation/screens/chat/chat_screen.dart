import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/controllers/chat_controller.dart';
import '../../../app/controllers/chat_list_controller.dart';

class ChatScreen extends StatefulWidget {
  final String chatId;

  const ChatScreen({super.key, required this.chatId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatController chatController = Get.find<ChatController>();
  final ChatListController chatListController = Get.find<ChatListController>();
  final TextEditingController messageController = TextEditingController();

  Map<String, dynamic>? chatDetails;

  @override
  void initState() {
    super.initState();
    chatController.fetchMessages(widget.chatId);
    chatController.subscribeToMessages(widget.chatId);
    fetchChatDetails();
  }

  @override
  void dispose() {
    chatController.unsubscribeMessages();
    messageController.dispose();
    super.dispose();
  }

  void fetchChatDetails() {
    final chat = chatListController.chats
        .firstWhereOrNull((c) => c['id'] == widget.chatId);
    setState(() {
      chatDetails = chat;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId = chatController.supabase.auth.currentUser!.id;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: chatDetails?['avatar_url'] != null &&
                  chatDetails?['avatar_url'] != ''
                  ? NetworkImage(chatDetails!['avatar_url'])
                  : null,
              child: (chatDetails?['avatar_url'] == null ||
                  chatDetails?['avatar_url'] == '')
                  ? const Icon(Icons.person, size: 18)
                  : null,
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                chatDetails?['name'] ?? 'Chat',
                style: const TextStyle(fontSize: 18),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              final messages = chatController.messages.reversed.toList();
              return ListView.builder(
                reverse: false,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  final isMe = message['sender_id'] == currentUserId;

                  return Align(
                    alignment:
                    isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 10),
                      constraints:
                      BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                      decoration: BoxDecoration(
                        color: isMe ? Colors.blueAccent : Colors.grey[300],
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(16),
                          topRight: const Radius.circular(16),
                          bottomLeft: isMe
                              ? const Radius.circular(16)
                              : const Radius.circular(0),
                          bottomRight: isMe
                              ? const Radius.circular(0)
                              : const Radius.circular(16),
                        ),
                      ),
                      child: Text(
                        message['content'],
                        style: TextStyle(
                          color: isMe ? Colors.white : Colors.black87,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: const InputDecoration(
                        hintText: 'Type your message...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.blueAccent),
                    onPressed: () {
                      final text = messageController.text.trim();
                      if (text.isNotEmpty) {
                        chatController.sendMessage(widget.chatId, text);
                        messageController.clear();
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
