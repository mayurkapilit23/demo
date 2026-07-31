import '../models/memory_location_model.dart';

abstract class MockMemoryDatasource {
  Future<List<MemoryLocationModel>> getMockMemories();
}

class MockMemoryDatasourceImpl implements MockMemoryDatasource {
  @override
  Future<List<MemoryLocationModel>> getMockMemories() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    return [
      MemoryLocationModel(
        id: '1',
        title: 'Goa Trip',
        description: 'Beautiful beach sunset and seafood.',
        imageUrl: 'https://picsum.photos/seed/goa/300',
        latitude: 15.2993,
        longitude: 74.1240,
        createdAt: DateTime(2025, 12, 1),
      ),
      MemoryLocationModel(
        id: '2',
        title: 'Mumbai Marine Drive',
        description: 'Late night walk by the sea.',
        imageUrl: 'https://picsum.photos/seed/mumbai/300',
        latitude: 19.0760,
        longitude: 72.8777,
        createdAt: DateTime(2024, 11, 15),
      ),
      MemoryLocationModel(
        id: '3',
        title: 'Hyderabad Biryani',
        description: 'Best biryani experience at Paradise.',
        imageUrl: 'https://picsum.photos/seed/hyderabad/300',
        latitude: 17.3850,
        longitude: 78.4867,
        createdAt: DateTime(2024, 10, 20),
      ),
      MemoryLocationModel(
        id: '4',
        title: 'Delhi Red Fort',
        description: 'Exploring the rich history of India.',
        imageUrl: 'https://picsum.photos/seed/delhi/300',
        latitude: 28.6139,
        longitude: 77.2090,
        createdAt: DateTime(2024, 9, 5),
      ),
      MemoryLocationModel(
        id: '5',
        title: 'Pune Shaniwar Wada',
        description: 'Historical fort in the heart of the city.',
        imageUrl: 'https://picsum.photos/seed/pune/300',
        latitude: 18.5204,
        longitude: 73.8567,
        createdAt: DateTime(2024, 8, 12),
      ),
      MemoryLocationModel(
        id: '6',
        title: 'Jaipur Pink City',
        description: 'Breathtaking architecture and culture.',
        imageUrl: 'https://picsum.photos/seed/jaipur/300',
        latitude: 26.9124,
        longitude: 75.7873,
        createdAt: DateTime(2024, 7, 25),
      ),
      MemoryLocationModel(
        id: '7',
        title: 'Bengaluru IT Hub',
        description: 'Visiting the Garden City of India.',
        imageUrl: 'https://picsum.photos/seed/bengaluru/300',
        latitude: 12.9716,
        longitude: 77.5946,
        createdAt: DateTime(2024, 6, 18),
      ),
      MemoryLocationModel(
        id: '8',
        title: 'Kashmir Paradise',
        description: 'Dal Lake and snow-capped mountains.',
        imageUrl: 'https://picsum.photos/seed/kashmir/300',
        latitude: 34.0837,
        longitude: 74.7973,
        createdAt: DateTime(2024, 5, 10),
      ),
      MemoryLocationModel(
        id: '9',
        title: 'Kerala Backwaters',
        description: 'Serene houseboat stay in Alleppey.',
        imageUrl: 'https://picsum.photos/seed/kerala/300',
        latitude: 10.8505,
        longitude: 76.2711,
        createdAt: DateTime(2024, 4, 22),
      ),
      MemoryLocationModel(
        id: '10',
        title: 'Manali Mountains',
        description: 'Adventure and trekking in the Himalayas.',
        imageUrl: 'https://picsum.photos/seed/manali/300',
        latitude: 32.2432,
        longitude: 77.1892,
        createdAt: DateTime(2024, 3, 15),
      ),
    ];
  }
}
