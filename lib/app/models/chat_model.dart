import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get/get.dart';

class SupabaseService extends GetxService {
  final SupabaseClient _client = Supabase.instance.client;

  SupabaseClient get client => _client;

  // Example function to get a user's profile
  Future<Map<String, dynamic>?> getUserProfile(String userId) async {
    final response = await _client
        .from('users')
        .select('*')
        .eq('id', userId)
        .single();
    return response;
  }

// Add more methods for sending messages, creating chats, etc.
}