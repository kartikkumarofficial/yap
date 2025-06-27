import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BookingController extends GetxController {
  final SupabaseClient supabase = Supabase.instance.client;
  final String carId;

  BookingController(this.carId);

  final startDate = DateTime.now().obs;
  final endDate = DateTime.now().add(const Duration(days: 1)).obs;
  final startTime = TimeOfDay(hour: 9, minute: 0).obs;
  final endTime = TimeOfDay(hour: 18, minute: 0).obs;

  final isChecking = false.obs;
  final isAvailable = true.obs;


  Future<void> selectDateRange() async {
    final picked = await showDateRangePicker(
      context: Get.context!,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      startDate.value = picked.start;
      endDate.value = picked.end;
    }
  }

  Future<void> selectTime(bool isStart) async {
    final picked = await showTimePicker(
      context: Get.context!,
      initialTime: isStart ? startTime.value : endTime.value,
    );

    if (picked != null) {
      if (isStart) {
        startTime.value = picked;
      } else {
        endTime.value = picked;
      }
    }
  }


  String formatDate(DateTime date) {
    return DateFormat('MMM d, yyyy').format(date);
  }

  String formatTime(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('h:mm a').format(dt);
  }

  Future<bool> checkAvailability() async {
    isChecking.value = true;

    final from = DateTime(
      startDate.value.year,
      startDate.value.month,
      startDate.value.day,
      startTime.value.hour,
      startTime.value.minute,
    );

    final to = DateTime(
      endDate.value.year,
      endDate.value.month,
      endDate.value.day,
      endTime.value.hour,
      endTime.value.minute,
    );

    try {
      debugPrint('[BookingController] Checking from: $from to: $to');

      final response = await supabase
          .from('bookings')
          .select()
          .eq('car_id', carId)
          .lt('start_time', to.toIso8601String()) // where start_time < new end
          .gt('end_time', from.toIso8601String()); // and end_time > new start

      debugPrint('[BookingController] Conflicting bookings: ${response.length}');

      isChecking.value = false;
      isAvailable.value = response.isEmpty;
      return response.isEmpty;
    } catch (e) {
      debugPrint('[BookingController] Availability check failed: $e');
      isChecking.value = false;
      Get.snackbar('Error', 'Failed to check availability', snackPosition: SnackPosition.BOTTOM);
      return false;
    }
  }



  Future<void> bookCar() async {
    final from = DateTime(
      startDate.value.year,
      startDate.value.month,
      startDate.value.day,
      startTime.value.hour,
      startTime.value.minute,
    );

    final to = DateTime(
      endDate.value.year,
      endDate.value.month,
      endDate.value.day,
      endTime.value.hour,
      endTime.value.minute,
    );

    final available = await checkAvailability();

    if (!available) {
      Future.delayed(Duration(milliseconds: 100), () {
        Get.snackbar(
          'Unavailable',
          'This car is already booked for the selected time.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.shade100,
          colorText: Colors.red.shade900,
        );
      });
      return;
    }



    try {
      await supabase.from('bookings').insert({
        'car_id': carId,
        'user_id': supabase.auth.currentUser!.id,
        'start_time': from.toIso8601String(),
        'end_time': to.toIso8601String(),
        'status': 'confirmed',
      });

      Get.snackbar('Success', 'Your car has been booked!',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      print(e.toString());
      Get.snackbar('Booking Error', 'Something went wrong while booking: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
