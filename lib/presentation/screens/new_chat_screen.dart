import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../app/controllers/chat_list_controller.dart';
import '../../../app/services/cloudinary_service.dart';
import 'chat/chat_screen.dart';


class NewChatScreen extends StatefulWidget {
  const NewChatScreen({super.key});

  @override
  State<NewChatScreen> createState() => _NewChatScreenState();
}

class _NewChatScreenState extends State<NewChatScreen> {
  final supabase = Supabase.instance.client;
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  File? pickedImageFile;
  String? uploadedAvatarUrl;
  bool isLoading = false;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        pickedImageFile = File(image.path);
      });
      await uploadImageToCloudinary(pickedImageFile!);
    }
  }

  Future<void> uploadImageToCloudinary(File imageFile) async {
    setState(() {
      isLoading = true;
    });
    final url = await CloudinaryService.uploadImage(imageFile);
    if (url != null) {
      setState(() {
        uploadedAvatarUrl = url;
      });
      Get.snackbar('Success', 'Image uploaded successfully.');
    } else {
      Get.snackbar('Error', 'Failed to upload image.');
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> createChat() async {
    final email = emailController.text.trim();
    final name = nameController.text.trim();

    if (email.isEmpty || name.isEmpty) {
      Get.snackbar('Error', 'Email and chat name are required.');
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final userResponse = await supabase
          .from('users')
          .select('id')
          .eq('email', email)
          .single();

      if (userResponse == null) {
        Get.snackbar('Error', 'User not found.');
        return;
      }

      final otherUserId = userResponse['id'];
      final currentUserId = supabase.auth.currentUser!.id;

      final chatResponse = await supabase
          .from('chats')
          .insert({
        'name': name,
        'avatar_url': uploadedAvatarUrl ?? '',
        'created_at': DateTime.now().toIso8601String(),
        'type': 'private',
        'last_message': null,
        'last_updated': DateTime.now().toIso8601String(),
      })
          .select()
          .single();

      final chatId = chatResponse['id'];

      await supabase.from('chat_members').insert([
        {'chat_id': chatId, 'user_id': currentUserId},
        {'chat_id': chatId, 'user_id': otherUserId},
      ]);

      final chatListController = Get.find<ChatListController>();
      await chatListController.fetchChats();

      Get.back();
      Get.to(() => ChatScreen(chatId: chatId));
    } catch (e) {
      Get.snackbar('Error', 'Failed to create chat: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Chat')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: pickImage,
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: pickedImageFile != null
                      ? FileImage(pickedImageFile!)
                      : (uploadedAvatarUrl != null
                      ? NetworkImage(uploadedAvatarUrl!)
                      : null) as ImageProvider<Object>?,
                  child: pickedImageFile == null && uploadedAvatarUrl == null
                      ? const Icon(Icons.add_a_photo)
                      : null,
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'User Email',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Chat Name',
                ),
              ),
              const SizedBox(height: 24),
              isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: createChat,
                child: const Text('Create Chat'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
