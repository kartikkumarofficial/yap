import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatController extends GetxController {
  final supabase = Supabase.instance.client;

  RxList<Map<String, dynamic>> messages = <Map<String, dynamic>>[].obs;
  RealtimeChannel? _messageChannel;



  Future<void> fetchMessages(String chatId) async {
    try {
      final response = await supabase
          .from('messages')
          .select()
          .eq('chat_id', chatId)
          .order('sent_at');
      messages.value = response;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load messages: $e');
    }
  }


  void subscribeToMessages(String chatId) {
    _messageChannel?.unsubscribe();

    _messageChannel = supabase
        .channel('public:messages')
        .onPostgresChanges(
      event: PostgresChangeEvent.all,
      table: 'messages',
      filter: PostgresChangeFilter(
        type: PostgresChangeFilterType.eq,
        column: 'chat_id',
        value: chatId,
      ),
      callback: (payload) {
        fetchMessages(chatId);
      },
    )
        .subscribe();
  }


  void unsubscribeMessages() {
    _messageChannel?.unsubscribe();
    _messageChannel = null;
  }


  Future<void> sendMessage(String chatId, String content) async {
    final userId = supabase.auth.currentUser!.id;
    try {
      await supabase.from('messages').insert({
        'chat_id': chatId,
        'sender_id': userId,
        'content': content,
        'type': 'text',
        'sent_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      Get.snackbar('Error', 'Failed to send message: $e');
    }
  }
}
