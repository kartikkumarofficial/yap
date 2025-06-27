class CarModel {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double pricePerDay;
  final String location;
  final double fuelCapacity;
  final String transmission;
  final int seats;
  final double latitude;
  final double longitude;

  CarModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.pricePerDay,
    required this.location,
    required this.fuelCapacity,
    required this.transmission,
    required this.seats,
    required this.latitude,
    required this.longitude,
  });

  factory CarModel.fromMap(Map<String, dynamic> map) {
    return CarModel(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      imageUrl: (map['images'] as List).isNotEmpty ? map['images'][0] : '',
      pricePerDay: (map['price_per_day'] as num).toDouble(),
      location: map['location'] as String,
      fuelCapacity: (map['fuelCapacity'] as num).toDouble(),
      transmission: map['transmission'] ?? 'Auto',
      seats: map['seats'] ?? 5,


      latitude: (map['latitude'] != null) ? (map['latitude'] as num).toDouble() : 30.3165,
      longitude: (map['longitude'] != null) ? (map['longitude'] as num).toDouble() : 78.0322,
    );
  }

}
