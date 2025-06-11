String defaultImg = "lib/assets/store.png";

String getAmenityImage(String amenityName) {
  final amenity = amenitiesImage.firstWhere(
    (item) => item['name']?.toLowerCase() == amenityName.toLowerCase(),
    orElse: () => {'image': defaultImg},
  );
  return amenity['image'];
}

final List<Map<String, dynamic>> amenitiesImage = [
  {
    'name': 'Club House',
    'image': "lib/assets/club.png",
  },
  {
    'name': 'Swimming Pool',
    'image': "lib/assets/swimming-pool.png",
  },
  {
    'name': 'Garden',
    'image': "lib/assets/garden.png",
  },
  {
    'name': 'Parking',
    'image': "lib/assets/parking.png",
  },
  {
    'name': 'Gym',
    'image': "lib/assets/gym.png",
  },
  {
    'name': 'Playground',
    'image': "lib/assets/playground.png",
  },
  {
    'name': 'Clubhouse',
    'image': "lib/assets/club.png",
  },
  {
    'name': 'Spa',
    'image': "lib/assets/spa.png",
  },
  {
    'name': 'Building Wi-Fi',
    'image': "lib/assets/wifi.png",
  },
  {
    'name': 'Rooftop Garden',
    'image': "lib/assets/roof-top.png",
  },
];
