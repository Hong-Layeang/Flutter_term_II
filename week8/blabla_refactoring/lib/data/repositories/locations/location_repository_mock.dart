import 'package:blabla/data/dummy_data.dart';
import 'package:blabla/data/repositories/locations/location_repository.dart';
import 'package:blabla/model/ride/locations.dart';

class LocationRepositoryMock implements LocationRepository {
  LocationRepositoryMock._();

  static final LocationRepositoryMock instace = LocationRepositoryMock._();

  final List<Location> _locations = fakeLocations;

  @override
  List<Location> getAll() => List.unmodifiable(_locations);

  @override
  List<Location> search(String query) {
    final normalized = query.trim().toLowerCase();
    if (normalized.length < 2) return [];

    return _locations.where((location) {
      final name = location.name.toLowerCase();
      final country = location.country.name.toLowerCase();
      return name.contains(normalized) || country.contains(normalized);
    }).toList();
  }
}