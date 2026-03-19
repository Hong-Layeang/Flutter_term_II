import 'package:blabla/model/ride/locations.dart';

abstract class LocationRepository {
  List<Location> getAll();
  List<Location> search(String query);
}