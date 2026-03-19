import 'package:blabla/data/dummy_data.dart';
import 'package:blabla/data/repositories/rides/ride_repository.dart';
import 'package:blabla/model/ride/ride.dart';
import 'package:blabla/model/ride_pref/ride_pref.dart';

class RideRepositoryMock implements RideRepository {
  RideRepositoryMock._();

  static final RideRepositoryMock instance = RideRepositoryMock._();

  final List<Ride> _allRides = fakeRides;

  @override
  List<Ride> getRidesFor(RidePreference preference) {
    return _allRides.where((ride) {
      return ride.departureLocation == preference.departure &&
        ride.arrivalLocation == preference.arrival &&
        ride.availableSeats >= preference.requestedSeats;
    }).toList();
  }
}