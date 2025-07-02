import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatListController extends GetxController {
  final supabase = Supabase.instance.client;

  var chats = [].obs;
  var isLoading = false.obs;

  Future<void> fetchChats() async {
    try {
      isLoading.value = true;
      final user = supabase.auth.currentUser;
      if (user == null) return;

      final response = await supabase
          .from('chat_members')
          .select('chat_id, chats(id, name, avatar_url, created_at)')
          .eq('user_id', user.id);

      final List chatList = response;

      List<Map<String, dynamic>> enrichedChats = [];
      for (var item in chatList) {
        final chat = item['chats'];

        final lastMessageResponse = await supabase
            .from('messages')
            .select()
            .eq('chat_id', chat['id'])
            .order('sent_at', ascending: false)
            .limit(1);

        final lastMessage = lastMessageResponse.isNotEmpty
            ? lastMessageResponse.first
            : null;

        enrichedChats.add({
          'id': chat['id'],
          'name': chat['name'],
          'avatar_url': chat['avatar_url'],
          'created_at': chat['created_at'],
          'last_message': lastMessage,
        });
      }

      chats.value = enrichedChats;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load chats: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
