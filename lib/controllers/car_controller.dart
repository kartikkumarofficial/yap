import 'package:get/get.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../data/models/car_model.dart';

class CarController extends GetxController {
  final cars = <CarModel>[].obs;
  final isLoading = false.obs;

  final SupabaseClient supabase = Supabase.instance.client;

  @override
  void onInit() {
    fetchCars();
    super.onInit();
  }

  Future<void> fetchCars() async {
    isLoading.value = true;
    try {
      final response = await supabase.from('cars').select();
      final carList = (response as List)
          .map((e) => CarModel.fromMap(e as Map<String, dynamic>))
          .toList();
      cars.assignAll(carList);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch cars');
    } finally {
      isLoading.value = false;
    }
  }
}
