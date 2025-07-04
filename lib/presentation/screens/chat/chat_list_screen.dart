import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/controllers/chat_list_controller.dart';
import '../new_chat_screen.dart';
import 'chat_screen.dart';


class ChatListScreen extends StatelessWidget {

  final ChatListController chatListController = Get.put(ChatListController());

  ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    chatListController.fetchChats();

    return Scaffold(
      appBar: AppBar(title: const Text('Chats')),
      body: Obx(() {
        if (chatListController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (chatListController.chats.isEmpty) {
          return const Center(child: Text('No chats yet'));
        }
        return ListView.builder(
          itemCount: chatListController.chats.length,
          itemBuilder: (context, index) {
            final chat = chatListController.chats[index];
            final lastMessage = chat['last_message'];

            return ListTile(
              leading: CircleAvatar(
                backgroundImage: chat['avatar_url'] != null
                    ? NetworkImage(chat['avatar_url'])
                    : null,
                child: chat['avatar_url'] == null ? const Icon(Icons.chat) : null,
              ),
              title: Text(chat['name']),
              subtitle: Text(
                lastMessage != null ? lastMessage['content'] : 'No messages yet',
              ),
              onTap: () {
                Get.to(() => ChatScreen(chatId: chat['id']));
              },
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Get.to(() => NewChatScreen());
        },
      ),
    );
  }
}
