import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yap/presentation/screens/onboarding_screen.dart';
import 'package:yap/utils/constants.dart';

import 'bindings.dart';


void main()async  {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  await Supabase.initialize(
    url: Secrets.supabaseUrl,
    anonKey: Secrets.supabaseKey,
  );
  runApp(

      MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialBinding: InitialBinding(),
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: OnboardingScreen(),
    );
  }
}
