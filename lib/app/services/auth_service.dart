//not used anymore since i switched to getx
import 'package:get/get.dart';
// import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class AuthService{
  final SupabaseClient supabase = Supabase.instance.client;
  Future<void> signUp(String email , String password)async {
    try{
    final response = await supabase.auth.signUp(email:email,password: password);

    if(response.user!=null){
      Get.snackbar('Success', 'Signed up as ${
          response.user!.email
      }');
    }else {

      Get.snackbar(
        'Sign Up Failed',
        'Something went wrong. Try again.',
      );}



  }catch(e){
      Get.snackbar(
          'Error',
          e.toString().replaceAll('Exception: ', ''),);//just to make error snack bar smaller and more readable
    }
  }

}