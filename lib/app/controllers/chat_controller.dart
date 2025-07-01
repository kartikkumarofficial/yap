import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatController extends GetxController {
  final supabase = Supabase.instance.client;

  var messages = [].obs;
  var isLoading = false.obs;

  String chatId = '';

  RealtimeChannel? _subscription;

  void init(String chatId) {
    this.chatId = chatId;
    fetchMessages();
    subscribeToMessages();
  }

  Future<void> fetchMessages() async {
    try {
      isLoading.value = true;
      final response = await supabase
          .from('messages')
          .select()
          .eq('chat_id', chatId)
          .order('sent_at');

      messages.value = response;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load messages: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void subscribeToMessages() {
    _subscription = supabase
        .channel('public:messages')
        .onPostgresChanges(
      event: PostgresChangeEvent.insert,
      schema: 'public',
      table: 'messages',
      callback: (payload) {
        messages.add(payload.newRecord);
      },
    )

        .subscribe();
  }


  Future<void> sendMessage(String content) async {
    final user = supabase.auth.currentUser;
    if (user == null) return;
    if (content.trim().isEmpty) return;

    await supabase.from('messages').insert({
      'chat_id': chatId,
      'sender_id': user.id,
      'content': content.trim(),
    });
  }

  @override
  void onClose() {
    _subscription?.unsubscribe();
    super.onClose();
  }
}
