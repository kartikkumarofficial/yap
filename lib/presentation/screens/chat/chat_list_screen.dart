import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../app/controllers/chat_list_controller.dart';
import 'chat_screen.dart'; // we'll create this next

class ChatListScreen extends StatelessWidget {
  final ChatListController controller = Get.put(ChatListController());

  ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.fetchChats();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chats',
          style: GoogleFonts.poppins(),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return   Center(child: CircularProgressIndicator());
        }
        if (controller.chats.isEmpty) {
          return   Center(child: Text('No chats yet.'));
        }
        return ListView.separated(
          itemCount: controller.chats.length,
          separatorBuilder: (_, __) =>   Divider(height: 1),
          itemBuilder: (context, index) {
            final chat = controller.chats[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: chat['avatar_url'] != null
                    ? NetworkImage(chat['avatar_url'])
                    :   AssetImage('assets/default_chat.png')
                as ImageProvider,
              ),
              title: Text(chat['name'] ?? 'Unnamed Chat'),
              subtitle: Text(
                chat['last_message']?['content'] ?? 'No messages yet',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: chat['last_message']?['sent_at'] != null
                  ? Text(
                _formatTimestamp(chat['last_message']!['sent_at']),
                style:   TextStyle(fontSize: 12, color: Colors.grey),
              )
                  : null,
              onTap: () {
                Get.to(() => ChatScreen(chatId: chat['id']));
              },
            );
          },
        );
      }),
    );
  }

  String _formatTimestamp(String timestamp) {
    final dt = DateTime.tryParse(timestamp);
    if (dt == null) return '';
    return '${dt.hour}:${dt.minute.toString().padLeft(2, '0')}';
  }
}
